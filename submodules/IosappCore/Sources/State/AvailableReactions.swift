import Foundation
import IosappApi
import Postbox
import SwiftSignalKit
import FlatBuffers
import FlatSerialization

private func generateStarsReactionFile(kind: Int, isAnimatedSticker: Bool) -> IosappMediaFile {
    let baseId: Int64 = 52343278047832950 + 10
    let fileId = baseId + Int64(kind)
    
    var attributes: [IosappMediaFileAttribute] = []
    attributes.append(IosappMediaFileAttribute.FileName(fileName: isAnimatedSticker ? "sticker.ass" : "sticker.webp"))
    if !isAnimatedSticker {
        attributes.append(.CustomEmoji(isPremium: false, isSingleColor: false, alt: ".", packReference: nil))
    }
    
    return IosappMediaFile(
        fileId: MediaId(namespace: Namespaces.Media.CloudFile, id: fileId),
        partialReference: nil,
        resource: LocalFileMediaResource(fileId: fileId),
        previewRepresentations: [],
        videoThumbnails: [],
        immediateThumbnailData: nil,
        mimeType: isAnimatedSticker ? "application/x-ansible-sticker" : "image/webp",
        size: nil,
        attributes: attributes,
        alternativeRepresentations: []
    )
}

private let sharedStarsReaction: AvailableReactions.Reaction = {
    return AvailableReactions.Reaction(
        isEnabled: false,
        isPremium: false,
        value: .stars,
        title: "Star",
        staticIcon: generateStarsReactionFile(kind: 0, isAnimatedSticker: true),
        appearAnimation: generateStarsReactionFile(kind: 1, isAnimatedSticker: true),
        selectAnimation: generateStarsReactionFile(kind: 2, isAnimatedSticker: true),
        activateAnimation: generateStarsReactionFile(kind: 3, isAnimatedSticker: true),
        effectAnimation: generateStarsReactionFile(kind: 4, isAnimatedSticker: true),
        aroundAnimation: generateStarsReactionFile(kind: 5, isAnimatedSticker: true),
        centerAnimation: generateStarsReactionFile(kind: 6, isAnimatedSticker: true)
    )
}()

public final class AvailableReactions: Equatable, Codable {
    public final class Reaction: Equatable, Codable {
        private enum CodingKeys: String, CodingKey {
            case isEnabled
            case isPremium
            case value
            case title
            case staticIcon
            case staticIconData
            case appearAnimation
            case appearAnimationData
            case selectAnimation
            case selectAnimationData
            case activateAnimation
            case activateAnimationData
            case effectAnimation
            case effectAnimationData
            case aroundAnimation
            case aroundAnimationData
            case centerAnimation
            case centerAnimationData
            case isStars
        }
        
        public let isEnabled: Bool
        public let isPremium: Bool
        public let value: MessageReaction.Reaction
        public let title: String
        public let staticIcon: IosappMediaFile.Accessor
        public let appearAnimation: IosappMediaFile.Accessor
        public let selectAnimation: IosappMediaFile.Accessor
        public let activateAnimation: IosappMediaFile.Accessor
        public let effectAnimation: IosappMediaFile.Accessor
        public let aroundAnimation: IosappMediaFile.Accessor?
        public let centerAnimation: IosappMediaFile.Accessor?
        
        public init(
            isEnabled: Bool,
            isPremium: Bool,
            value: MessageReaction.Reaction,
            title: String,
            staticIcon: IosappMediaFile,
            appearAnimation: IosappMediaFile,
            selectAnimation: IosappMediaFile,
            activateAnimation: IosappMediaFile,
            effectAnimation: IosappMediaFile,
            aroundAnimation: IosappMediaFile?,
            centerAnimation: IosappMediaFile?
        ) {
            self.isEnabled = isEnabled
            self.isPremium = isPremium
            self.value = value
            self.title = title
            self.staticIcon = IosappMediaFile.Accessor(staticIcon)
            self.appearAnimation = IosappMediaFile.Accessor(appearAnimation)
            self.selectAnimation = IosappMediaFile.Accessor(selectAnimation)
            self.activateAnimation = IosappMediaFile.Accessor(activateAnimation)
            self.effectAnimation = IosappMediaFile.Accessor(effectAnimation)
            self.aroundAnimation = aroundAnimation.flatMap(IosappMediaFile.Accessor.init)
            self.centerAnimation = centerAnimation.flatMap(IosappMediaFile.Accessor.init)
        }
        
        public static func ==(lhs: Reaction, rhs: Reaction) -> Bool {
            if lhs.isEnabled != rhs.isEnabled {
                return false
            }
            if lhs.isPremium != rhs.isPremium {
                return false
            }
            if lhs.value != rhs.value {
                return false
            }
            if lhs.title != rhs.title {
                return false
            }
            if lhs.staticIcon != rhs.staticIcon {
                return false
            }
            if lhs.appearAnimation != rhs.appearAnimation {
                return false
            }
            if lhs.selectAnimation != rhs.selectAnimation {
                return false
            }
            if lhs.activateAnimation != rhs.activateAnimation {
                return false
            }
            if lhs.effectAnimation != rhs.effectAnimation {
                return false
            }
            if lhs.aroundAnimation != rhs.aroundAnimation {
                return false
            }
            if lhs.centerAnimation != rhs.centerAnimation {
                return false
            }
            return true
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.isEnabled = try container.decode(Bool.self, forKey: .isEnabled)
            self.isPremium = try container.decodeIfPresent(Bool.self, forKey: .isPremium) ?? false
            
            let isStars = try container.decodeIfPresent(Bool.self, forKey: .isStars) ?? false
            if isStars {
                self.value = .stars
            } else {
                self.value = .builtin(try container.decode(String.self, forKey: .value))
            }
            self.title = try container.decode(String.self, forKey: .title)
            
            if let staticIconData = try container.decodeIfPresent(Data.self, forKey: .staticIconData) {
                var byteBuffer = ByteBuffer(data: staticIconData)
                self.staticIcon = IosappMediaFile.Accessor(FlatBuffers_getRoot(byteBuffer: &byteBuffer) as IosappCore_IosappMediaFile, staticIconData)
            } else {
                let staticIconData = try container.decode(AdaptedPostboxDecoder.RawObjectData.self, forKey: .staticIcon)
                self.staticIcon = IosappMediaFile.Accessor(IosappMediaFile(decoder: PostboxDecoder(buffer: MemoryBuffer(data: staticIconData.data))))
            }
            
            if let appearAnimationData = try container.decodeIfPresent(Data.self, forKey: .appearAnimationData) {
                var byteBuffer = ByteBuffer(data: appearAnimationData)
                self.appearAnimation = IosappMediaFile.Accessor(FlatBuffers_getRoot(byteBuffer: &byteBuffer) as IosappCore_IosappMediaFile, appearAnimationData)
            } else {
                let appearAnimationData = try container.decode(AdaptedPostboxDecoder.RawObjectData.self, forKey: .appearAnimation)
                self.appearAnimation = IosappMediaFile.Accessor(IosappMediaFile(decoder: PostboxDecoder(buffer: MemoryBuffer(data: appearAnimationData.data))))
            }
            
            if let selectAnimationData = try container.decodeIfPresent(Data.self, forKey: .selectAnimationData) {
                var byteBuffer = ByteBuffer(data: selectAnimationData)
                self.selectAnimation = IosappMediaFile.Accessor(FlatBuffers_getRoot(byteBuffer: &byteBuffer) as IosappCore_IosappMediaFile, selectAnimationData)
            } else {
                let selectAnimationData = try container.decode(AdaptedPostboxDecoder.RawObjectData.self, forKey: .selectAnimation)
                self.selectAnimation = IosappMediaFile.Accessor(IosappMediaFile(decoder: PostboxDecoder(buffer: MemoryBuffer(data: selectAnimationData.data))))
            }
            
            if let activateAnimationData = try container.decodeIfPresent(Data.self, forKey: .activateAnimationData) {
                var byteBuffer = ByteBuffer(data: activateAnimationData)
                self.activateAnimation = IosappMediaFile.Accessor(FlatBuffers_getRoot(byteBuffer: &byteBuffer) as IosappCore_IosappMediaFile, activateAnimationData)
            } else {
                let activateAnimationData = try container.decode(AdaptedPostboxDecoder.RawObjectData.self, forKey: .activateAnimation)
                self.activateAnimation = IosappMediaFile.Accessor(IosappMediaFile(decoder: PostboxDecoder(buffer: MemoryBuffer(data: activateAnimationData.data))))
            }
            
            if let effectAnimationData = try container.decodeIfPresent(Data.self, forKey: .effectAnimationData) {
                var byteBuffer = ByteBuffer(data: effectAnimationData)
                self.effectAnimation = IosappMediaFile.Accessor(FlatBuffers_getRoot(byteBuffer: &byteBuffer) as IosappCore_IosappMediaFile, effectAnimationData)
            } else {
                let effectAnimationData = try container.decode(AdaptedPostboxDecoder.RawObjectData.self, forKey: .effectAnimation)
                self.effectAnimation = IosappMediaFile.Accessor(IosappMediaFile(decoder: PostboxDecoder(buffer: MemoryBuffer(data: effectAnimationData.data))))
            }
            
            if let aroundAnimationData = try container.decodeIfPresent(Data.self, forKey: .aroundAnimationData) {
                var byteBuffer = ByteBuffer(data: aroundAnimationData)
                self.aroundAnimation = IosappMediaFile.Accessor(FlatBuffers_getRoot(byteBuffer: &byteBuffer) as IosappCore_IosappMediaFile, aroundAnimationData)
            } else if let aroundAnimationData = try container.decodeIfPresent(AdaptedPostboxDecoder.RawObjectData.self, forKey: .aroundAnimation) {
                self.aroundAnimation = IosappMediaFile.Accessor(IosappMediaFile(decoder: PostboxDecoder(buffer: MemoryBuffer(data: aroundAnimationData.data))))
            } else {
                self.aroundAnimation = nil
            }
                
            if let centerAnimationData = try container.decodeIfPresent(Data.self, forKey: .centerAnimationData) {
                var byteBuffer = ByteBuffer(data: centerAnimationData)
                self.centerAnimation = IosappMediaFile.Accessor(FlatBuffers_getRoot(byteBuffer: &byteBuffer) as IosappCore_IosappMediaFile, centerAnimationData)
            } else if let centerAnimationData = try container.decodeIfPresent(AdaptedPostboxDecoder.RawObjectData.self, forKey: .centerAnimation) {
                self.centerAnimation = IosappMediaFile.Accessor(IosappMediaFile(decoder: PostboxDecoder(buffer: MemoryBuffer(data: centerAnimationData.data))))
            } else {
                self.centerAnimation = nil
            }
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encode(self.isEnabled, forKey: .isEnabled)
            try container.encode(self.isPremium, forKey: .isPremium)
            
            switch self.value {
            case let .builtin(value):
                try container.encode(value, forKey: .value)
            case .custom:
                break
            case .stars:
                try container.encode(true, forKey: .isStars)
            }
            try container.encode(self.title, forKey: .title)
            
            let encodeFileItem: (IosappMediaFile.Accessor, CodingKeys) throws -> Void = { file, key in
                if let serializedFile = file._wrappedData {
                    try container.encode(serializedFile, forKey: key)
                } else if let file = file._wrappedFile {
                    var builder = FlatBufferBuilder(initialSize: 1024)
                    let value = file.encodeToFlatBuffers(builder: &builder)
                    builder.finish(offset: value)
                    let serializedFile = builder.data
                    try container.encode(serializedFile, forKey: key)
                } else {
                    preconditionFailure()
                }
            }
            
            try encodeFileItem(self.staticIcon, .staticIconData)
            try encodeFileItem(self.appearAnimation, .appearAnimationData)
            try encodeFileItem(self.selectAnimation, .selectAnimationData)
            try encodeFileItem(self.activateAnimation, .activateAnimationData)
            try encodeFileItem(self.effectAnimation, .effectAnimationData)
            
            if let aroundAnimation = self.aroundAnimation {
                try encodeFileItem(aroundAnimation, .aroundAnimationData)
            }
            if let centerAnimation = self.centerAnimation {
                try encodeFileItem(centerAnimation, .centerAnimationData)
            }
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case newHash
        case reactions
    }
    
    public let hash: Int32
    public let reactions: [Reaction]
    
    public init(
        hash: Int32,
        reactions: [Reaction]
    ) {
        self.hash = hash
        
        var reactions = reactions
        reactions.removeAll(where: { if case .stars = $0.value { return true } else { return false } })
        reactions.append(sharedStarsReaction)
        self.reactions = reactions
    }
    
    public static func ==(lhs: AvailableReactions, rhs: AvailableReactions) -> Bool {
        if lhs.hash != rhs.hash {
            return false
        }
        if lhs.reactions != rhs.reactions {
            return false
        }
        return true
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.hash = try container.decodeIfPresent(Int32.self, forKey: .newHash) ?? 0
        
        var reactions = try container.decode([Reaction].self, forKey: .reactions)
        reactions.removeAll(where: { if case .stars = $0.value { return true } else { return false } })
        reactions.append(sharedStarsReaction)
        self.reactions = reactions
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.hash, forKey: .newHash)
        try container.encode(self.reactions, forKey: .reactions)
    }
}

private extension AvailableReactions.Reaction {
    convenience init?(apiReaction: Api.AvailableReaction) {
        switch apiReaction {
        case let .availableReaction(availableReactionData):
            let (flags, reaction, title, staticIcon, appearAnimation, selectAnimation, activateAnimation, effectAnimation, aroundAnimation, centerIcon) = (availableReactionData.flags, availableReactionData.reaction, availableReactionData.title, availableReactionData.staticIcon, availableReactionData.appearAnimation, availableReactionData.selectAnimation, availableReactionData.activateAnimation, availableReactionData.effectAnimation, availableReactionData.aroundAnimation, availableReactionData.centerIcon)
            guard let staticIconFile = telegramMediaFileFromApiDocument(staticIcon, altDocuments: []) else {
                return nil
            }
            guard let appearAnimationFile = telegramMediaFileFromApiDocument(appearAnimation, altDocuments: []) else {
                return nil
            }
            guard let selectAnimationFile = telegramMediaFileFromApiDocument(selectAnimation, altDocuments: []) else {
                return nil
            }
            guard let activateAnimationFile = telegramMediaFileFromApiDocument(activateAnimation, altDocuments: []) else {
                return nil
            }
            guard let effectAnimationFile = telegramMediaFileFromApiDocument(effectAnimation, altDocuments: []) else {
                return nil
            }
            let aroundAnimationFile = aroundAnimation.flatMap { telegramMediaFileFromApiDocument($0, altDocuments: []) }
            let centerAnimationFile = centerIcon.flatMap { telegramMediaFileFromApiDocument($0, altDocuments: []) }
            let isEnabled = (flags & (1 << 0)) == 0
            let isPremium = (flags & (1 << 2)) != 0
            self.init(
                isEnabled: isEnabled,
                isPremium: isPremium,
                value: .builtin(reaction),
                title: title,
                staticIcon: staticIconFile,
                appearAnimation: appearAnimationFile,
                selectAnimation: selectAnimationFile,
                activateAnimation: activateAnimationFile,
                effectAnimation: effectAnimationFile,
                aroundAnimation: aroundAnimationFile,
                centerAnimation: centerAnimationFile
            )
        }
    }
}

func _internal_cachedAvailableReactions(postbox: Postbox) -> Signal<AvailableReactions?, NoError> {
    return postbox.transaction { transaction -> AvailableReactions? in
        return _internal_cachedAvailableReactions(transaction: transaction)
    }
}

func _internal_cachedAvailableReactions(transaction: Transaction) -> AvailableReactions? {
    let key = ValueBoxKey(length: 8)
    key.setInt64(0, value: 0)
    
    let cached = transaction.retrieveItemCacheEntry(id: ItemCacheEntryId(collectionId: Namespaces.CachedItemCollection.availableReactions, key: key))?.get(AvailableReactions.self)
    if let cached = cached {
        return cached
    } else {
        return nil
    }
}

func _internal_setCachedAvailableReactions(transaction: Transaction, availableReactions: AvailableReactions) {
    let key = ValueBoxKey(length: 8)
    key.setInt64(0, value: 0)
    
    if let entry = CodableEntry(availableReactions) {
        transaction.putItemCacheEntry(id: ItemCacheEntryId(collectionId: Namespaces.CachedItemCollection.availableReactions, key: key), entry: entry)
    }
}

func managedSynchronizeAvailableReactions(postbox: Postbox, network: Network) -> Signal<Never, NoError> {
    let starsReaction = sharedStarsReaction
    let mapping: [String: KeyPath<AvailableReactions.Reaction, IosappMediaFile.Accessor>] = [
        "star_reaction_activate.ass": \.activateAnimation,
        "star_reaction_appear.ass": \.appearAnimation,
        "star_reaction_effect.ass": \.effectAnimation,
        "star_reaction_select.ass": \.selectAnimation,
        "star_reaction_static_icon.webp": \.staticIcon
    ]
    let optionalMapping: [String: KeyPath<AvailableReactions.Reaction, IosappMediaFile.Accessor?>] = [
        "star_reaction_center.ass": \.centerAnimation,
        "star_reaction_effect.ass": \.aroundAnimation
    ]
    for (key, path) in mapping {
        if let filePath = Bundle.main.path(forResource: key, ofType: nil), let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)) {
            postbox.mediaBox.storeResourceData(starsReaction[keyPath: path]._parse().resource.id, data: data)
        }
    }
    for (key, path) in optionalMapping {
        if let filePath = Bundle.main.path(forResource: key, ofType: nil), let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)) {
            if let file = starsReaction[keyPath: path] {
                postbox.mediaBox.storeResourceData(file._parse().resource.id, data: data)
            }
        }
    }
    
    let poll = Signal<Never, NoError> { subscriber in
        let signal: Signal<Never, NoError> = _internal_cachedAvailableReactions(postbox: postbox)
        |> mapToSignal { current in
            return (network.request(Api.functions.messages.getAvailableReactions(hash: current?.hash ?? 0))
            |> map(Optional.init)
            |> `catch` { _ -> Signal<Api.messages.AvailableReactions?, NoError> in
                return .single(nil)
            }
            |> mapToSignal { result -> Signal<Never, NoError> in
                return postbox.transaction { transaction -> Signal<Never, NoError> in
                    guard let result = result else {
                        return .complete()
                    }
                    
                    switch result {
                    case let .availableReactions(availableReactionsData):
                        let (hash, reactions) = (availableReactionsData.hash, availableReactionsData.reactions)
                        let availableReactions = AvailableReactions(
                            hash: hash,
                            reactions: reactions.compactMap(AvailableReactions.Reaction.init(apiReaction:))
                        )
                        _internal_setCachedAvailableReactions(transaction: transaction, availableReactions: availableReactions)
                    case .availableReactionsNotModified:
                        break
                    }
                    
                    var signals: [Signal<Never, NoError>] = []
                    
                    if let availableReactions = _internal_cachedAvailableReactions(transaction: transaction) {
                        var resources: [MediaResource] = []
                        
                        for reaction in availableReactions.reactions {
                            resources.append(reaction.staticIcon._parse().resource)
                            resources.append(reaction.appearAnimation._parse().resource)
                            resources.append(reaction.selectAnimation._parse().resource)
                            resources.append(reaction.activateAnimation._parse().resource)
                            resources.append(reaction.effectAnimation._parse().resource)
                            if let centerAnimation = reaction.centerAnimation {
                                resources.append(centerAnimation._parse().resource)
                            }
                            if let aroundAnimation = reaction.aroundAnimation {
                                resources.append(aroundAnimation._parse().resource)
                            }
                        }
                        
                        for resource in resources {
                            signals.append(
                                fetchedMediaResource(mediaBox: postbox.mediaBox, userLocation: .other, userContentType: .other, reference: .standalone(resource: resource))
                                |> ignoreValues
                                |> `catch` { _ -> Signal<Never, NoError> in
                                    return .complete()
                                }
                            )
                        }
                    }
                    
                    return combineLatest(signals)
                    |> ignoreValues
                }
                |> switchToLatest
            })
        }
                
        return signal.start(completed: {
            subscriber.putCompletion()
        })
    }
    
    return (
    	poll
    	|> then(
    		.complete()
    		|> suspendAwareDelay(1.0 * 60.0 * 60.0, queue: Queue.concurrentDefaultQueue())
    	)
    )
    |> restart
}
