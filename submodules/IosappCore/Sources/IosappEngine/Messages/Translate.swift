import Foundation
import Postbox
import SwiftSignalKit
internal import IosappApi
import MtProtoKit

public enum ComposedRichMessage: Equatable {
    /// Structured content → a rich message (`RichTextMessageAttribute(instantPage:)`, sent with `text: ""`).
    case rich(instantPage: InstantPage)
    /// Entity-expressible content → a normal message (`text` + `TextEntitiesMessageAttribute`).
    case plain(text: String, entities: [MessageTextEntity])
    /// Nothing worth sending (empty / whitespace-only document).
    case empty
}

public enum TranslationError {
    case generic
    case invalidMessageId
    case textIsEmpty
    case textTooLong
    case invalidLanguage
    case limitExceeded
    case tryAlternative
}

public enum TranslationTone: String {
    case neutral
    case casual
    case formal
}

func _internal_translate(network: Network, text: String, toLang: String, entities: [MessageTextEntity] = [], tone: TranslationTone = .neutral, peer: Api.InputPeer? = nil, messageId: Int32? = nil) -> Signal<(String, [MessageTextEntity])?, TranslationError> {
    var flags: Int32 = 0


    let apiText: [Api.TextWithEntities]?
    if peer != nil && messageId != nil {
        flags |= (1 << 0)
        apiText = nil
    } else {
        flags |= (1 << 1)
        apiText = [.textWithEntities(.init(text: text, entities: apiEntitiesFromMessageTextEntities(entities, associatedPeers: SimpleDictionary())))]
    }

    return network.request(Api.functions.messages.translateText(flags: flags, peer: peer, id: messageId.flatMap { [$0] }, text: apiText, toLang: toLang, tone: nil))
    |> mapError { error -> TranslationError in
        if error.errorDescription.hasPrefix("FLOOD_WAIT") {
            return .limitExceeded
        } else if error.errorDescription == "MSG_ID_INVALID" {
            return .invalidMessageId
        } else if error.errorDescription == "INPUT_TEXT_EMPTY" {
            return .textIsEmpty
        } else if error.errorDescription == "INPUT_TEXT_TOO_LONG" {
            return .textTooLong
        } else if error.errorDescription == "TO_LANG_INVALID" {
            return .invalidLanguage
        } else if error.errorDescription == "TRANSLATIONS_DISABLED_ALT" {
            return .tryAlternative
        } else {
            return .generic
        }
    }
    |> mapToSignal { result -> Signal<(String, [MessageTextEntity])?, TranslationError> in
        switch result {
        case let .translateResult(translateResultData):
            let results = translateResultData.result
            if case let .textWithEntities(textWithEntitiesData) = results.first {
                let (text, entities) = (textWithEntitiesData.text, textWithEntitiesData.entities)
                return .single((text, messageTextEntitiesFromApiEntities(entities)))
            } else {
                return .single(nil)
            }
        }
    }
}

func _internal_composeMessageWithAI(account: Account, text: String, entities: [MessageTextEntity], proofread: Bool = false, translateToLang: String? = nil, changeStyle: IosappComposeAIMessageMode.CloudStyle.Reference? = nil, emojify: Bool = false) -> Signal<(String, [MessageTextEntity]), TranslationError> {
    guard let language = translateToLang, !proofread, changeStyle == nil, !emojify else {
        return .fail(.generic)
    }
    return _internal_translate(network: account.network, text: text, toLang: language, entities: entities)
    |> mapToSignal { result -> Signal<(String, [MessageTextEntity]), TranslationError> in
        guard let result else { return .fail(.generic) }
        return .single(result)
    }
}

func _internal_composeRichMessageWithAI(account: Account, instantPage: InstantPage?, proofread: Bool = false, translateToLang: String? = nil, changeStyle: IosappComposeAIMessageMode.CloudStyle.Reference? = nil, customPrompt: String? = nil, emojify: Bool = false) -> Signal<InstantPage, TranslationError> {
    guard let language = translateToLang, let instantPage, !proofread, changeStyle == nil, customPrompt == nil, !emojify else {
        return .fail(.generic)
    }
    let input = RichTextMessageAttribute(instantPage: instantPage, fullInstantPage: nil).apiInputRichMessage(users: [])
    return account.network.request(Api.functions.messages.translateRichMessage(flags: 1 << 1, peer: nil, id: nil, text: [input], toLang: language, tone: nil))
    |> mapError { _ -> TranslationError in return .generic }
    |> mapToSignal { result -> Signal<InstantPage, TranslationError> in
        switch result {
        case let .translatedRichMessage(data):
            guard let page = data.result.first else { return .fail(.generic) }
            return .single(RichTextMessageAttribute(apiRichMessage: page).instantPage)
        }
    }
}

func _internal_translateTexts(network: Network, texts: [(String, [MessageTextEntity])], toLang: String, tone: TranslationTone = .neutral) -> Signal<[(String, [MessageTextEntity])], TranslationError> {
    var flags: Int32 = 0
    flags |= (1 << 1)
    
    
    var apiTexts: [Api.TextWithEntities] = []
    for text in texts {
        apiTexts.append(.textWithEntities(.init(text: text.0, entities: apiEntitiesFromMessageTextEntities(text.1, associatedPeers: SimpleDictionary()))))
    }

    return network.request(Api.functions.messages.translateText(flags: flags, peer: nil, id: nil, text: apiTexts, toLang: toLang, tone: nil))
    |> mapError { error -> TranslationError in
        if error.errorDescription.hasPrefix("FLOOD_WAIT") {
            return .limitExceeded
        } else if error.errorDescription == "MSG_ID_INVALID" {
            return .invalidMessageId
        } else if error.errorDescription == "INPUT_TEXT_EMPTY" {
            return .textIsEmpty
        } else if error.errorDescription == "INPUT_TEXT_TOO_LONG" {
            return .textTooLong
        } else if error.errorDescription == "TO_LANG_INVALID" {
            return .invalidLanguage
        } else {
            return .generic
        }
    }
    |> mapToSignal { result -> Signal<[(String, [MessageTextEntity])], TranslationError> in
        var texts: [(String, [MessageTextEntity])] = []
        switch result {
        case let .translateResult(translateResultData):
            let results = translateResultData.result
            for result in results {
                if case let .textWithEntities(textWithEntitiesData) = result {
                    let (text, entities) = (textWithEntitiesData.text, textWithEntitiesData.entities)
                    texts.append((text, messageTextEntitiesFromApiEntities(entities)))
                }
            }
        }
        return .single(texts)
    }
}

func _internal_translateMessages(account: Account, messageIds: [EngineMessage.Id], fromLang: String?, toLang: String, enableLocalIfPossible: Bool, tone: TranslationTone = .neutral) -> Signal<Never, TranslationError> {
    var signals: [Signal<Void, TranslationError>] = []
    for (peerId, messageIds) in messagesIdsGroupedByPeerId(messageIds) {
        signals.append(_internal_translateMessagesByPeerId(account: account, peerId: peerId, messageIds: messageIds, fromLang: fromLang, toLang: toLang, enableLocalIfPossible: enableLocalIfPossible, tone: tone))
    }
    return combineLatest(signals)
    |> ignoreValues
}

public protocol ExperimentalInternalTranslationService: AnyObject {
    func translate(texts: [AnyHashable: String], fromLang: String, toLang: String) -> Signal<[AnyHashable: String]?, NoError>
}

public var engineExperimentalInternalTranslationService: ExperimentalInternalTranslationService?

/// Translates rich messages (those carrying a `RichTextMessageAttribute`) by id via
/// `messages.translateRichMessage`, stores each result as a `TranslationMessageAttribute` with the
/// translated `InstantPage`, and returns the pages keyed by message id.
func _internal_translateRichMessages(account: Account, inputPeer: Api.InputPeer, messageIds: [EngineMessage.Id], toLang: String, tone: TranslationTone = .neutral) -> Signal<[EngineMessage.Id: InstantPage], TranslationError> {
    var flags: Int32 = 0
    flags |= (1 << 0)
    return account.network.request(Api.functions.messages.translateRichMessage(flags: flags, peer: inputPeer, id: messageIds.map { $0.id }, text: nil, toLang: toLang, tone: nil))
    |> mapError { error -> TranslationError in
        if error.errorDescription.hasPrefix("FLOOD_WAIT") {
            return .limitExceeded
        } else if error.errorDescription == "MSG_ID_INVALID" {
            return .invalidMessageId
        } else if error.errorDescription == "INPUT_TEXT_EMPTY" {
            return .textIsEmpty
        } else if error.errorDescription == "INPUT_TEXT_TOO_LONG" {
            return .textTooLong
        } else if error.errorDescription == "TO_LANG_INVALID" {
            return .invalidLanguage
        } else {
            return .generic
        }
    }
    |> mapToSignal { result -> Signal<[EngineMessage.Id: InstantPage], TranslationError> in
        var pages: [EngineMessage.Id: InstantPage] = [:]
        switch result {
        case let .translatedRichMessage(data):
            for (i, richMessage) in data.result.enumerated() where i < messageIds.count {
                pages[messageIds[i]] = RichTextMessageAttribute(apiRichMessage: richMessage).instantPage
            }
        }
        return account.postbox.transaction { transaction -> [EngineMessage.Id: InstantPage] in
            for (messageId, page) in pages {
                let updatedAttribute = TranslationMessageAttribute(text: "", entities: [], toLang: toLang, instantPage: page)
                transaction.updateMessage(messageId, update: { currentMessage in
                    let storeForwardInfo = currentMessage.forwardInfo.flatMap(StoreMessageForwardInfo.init)
                    var attributes = currentMessage.attributes.filter { !($0 is TranslationMessageAttribute) }
                    attributes.append(updatedAttribute)
                    return .update(StoreMessage(id: currentMessage.id, customStableId: nil, globallyUniqueId: currentMessage.globallyUniqueId, groupingKey: currentMessage.groupingKey, threadId: currentMessage.threadId, timestamp: currentMessage.timestamp, flags: StoreMessageFlags(currentMessage.flags), tags: currentMessage.tags, globalTags: currentMessage.globalTags, localTags: currentMessage.localTags, forwardInfo: storeForwardInfo, authorId: currentMessage.author?.id, text: currentMessage.text, attributes: attributes, media: currentMessage.media))
                })
            }
            return pages
        }
        |> castError(TranslationError.self)
    }
}

private func _internal_translateMessagesByPeerId(account: Account, peerId: EnginePeer.Id, messageIds: [EngineMessage.Id], fromLang: String?, toLang: String, enableLocalIfPossible: Bool, tone: TranslationTone = .neutral) -> Signal<Void, TranslationError> {
    return account.postbox.transaction { transaction -> (Api.InputPeer?, [Message]) in
        return (transaction.getPeer(peerId).flatMap(apiInputPeer), messageIds.compactMap({ transaction.getMessage($0) }))
    }
    |> castError(TranslationError.self)
    |> mapToSignal { (inputPeer, messages) -> Signal<Void, TranslationError> in
        guard let inputPeer = inputPeer else {
            return .never()
        }
        
        let polls = messages.compactMap { message in
            if let poll = message.media.first as? IosappMediaPoll {
                return (poll, message.id)
            } else {
                return nil
            }
        }
        let pollSignals = polls.map { (poll, id) in
            var texts: [(String, [MessageTextEntity])] = []
            texts.append((poll.text, poll.textEntities))
            for option in poll.options {
                texts.append((option.text, option.entities))
            }
            if let solution = poll.results.solution {
                texts.append((solution.text, solution.entities))
            }
            return _internal_translateTexts(network: account.network, texts: texts, toLang: toLang)
        }
        
        let audioTranscriptions = messages.compactMap { message in
            if let audioTranscription = message.attributes.first(where: { $0 is AudioTranscriptionMessageAttribute }) as? AudioTranscriptionMessageAttribute, !audioTranscription.text.isEmpty && !audioTranscription.isPending {
                return (audioTranscription.text, message.id)
            } else {
                return nil
            }
        }
        let audioTranscriptionsSignals = audioTranscriptions.map { (text, id) in
            return _internal_translate(network: account.network, text: text, toLang: toLang)
        }
        
        var flags: Int32 = 0
        flags |= (1 << 0)

        // Rich messages (a `RichTextMessageAttribute`) translate through `messages.translateRichMessage`
        // (per the layer-228 contract: pick translateText vs translateRichMessage by message type).
        let richMessageIds = messages.filter { $0.attributes.contains(where: { $0 is RichTextMessageAttribute }) }.map { $0.id }
        let plainMessageIds = messageIds.filter { !richMessageIds.contains($0) }

        let richSignal: Signal<Void, TranslationError>
        if richMessageIds.isEmpty {
            richSignal = .single(Void())
        } else {
            richSignal = _internal_translateRichMessages(account: account, inputPeer: inputPeer, messageIds: richMessageIds, toLang: toLang, tone: tone)
            |> map { _ in Void() }
        }

        let id: [Int32] = plainMessageIds.map { $0.id }

        let msgs: Signal<Api.messages.TranslatedText?, TranslationError>
        if id.isEmpty {
            msgs = .single(nil)
        } else {
            if enableLocalIfPossible, let engineExperimentalInternalTranslationService, let fromLang {
                msgs = account.postbox.transaction { transaction -> [MessageId: String] in
                    var texts: [MessageId: String] = [:]
                    for messageId in plainMessageIds {
                        if let message = transaction.getMessage(messageId) {
                            texts[message.id] = message.text
                        }
                    }
                    return texts
                }
                |> castError(TranslationError.self)
                |> mapToSignal { messageTexts -> Signal<Api.messages.TranslatedText?, TranslationError> in
                    var mappedTexts: [AnyHashable: String] = [:]
                    for (id, text) in messageTexts {
                        mappedTexts[AnyHashable(id)] = text
                    }
                    return engineExperimentalInternalTranslationService.translate(texts: mappedTexts, fromLang: fromLang, toLang: toLang)
                    |> castError(TranslationError.self)
                    |> mapToSignal { resultTexts -> Signal<Api.messages.TranslatedText?, TranslationError> in
                        guard let resultTexts else {
                            return .fail(.generic)
                        }
                        var result: [Api.TextWithEntities] = []
                        for messageId in plainMessageIds {
                            if let text = resultTexts[AnyHashable(messageId)] {
                                result.append(.textWithEntities(.init(text: text, entities: [])))
                            } else if let text = messageTexts[messageId] {
                                result.append(.textWithEntities(.init(text: text, entities: [])))
                            } else {
                                result.append(.textWithEntities(.init(text: "", entities: [])))
                            }
                        }
                        return .single(.translateResult(.init(result: result)))
                    }
                }
            } else {
                msgs = account.network.request(Api.functions.messages.translateText(flags: flags, peer: inputPeer, id: id, text: nil, toLang: toLang, tone: nil))
                |> map(Optional.init)
                |> mapError { error -> TranslationError in
                    if error.errorDescription.hasPrefix("FLOOD_WAIT") {
                        return .limitExceeded
                    } else if error.errorDescription == "MSG_ID_INVALID" {
                        return .invalidMessageId
                    } else if error.errorDescription == "INPUT_TEXT_EMPTY" {
                        return .textIsEmpty
                    } else if error.errorDescription == "INPUT_TEXT_TOO_LONG" {
                        return .textTooLong
                    } else if error.errorDescription == "TO_LANG_INVALID" {
                        return .invalidLanguage
                    } else {
                        return .generic
                    }
                }
            }
        }
        
        return combineLatest(msgs, richSignal, combineLatest(pollSignals), combineLatest(audioTranscriptionsSignals))
        |> mapToSignal { (result, _, pollResults, audioTranscriptionsResults) -> Signal<Void, TranslationError> in
            return account.postbox.transaction { transaction in
                if case let .translateResult(translateResultData) = result {
                    let results = translateResultData.result
                    var index = 0
                    for result in results {
                        guard index < plainMessageIds.count else { break }
                        let messageId = plainMessageIds[index]
                        if case let .textWithEntities(textWithEntitiesData) = result {
                            let (text, entities) = (textWithEntitiesData.text, textWithEntitiesData.entities)
                            let updatedAttribute: TranslationMessageAttribute = TranslationMessageAttribute(text: text, entities: messageTextEntitiesFromApiEntities(entities), toLang: toLang)
                            transaction.updateMessage(messageId, update: { currentMessage in
                                let storeForwardInfo = currentMessage.forwardInfo.flatMap(StoreMessageForwardInfo.init)
                                var attributes = currentMessage.attributes.filter { !($0 is TranslationMessageAttribute) }
                                
                                attributes.append(updatedAttribute)
                                
                                return .update(StoreMessage(id: currentMessage.id, customStableId: nil, globallyUniqueId: currentMessage.globallyUniqueId, groupingKey: currentMessage.groupingKey, threadId: currentMessage.threadId, timestamp: currentMessage.timestamp, flags: StoreMessageFlags(currentMessage.flags), tags: currentMessage.tags, globalTags: currentMessage.globalTags, localTags: currentMessage.localTags, forwardInfo: storeForwardInfo, authorId: currentMessage.author?.id, text: currentMessage.text, attributes: attributes, media: currentMessage.media))
                            })
                        }
                        index += 1
                    }
                }
                
                if !pollResults.isEmpty {
                    for (i, poll) in polls.enumerated() {
                        let result = pollResults[i]
                        if !result.isEmpty {
                            transaction.updateMessage(poll.1, update: { currentMessage in
                                let storeForwardInfo = currentMessage.forwardInfo.flatMap(StoreMessageForwardInfo.init)
                                var attributes = currentMessage.attributes.filter { !($0 is TranslationMessageAttribute) }
                                var attrOptions: [TranslationMessageAttribute.Additional] = []
                                for (i, _) in poll.0.options.enumerated() {
                                    var translated = result.count > i + 1 ? result[i + 1] : (poll.0.options[i].text, poll.0.options[i].entities)
                                    if translated.0.isEmpty {
                                        translated = (poll.0.options[i].text, poll.0.options[i].entities)
                                    }
                                    attrOptions.append(TranslationMessageAttribute.Additional(text: translated.0, entities: translated.1))
                                }
                                
                                let solution: TranslationMessageAttribute.Additional?
                                if result.count > 1 + poll.0.options.count, !result[result.count - 1].0.isEmpty {
                                    solution = TranslationMessageAttribute.Additional(text: result[result.count - 1].0, entities: result[result.count - 1].1)
                                } else {
                                    solution = nil
                                }
                                
                                let title = result[0].0.isEmpty ? (poll.0.text, poll.0.textEntities) : result[0]
                                
                                let updatedAttribute: TranslationMessageAttribute = TranslationMessageAttribute(text: title.0, entities: title.1, additional: attrOptions, pollSolution: solution, toLang: toLang)
                                attributes.append(updatedAttribute)
                                
                                return .update(StoreMessage(id: currentMessage.id, customStableId: nil, globallyUniqueId: currentMessage.globallyUniqueId, groupingKey: currentMessage.groupingKey, threadId: currentMessage.threadId, timestamp: currentMessage.timestamp, flags: StoreMessageFlags(currentMessage.flags), tags: currentMessage.tags, globalTags: currentMessage.globalTags, localTags: currentMessage.localTags, forwardInfo: storeForwardInfo, authorId: currentMessage.author?.id, text: currentMessage.text, attributes: attributes, media: currentMessage.media))
                            })
                        }
                    }
                }
                
                if !audioTranscriptionsResults.isEmpty {
                    for (i, audioTranscription) in audioTranscriptions.enumerated() {
                        if let result = audioTranscriptionsResults[i] {
                            transaction.updateMessage(audioTranscription.1, update: { currentMessage in
                                let storeForwardInfo = currentMessage.forwardInfo.flatMap(StoreMessageForwardInfo.init)
                                var attributes = currentMessage.attributes.filter { !($0 is TranslationMessageAttribute) }
                                
                                let updatedAttribute: TranslationMessageAttribute = TranslationMessageAttribute(text: result.0, entities: result.1, additional: [], pollSolution: nil, toLang: toLang)
                                attributes.append(updatedAttribute)
                                
                                return .update(StoreMessage(id: currentMessage.id, customStableId: nil, globallyUniqueId: currentMessage.globallyUniqueId, groupingKey: currentMessage.groupingKey, threadId: currentMessage.threadId, timestamp: currentMessage.timestamp, flags: StoreMessageFlags(currentMessage.flags), tags: currentMessage.tags, globalTags: currentMessage.globalTags, localTags: currentMessage.localTags, forwardInfo: storeForwardInfo, authorId: currentMessage.author?.id, text: currentMessage.text, attributes: attributes, media: currentMessage.media))
                            })
                        }
                    }
                }
            }
            |> castError(TranslationError.self)
        }
    }
}

func _internal_togglePeerMessagesTranslationHidden(account: Account, peerId: EnginePeer.Id, hidden: Bool) -> Signal<Never, NoError> {
    return account.postbox.transaction { transaction -> Api.InputPeer? in
        transaction.updatePeerCachedData(peerIds: Set([peerId]), update: { _, cachedData -> CachedPeerData? in
            if let cachedData = cachedData as? CachedUserData {
                var updatedFlags = cachedData.flags
                if hidden {
                    updatedFlags.insert(.translationHidden)
                } else {
                    updatedFlags.remove(.translationHidden)
                }
                return cachedData.withUpdatedFlags(updatedFlags)
            } else if let cachedData = cachedData as? CachedGroupData {
                var updatedFlags = cachedData.flags
                if hidden {
                    updatedFlags.insert(.translationHidden)
                } else {
                    updatedFlags.remove(.translationHidden)
                }
                return cachedData.withUpdatedFlags(updatedFlags)
            } else if let cachedData = cachedData as? CachedChannelData {
                var updatedFlags = cachedData.flags
                if hidden {
                    updatedFlags.insert(.translationHidden)
                } else {
                    updatedFlags.remove(.translationHidden)
                }
                return cachedData.withUpdatedFlags(updatedFlags)
            } else {
                return cachedData
            }
        })
        return transaction.getPeer(peerId).flatMap(apiInputPeer)
    }
    |> mapToSignal { inputPeer -> Signal<Never, NoError> in
        guard let inputPeer = inputPeer else {
            return .never()
        }
        var flags: Int32 = 0
        if hidden {
            flags |= (1 << 0)
        }
        
        return account.network.request(Api.functions.messages.togglePeerTranslations(flags: flags, peer: inputPeer))
        |> map(Optional.init)
        |> `catch` { _ -> Signal<Api.Bool?, NoError> in
            return .single(nil)
        }
        |> ignoreValues
    }
}

public enum IosappComposeAIMessageMode {
    public final class CloudStyle: Equatable, Codable {
        public enum Id: Hashable {
            case standard(String)
            case custom(Int64)
        }
        
        public enum Reference: Hashable {
            case standard(String)
            case custom(id: Int64, accessHash: Int64)
            
            public var id: Id {
                switch self {
                case let .standard(type):
                    return .standard(type)
                case let .custom(id, _):
                    return .custom(id)
                }
            }
        }
        
        public final class Standard: Codable, Equatable {
            private enum CodingKeys: String, CodingKey {
                case type
                case title
                case emojiFileId
            }
            
            public let type: String
            public let title: String
            public let emojiFileId: Int64?
            
            public init(type: String, title: String, emojiFileId: Int64?) {
                self.type = type
                self.title = title
                self.emojiFileId = emojiFileId
            }
            
            public init(from decoder: any Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.type = try container.decode(String.self, forKey: .type)
                self.title = try container.decode(String.self, forKey: .title)
                self.emojiFileId = try container.decodeIfPresent(Int64.self, forKey: .emojiFileId)
            }
            
            public func encode(to encoder: any Encoder) throws {
                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(self.type, forKey: .type)
                try container.encode(self.title, forKey: .title)
                try container.encodeIfPresent(self.emojiFileId, forKey: .emojiFileId)
            }
            
            public static func ==(lhs: Standard, rhs: Standard) -> Bool {
                if lhs.type != rhs.type {
                    return false
                }
                if lhs.title != rhs.title {
                    return false
                }
                if lhs.emojiFileId != rhs.emojiFileId {
                    return false
                }
                return true
            }
        }
        
        public final class Custom: Codable, Equatable {
            private enum CodingKeys: String, CodingKey {
                case isCreator
                case id
                case accessHash
                case slug
                case emojiFileId
                case title
                case prompt
                case userCount
                case authorId
            }
            
            public let isCreator: Bool
            public let id: Int64
            public let accessHash: Int64
            public let slug: String
            public let emojiFileId: Int64?
            public let title: String
            public let prompt: String?
            public let userCount: Int?
            public let authorId: EnginePeer.Id?
            
            public init(isCreator: Bool, id: Int64, accessHash: Int64, slug: String, emojiFileId: Int64?, title: String, prompt: String?, userCount: Int?, authorId: EnginePeer.Id?) {
                self.isCreator = isCreator
                self.id = id
                self.accessHash = accessHash
                self.slug = slug
                self.emojiFileId = emojiFileId
                self.title = title
                self.prompt = prompt
                self.userCount = userCount
                self.authorId = authorId
            }
            
            public init(from decoder: any Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                
                self.isCreator = try container.decode(Bool.self, forKey: .isCreator)
                self.id = try container.decode(Int64.self, forKey: .id)
                self.accessHash = try container.decode(Int64.self, forKey: .accessHash)
                self.slug = try container.decode(String.self, forKey: .slug)
                self.emojiFileId = try container.decodeIfPresent(Int64.self, forKey: .emojiFileId)
                self.title = try container.decode(String.self, forKey: .title)
                self.prompt = try container.decodeIfPresent(String.self, forKey: .prompt)
                self.userCount = try container.decodeIfPresent(Int32.self, forKey: .userCount).flatMap(Int.init)
                self.authorId = try container.decodeIfPresent(EnginePeer.Id.self, forKey: .authorId)
            }
            
            public func encode(to encoder: any Encoder) throws {
                var container = encoder.container(keyedBy: CodingKeys.self)
                
                try container.encode(self.isCreator, forKey: .isCreator)
                try container.encode(self.id, forKey: .id)
                try container.encode(self.accessHash, forKey: .accessHash)
                try container.encode(self.slug, forKey: .slug)
                try container.encodeIfPresent(self.emojiFileId, forKey: .emojiFileId)
                try container.encode(self.title, forKey: .title)
                try container.encodeIfPresent(self.prompt, forKey: .prompt)
                try container.encodeIfPresent(self.userCount.flatMap(Int32.init(clamping:)), forKey: .userCount)
                try container.encodeIfPresent(self.authorId, forKey: .authorId)
            }
            
            public static func ==(lhs: Custom, rhs: Custom) -> Bool {
                if lhs.isCreator != rhs.isCreator {
                    return false
                }
                if lhs.id != rhs.id {
                    return false
                }
                if lhs.accessHash != rhs.accessHash {
                    return false
                }
                if lhs.slug != rhs.slug {
                    return false
                }
                if lhs.emojiFileId != rhs.emojiFileId {
                    return false
                }
                if lhs.title != rhs.title {
                    return false
                }
                if lhs.prompt != rhs.prompt {
                    return false
                }
                if lhs.userCount != rhs.userCount {
                    return false
                }
                if lhs.authorId != rhs.authorId {
                    return false
                }
                return true
            }
        }
        
        public enum Content: Equatable, Codable {
            private enum CodingKeys: String, CodingKey {
                case discriminator = "d"
                case value = "v"
            }
            
            case standard(Standard)
            case custom(Custom)
            
            public init(from decoder: any Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                
                switch try container.decode(Int32.self, forKey: .discriminator) {
                case 0:
                    self = .standard(try container.decode(Standard.self, forKey: .value))
                case 1:
                    self = .custom(try container.decode(Custom.self, forKey: .value))
                default:
                    throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: ""))
                }
            }
            
            public func encode(to encoder: any Encoder) throws {
                var container = encoder.container(keyedBy: CodingKeys.self)
                
                switch self {
                case let .standard(standard):
                    try container.encode(0 as Int32, forKey: .discriminator)
                    try container.encode(standard, forKey: .value)
                case let .custom(custom):
                    try container.encode(1 as Int32, forKey: .discriminator)
                    try container.encode(custom, forKey: .value)
                }
            }
        }
        
        public let content: Content
        
        public var id: StyleId {
            switch self.content {
            case let .standard(standard):
                return .style(.standard(standard.type))
            case let .custom(custom):
                return .style(.custom(custom.id))
            }
        }
        
        public var reference: Reference {
            switch self.content {
            case let .standard(standard):
                return .standard(standard.type)
            case let .custom(custom):
                return .custom(id: custom.id, accessHash: custom.accessHash)
            }
        }
        
        public init(content: Content) {
            self.content = content
        }
        
        public static func ==(lhs: CloudStyle, rhs: CloudStyle) -> Bool {
            if lhs.content != rhs.content {
                return false
            }
            return true
        }
    }
    
    public enum StyleId: Hashable {
        case neutral
        case prompt
        case style(CloudStyle.Id)
    }
    
    public enum StyleReference: Hashable {
        case neutral
        case prompt(String)
        case style(CloudStyle.Reference)
        
        public var id: StyleId {
            switch self {
            case .neutral:
                return .neutral
            case .prompt:
                return .prompt
            case let .style(style):
                return .style(style.id)
            }
        }
    }
    
    case translate(toLanguage: String, emojify: Bool, style: StyleReference)
    case stylize(emojify: Bool, style: StyleReference)
    case proofread
    case generate(prompt: String)
}

extension IosappComposeAIMessageMode.CloudStyle {
    convenience init(apiTone: Api.AiComposeTone) {
        switch apiTone {
        case let .aiComposeTone(aiComposeTone):
            self.init(content: .custom(Custom(
                isCreator: (aiComposeTone.flags & (1 << 0)) != 0,
                id: aiComposeTone.id,
                accessHash: aiComposeTone.accessHash,
                slug: aiComposeTone.slug,
                emojiFileId: aiComposeTone.emojiId,
                title: aiComposeTone.title,
                prompt: aiComposeTone.prompt,
                userCount: aiComposeTone.installsCount.flatMap(Int.init),
                authorId: aiComposeTone.authorId.flatMap { id -> EnginePeer.Id in
                    return EnginePeer.Id(namespace: Namespaces.Peer.CloudUser, id: PeerId.Id._internalFromInt64Value(id))
                }
            )))
        case let .aiComposeToneDefault(aiComposeToneDefault):
            self.init(content: .standard(Standard(
                type: aiComposeToneDefault.tone,
                title: aiComposeToneDefault.title,
                emojiFileId: aiComposeToneDefault.emojiId
            )))
        }
    }
}

public final class IosappAIComposeMessageResult {
    public let text: ComposedRichMessage
    public let diffRanges: [Range<Int>]
    
    public init(text: ComposedRichMessage, diffRanges: [Range<Int>]) {
        self.text = text
        self.diffRanges = diffRanges
    }
}

extension TextWithEntities {
    init(apiValue: Api.TextWithEntities) {
        switch apiValue {
        case let .textWithEntities(textWithEntities):
            self.init(text: textWithEntities.text, entities: messageTextEntitiesFromApiEntities(textWithEntities.entities))
        }
    }
}

extension IosappComposeAIMessageMode.CloudStyle.Reference {
    var apiInputStyle: Api.InputAiComposeTone {
        switch self {
        case let .standard(type):
            return .inputAiComposeToneDefault(Api.InputAiComposeTone.Cons_inputAiComposeToneDefault(tone: type))
        case let .custom(id, accessHash):
            return .inputAiComposeToneID(Api.InputAiComposeTone.Cons_inputAiComposeToneID(id: id, accessHash: accessHash))
        }
    }
}

public enum IosappAIComposeMessageError {
    case generic
    case nonPremiumFlood
}

func _internal_composeAIMessage(account: Account, text: ComposedRichMessage, mode: IosappComposeAIMessageMode) -> Signal<IosappAIComposeMessageResult, IosappAIComposeMessageError> {
    // This screen also serves ordinary translation. Keep that path on the
    // translation RPCs while rejecting retired generation and styling modes.
    guard case let .translate(language, emojify, style) = mode,
          !emojify, case .neutral = style else {
        return .fail(.generic)
    }
    switch text {
    case .empty:
        return .single(IosappAIComposeMessageResult(text: .empty, diffRanges: []))
    case let .plain(text, entities):
        return _internal_composeMessageWithAI(account: account, text: text, entities: entities, translateToLang: language)
        |> mapError { _ -> IosappAIComposeMessageError in return .generic }
        |> map { text, entities in
            return IosappAIComposeMessageResult(text: .plain(text: text, entities: entities), diffRanges: [])
        }
    case let .rich(instantPage):
        return _internal_composeRichMessageWithAI(account: account, instantPage: instantPage, translateToLang: language)
        |> mapError { _ -> IosappAIComposeMessageError in return .generic }
        |> map { page in
            return IosappAIComposeMessageResult(text: .rich(instantPage: page), diffRanges: [])
        }
    }
}

public final class AIMessageStylePreview {
    public let from: ComposedRichMessage
    public let to: ComposedRichMessage
    public let index: Int?
    
    public init(from: ComposedRichMessage, to: ComposedRichMessage, index: Int?) {
        self.from = from
        self.to = to
        self.index = index
    }
}

extension AIMessageStylePreview {
    convenience init(apiPreview: Api.AiComposeToneExample, index: Int) {
        switch apiPreview {
        case let .aiComposeToneExample(aiComposeToneExample):
            let fromText = TextWithEntities(apiValue: aiComposeToneExample.from)
            let toText = TextWithEntities(apiValue: aiComposeToneExample.to)
            self.init(from: .plain(text: fromText.text, entities: fromText.entities), to: .plain(text: toText.text, entities: toText.entities), index: index)
        }
    }
}

public func _internal_requestAIMessageStylePreview(account: Account, reference: IosappComposeAIMessageMode.CloudStyle.Reference, index: Int) -> Signal<AIMessageStylePreview?, NoError> {
    return .single(nil)
}

public enum CreateAITextStyleError {
    case generic
    case premiumRequired
}

func _internal_createAITextStyle(account: Account, displayAuthor: Bool, emojiFileId: Int64, title: String, prompt: String) -> Signal<IosappComposeAIMessageMode.CloudStyle, CreateAITextStyleError> {
    return .fail(.generic)
}

public enum EditAITextStyleError {
    case generic
}

func _internal_editAITextStyle(account: Account, id: Int64, accessHash: Int64, displayAuthor: Bool, emojiFileId: Int64, title: String, prompt: String) -> Signal<IosappComposeAIMessageMode.CloudStyle, EditAITextStyleError> {
    return .fail(.generic)
}

public struct IosappAIComposeToneExample: Equatable {
    public let from: TextWithEntities
    public let to: TextWithEntities
    public init(from: TextWithEntities, to: TextWithEntities) {
        self.from = from
        self.to = to
    }
}

private func _internal_mapToneExample(_ apiExample: Api.AiComposeToneExample) -> IosappAIComposeToneExample {
    switch apiExample {
    case let .aiComposeToneExample(data):
        return IosappAIComposeToneExample(from: TextWithEntities(apiValue: data.from), to: TextWithEntities(apiValue: data.to))
    }
}

func _internal_getAIComposeToneExample(network: Network, tone: IosappComposeAIMessageMode.CloudStyle.Reference, num: Int32) -> Signal<IosappAIComposeToneExample?, NoError> {
    return .single(nil)
}

func _internal_getAIComposeToneExample(network: Network, slug: String, num: Int32) -> Signal<IosappAIComposeToneExample?, NoError> {
    return .single(nil)
}

public enum DeleteAITextStyleError {
    case generic
}

func _internal_deleteAITextStyle(account: Account, id: Int64, accessHash: Int64) -> Signal<Never, DeleteAITextStyleError> {
    return .fail(.generic)
}

func _internal_unsaveAITextStyle(account: Account, id: Int64, accessHash: Int64) -> Signal<Never, DeleteAITextStyleError> {
    return .fail(.generic)
}

final class CachedCloudAITextStyles: Codable {
    let items: [IosappComposeAIMessageMode.CloudStyle]
    let hash: Int64
    
    init(items: [IosappComposeAIMessageMode.CloudStyle], hash: Int64) {
        self.items = items
        self.hash = hash
    }
}

func _internal_cachedCloudAITextStyles(postbox: Postbox) -> Signal<CachedCloudAITextStyles?, NoError> {
    return postbox.transaction { transaction -> CachedCloudAITextStyles? in
        return _internal_cachedCloudAITextStyles(transaction: transaction)
    }
}

func _internal_cachedCloudAITextStyles(transaction: Transaction) -> CachedCloudAITextStyles? {
    let key = ValueBoxKey(length: 8)
    key.setInt64(0, value: 0)
    
    let cached = transaction.retrieveItemCacheEntry(id: ItemCacheEntryId(collectionId: Namespaces.CachedItemCollection.cachedCloudAITextStyles, key: key))?.get(CachedCloudAITextStyles.self)
    if let cached {
        return cached
    } else {
        return nil
    }
}

func _internal_setCachedCloudAITextStyles(transaction: Transaction, styles: CachedCloudAITextStyles) {
    let key = ValueBoxKey(length: 8)
    key.setInt64(0, value: 0)
    
    if let entry = CodableEntry(styles) {
        transaction.putItemCacheEntry(id: ItemCacheEntryId(collectionId: Namespaces.CachedItemCollection.cachedCloudAITextStyles, key: key), entry: entry)
    }
}

func _internal_requestAIMessageStyle(account: Account, slug: String) -> Signal<(style: IosappComposeAIMessageMode.CloudStyle, initialPreview: AIMessageStylePreview?)?, NoError> {
    return .single(nil)
}

public enum InstallAIMessageStyleError {
    case generic
}

func _internal_installAIMessageStyle(account: Account, style: IosappComposeAIMessageMode.CloudStyle.Custom) -> Signal<Never, InstallAIMessageStyleError> {
    return .fail(.generic)
}

func managedSynchronizeCloudAITextStyles(postbox: Postbox, network: Network) -> Signal<Never, NoError> {
    return .complete()
}
