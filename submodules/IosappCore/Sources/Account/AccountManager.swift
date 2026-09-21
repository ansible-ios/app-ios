import Foundation
import Postbox
import SwiftSignalKit
import IosappApi
import MtProtoKit

private enum AccountKind {
    case authorized
    case unauthorized
}

public struct AccountSupportUserInfo: Codable, Equatable {
    public init() {
    }
}

public enum IosappAccountRecordAttribute: AccountRecordAttribute, Equatable {
    enum CodingKeys: String, CodingKey {
        case backupData
        case environment
        case sortOrder
        case loggedOut
        case supportUserInfo
        case legacyRootObject = "_"
    }

    case backupData(AccountBackupDataAttribute)
    case environment(AccountEnvironmentAttribute)
    case sortOrder(AccountSortOrderAttribute)
    case loggedOut(LoggedOutAccountAttribute)
    case supportUserInfo(AccountSupportUserInfo)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let backupData = try? container.decodeIfPresent(AccountBackupDataAttribute.self, forKey: .backupData) {
            self = .backupData(backupData)
        } else if let environment = try? container.decodeIfPresent(AccountEnvironmentAttribute.self, forKey: .environment) {
            self = .environment(environment)
        } else if let sortOrder = try? container.decodeIfPresent(AccountSortOrderAttribute.self, forKey: .sortOrder) {
            self = .sortOrder(sortOrder)
        } else if let loggedOut = try? container.decodeIfPresent(LoggedOutAccountAttribute.self, forKey: .loggedOut) {
            self = .loggedOut(loggedOut)
        } else if let supportUserInfo = try? container.decodeIfPresent(AccountSupportUserInfo.self, forKey: .supportUserInfo) {
            self = .supportUserInfo(supportUserInfo)
        } else {
            let legacyRootObjectData = try! container.decode(AdaptedPostboxDecoder.RawObjectData.self, forKey: .legacyRootObject)
            if legacyRootObjectData.typeHash == postboxEncodableTypeHash(AccountBackupDataAttribute.self) {
                self = .backupData(try! AdaptedPostboxDecoder().decode(AccountBackupDataAttribute.self, from: legacyRootObjectData.data))
            } else if legacyRootObjectData.typeHash == postboxEncodableTypeHash(AccountEnvironmentAttribute.self) {
                self = .environment(try! AdaptedPostboxDecoder().decode(AccountEnvironmentAttribute.self, from: legacyRootObjectData.data))
            } else if legacyRootObjectData.typeHash == postboxEncodableTypeHash(AccountSortOrderAttribute.self) {
                self = .sortOrder(try! AdaptedPostboxDecoder().decode(AccountSortOrderAttribute.self, from: legacyRootObjectData.data))
            } else if legacyRootObjectData.typeHash == postboxEncodableTypeHash(LoggedOutAccountAttribute.self) {
                self = .loggedOut(try! AdaptedPostboxDecoder().decode(LoggedOutAccountAttribute.self, from: legacyRootObjectData.data))
            } else {
                preconditionFailure()
            }
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case let .backupData(backupData):
            try container.encode(backupData, forKey: .backupData)
        case let .environment(environment):
            try container.encode(environment, forKey: .environment)
        case let .sortOrder(sortOrder):
            try container.encode(sortOrder, forKey: .sortOrder)
        case let .loggedOut(loggedOut):
            try container.encode(loggedOut, forKey: .loggedOut)
        case let .supportUserInfo(supportUserInfo):
            try container.encode(supportUserInfo, forKey: .supportUserInfo)
        }
    }

    public func isEqual(to: AccountRecordAttribute) -> Bool {
        return self == to as? IosappAccountRecordAttribute
    }
}

public final class IosappAccountManagerTypes: AccountManagerTypes {
    public typealias Attribute = IosappAccountRecordAttribute
}

private var declaredEncodables: Void = {
    declareEncodable(UnauthorizedAccountState.self, f: { UnauthorizedAccountState(decoder: $0) })
    declareEncodable(AuthorizedAccountState.self, f: { AuthorizedAccountState(decoder: $0) })
    declareEncodable(IosappUser.self, f: { IosappUser(decoder: $0) })
    declareEncodable(IosappGroup.self, f: { IosappGroup(decoder: $0) })
    declareEncodable(IosappChannel.self, f: { IosappChannel(decoder: $0) })
    declareEncodable(IosappCommunity.self, f: { IosappCommunity(decoder: $0) })
    declareEncodable(IosappMediaImage.self, f: { IosappMediaImage(decoder: $0) })
    declareEncodable(IosappMediaImageRepresentation.self, f: { IosappMediaImageRepresentation(decoder: $0) })
    declareEncodable(IosappMediaContact.self, f: { IosappMediaContact(decoder: $0) })
    declareEncodable(IosappMediaMap.self, f: { IosappMediaMap(decoder: $0) })
    declareEncodable(IosappMediaFile.self, f: { IosappMediaFile(decoder: $0) })
    declareEncodable(IosappMediaFileAttribute.self, f: { IosappMediaFileAttribute(decoder: $0) })
    declareEncodable(CloudFileMediaResource.self, f: { CloudFileMediaResource(decoder: $0) })
    declareEncodable(ChannelState.self, f: { ChannelState(decoder: $0) })
    declareEncodable(RegularChatState.self, f: { RegularChatState(decoder: $0) })
    declareEncodable(InlineBotMessageAttribute.self, f: { InlineBotMessageAttribute(decoder: $0) })
    declareEncodable(InlineBusinessBotMessageAttribute.self, f: { InlineBusinessBotMessageAttribute(decoder: $0) })
    declareEncodable(TextEntitiesMessageAttribute.self, f: { TextEntitiesMessageAttribute(decoder: $0) })
    declareEncodable(RichTextMessageAttribute.self, f: { RichTextMessageAttribute(decoder: $0) })
    declareEncodable(ReplyMessageAttribute.self, f: { ReplyMessageAttribute(decoder: $0) })
    declareEncodable(QuotedReplyMessageAttribute.self, f: { QuotedReplyMessageAttribute(decoder: $0) })
    declareEncodable(ReplyStoryAttribute.self, f: { ReplyStoryAttribute(decoder: $0) })
    declareEncodable(ReplyThreadMessageAttribute.self, f: { ReplyThreadMessageAttribute(decoder: $0) })
    declareEncodable(ReactionsMessageAttribute.self, f: { ReactionsMessageAttribute(decoder: $0) })
    declareEncodable(PendingReactionsMessageAttribute.self, f: { PendingReactionsMessageAttribute(decoder: $0) })
    declareEncodable(PendingStarsReactionsMessageAttribute.self, f: { PendingStarsReactionsMessageAttribute(decoder: $0) })
    declareEncodable(CloudDocumentMediaResource.self, f: { CloudDocumentMediaResource(decoder: $0) })
    declareEncodable(IosappMediaWebpage.self, f: { IosappMediaWebpage(decoder: $0) })
    declareEncodable(ViewCountMessageAttribute.self, f: { ViewCountMessageAttribute(decoder: $0) })
    declareEncodable(ForwardCountMessageAttribute.self, f: { ForwardCountMessageAttribute(decoder: $0) })
    declareEncodable(BoostCountMessageAttribute.self, f: { BoostCountMessageAttribute(decoder: $0) })
    declareEncodable(ParticipantRankMessageAttribute.self, f: { ParticipantRankMessageAttribute(decoder: $0) })
    declareEncodable(NotificationInfoMessageAttribute.self, f: { NotificationInfoMessageAttribute(decoder: $0) })
    declareEncodable(IosappMediaAction.self, f: { IosappMediaAction(decoder: $0) })
    declareEncodable(IosappPeerNotificationSettings.self, f: { IosappPeerNotificationSettings(decoder: $0) })
    declareEncodable(CachedUserData.self, f: { CachedUserData(decoder: $0) })
    declareEncodable(BotInfo.self, f: { BotInfo(decoder: $0) })
    declareEncodable(CachedGroupData.self, f: { CachedGroupData(decoder: $0) })
    declareEncodable(CachedChannelData.self, f: { CachedChannelData(decoder: $0) })
    declareEncodable(CachedCommunityData.self, f: { CachedCommunityData(decoder: $0) })
    declareEncodable(IosappUserPresence.self, f: { IosappUserPresence(decoder: $0) })
    declareEncodable(LocalFileMediaResource.self, f: { LocalFileMediaResource(decoder: $0) })
    declareEncodable(StickerPackCollectionInfo.self, f: { StickerPackCollectionInfo(decoder: $0) })
    declareEncodable(StickerPackItem.self, f: { StickerPackItem(decoder: $0) })
    declareEncodable(LocalFileReferenceMediaResource.self, f: { LocalFileReferenceMediaResource(decoder: $0) })
    declareEncodable(OutgoingMessageInfoAttribute.self, f: { OutgoingMessageInfoAttribute(decoder: $0) })
    declareEncodable(EphemeralMessageAttribute.self, f: { EphemeralMessageAttribute(decoder: $0) })
    declareEncodable(EphemeralOutgoingMessageAttribute.self, f: { EphemeralOutgoingMessageAttribute(decoder: $0) })
    declareEncodable(ForwardSourceInfoAttribute.self, f: { ForwardSourceInfoAttribute(decoder: $0) })
    declareEncodable(SourceReferenceMessageAttribute.self, f: { SourceReferenceMessageAttribute(decoder: $0) })
    declareEncodable(SourceAuthorInfoMessageAttribute.self, f: { SourceAuthorInfoMessageAttribute(decoder: $0) })
    declareEncodable(EditedMessageAttribute.self, f: { EditedMessageAttribute(decoder: $0) })
    declareEncodable(ReplyMarkupMessageAttribute.self, f: { ReplyMarkupMessageAttribute(decoder: $0) })
    declareEncodable(OutgoingChatContextResultMessageAttribute.self, f: { OutgoingChatContextResultMessageAttribute(decoder: $0) })
    declareEncodable(HttpReferenceMediaResource.self, f: { HttpReferenceMediaResource(decoder: $0) })
    declareEncodable(WebFileReferenceMediaResource.self, f: { WebFileReferenceMediaResource(decoder: $0) })
    declareEncodable(EmptyMediaResource.self, f: { EmptyMediaResource(decoder: $0) })
    declareEncodable(IosappSecretChat.self, f: { IosappSecretChat(decoder: $0) })
    declareEncodable(SecretChatState.self, f: { SecretChatState(decoder: $0) })
    declareEncodable(SecretChatIncomingEncryptedOperation.self, f: { SecretChatIncomingEncryptedOperation(decoder: $0) })
    declareEncodable(SecretChatIncomingDecryptedOperation.self, f: { SecretChatIncomingDecryptedOperation(decoder: $0) })
    declareEncodable(SecretChatOutgoingOperation.self, f: { SecretChatOutgoingOperation(decoder: $0) })
    declareEncodable(SecretFileMediaResource.self, f: { SecretFileMediaResource(decoder: $0) })
    declareEncodable(CloudChatRemoveMessagesOperation.self, f: { CloudChatRemoveMessagesOperation(decoder: $0) })
    declareEncodable(AutoremoveTimeoutMessageAttribute.self, f: { AutoremoveTimeoutMessageAttribute(decoder: $0) })
    declareEncodable(AutoclearTimeoutMessageAttribute.self, f: { AutoclearTimeoutMessageAttribute(decoder: $0) })
    declareEncodable(CloudChatRemoveChatOperation.self, f: { CloudChatRemoveChatOperation(decoder: $0) })
    declareEncodable(SynchronizePinnedChatsOperation.self, f: { SynchronizePinnedChatsOperation(decoder: $0) })
    declareEncodable(SynchronizeConsumeMessageContentsOperation.self, f: { SynchronizeConsumeMessageContentsOperation(decoder: $0) })
    declareEncodable(CloudChatClearHistoryOperation.self, f: { CloudChatClearHistoryOperation(decoder: $0) })
    declareEncodable(OutgoingContentInfoMessageAttribute.self, f: { OutgoingContentInfoMessageAttribute(decoder: $0) })
    declareEncodable(ConsumableContentMessageAttribute.self, f: { ConsumableContentMessageAttribute(decoder: $0) })
    declareEncodable(IosappMediaGame.self, f: { IosappMediaGame(decoder: $0) })
    declareEncodable(IosappMediaInvoice.self, f: { IosappMediaInvoice(decoder: $0) })
    declareEncodable(IosappMediaWebFile.self, f: { IosappMediaWebFile(decoder: $0) })
    declareEncodable(SynchronizeInstalledStickerPacksOperation.self, f: { SynchronizeInstalledStickerPacksOperation(decoder: $0) })
    declareEncodable(SynchronizeMarkFeaturedStickerPacksAsSeenOperation.self, f: { SynchronizeMarkFeaturedStickerPacksAsSeenOperation(decoder: $0) })
    declareEncodable(SynchronizeChatInputStateOperation.self, f: { SynchronizeChatInputStateOperation(decoder: $0) })
    declareEncodable(SynchronizeSavedGifsOperation.self, f: { SynchronizeSavedGifsOperation(decoder: $0) })
    declareEncodable(SynchronizeSavedStickersOperation.self, f: { SynchronizeSavedStickersOperation(decoder: $0) })
    declareEncodable(SynchronizeRecentlyUsedMediaOperation.self, f: { SynchronizeRecentlyUsedMediaOperation(decoder: $0) })
    declareEncodable(SynchronizeLocalizationUpdatesOperation.self, f: { SynchronizeLocalizationUpdatesOperation(decoder: $0) })
    declareEncodable(ChannelMessageStateVersionAttribute.self, f: { ChannelMessageStateVersionAttribute(decoder: $0) })
    declareEncodable(PeerGroupMessageStateVersionAttribute.self, f: { PeerGroupMessageStateVersionAttribute(decoder: $0) })
    declareEncodable(CachedSecretChatData.self, f: { CachedSecretChatData(decoder: $0) })
    declareEncodable(AuthorSignatureMessageAttribute.self, f: { AuthorSignatureMessageAttribute(decoder: $0) })
    declareEncodable(IosappMediaExpiredContent.self, f: { IosappMediaExpiredContent(decoder: $0) })
    declareEncodable(ConsumablePersonalMentionMessageAttribute.self, f: { ConsumablePersonalMentionMessageAttribute(decoder: $0) })
    declareEncodable(ConsumePersonalMessageAction.self, f: { ConsumePersonalMessageAction(decoder: $0) })
    declareEncodable(ReadReactionAction.self, f: { ReadReactionAction(decoder: $0) })
    declareEncodable(SynchronizeGroupedPeersOperation.self, f: { SynchronizeGroupedPeersOperation(decoder: $0) })
    declareEncodable(IosappDeviceContactImportedData.self, f: { IosappDeviceContactImportedData(decoder: $0) })
    declareEncodable(SecureFileMediaResource.self, f: { SecureFileMediaResource(decoder: $0) })
    declareEncodable(SynchronizeMarkAllUnseenPersonalMessagesOperation.self, f: { SynchronizeMarkAllUnseenPersonalMessagesOperation(decoder: $0) })
    declareEncodable(SynchronizeMarkAllUnseenReactionsOperation.self, f: { SynchronizeMarkAllUnseenReactionsOperation(decoder: $0) })
    declareEncodable(SynchronizeAppLogEventsOperation.self, f: { SynchronizeAppLogEventsOperation(decoder: $0) })
    declareEncodable(IosappMediaPoll.self, f: { IosappMediaPoll(decoder: $0) })
    declareEncodable(IosappMediaUnsupported.self, f: { IosappMediaUnsupported(decoder: $0) })
    declareEncodable(EmojiKeywordCollectionInfo.self, f: { EmojiKeywordCollectionInfo(decoder: $0) })
    declareEncodable(EmojiKeywordItem.self, f: { EmojiKeywordItem(decoder: $0) })
    declareEncodable(SynchronizeEmojiKeywordsOperation.self, f: { SynchronizeEmojiKeywordsOperation(decoder: $0) })
    declareEncodable(CloudPhotoSizeMediaResource.self, f: { CloudPhotoSizeMediaResource(decoder: $0) })
    declareEncodable(CloudDocumentSizeMediaResource.self, f: { CloudDocumentSizeMediaResource(decoder: $0) })
    declareEncodable(CloudPeerPhotoSizeMediaResource.self, f: { CloudPeerPhotoSizeMediaResource(decoder: $0) })
    declareEncodable(CloudStickerPackThumbnailMediaResource.self, f: { CloudStickerPackThumbnailMediaResource(decoder: $0) })
    declareEncodable(ContentRequiresValidationMessageAttribute.self, f: { ContentRequiresValidationMessageAttribute(decoder: $0) })
    declareEncodable(PendingProcessingMessageAttribute.self, f: { PendingProcessingMessageAttribute(decoder: $0) })
    declareEncodable(OutgoingScheduleInfoMessageAttribute.self, f: { OutgoingScheduleInfoMessageAttribute(decoder: $0) })
    declareEncodable(UpdateMessageReactionsAction.self, f: { UpdateMessageReactionsAction(decoder: $0) })
    declareEncodable(SendStarsReactionsAction.self, f: { SendStarsReactionsAction(decoder: $0) })
    declareEncodable(PostponeSendPaidMessageAction.self, f: { PostponeSendPaidMessageAction(decoder: $0) })
    declareEncodable(RestrictedContentMessageAttribute.self, f: { RestrictedContentMessageAttribute(decoder: $0) })
    declareEncodable(SendScheduledMessageImmediatelyAction.self, f: { SendScheduledMessageImmediatelyAction(decoder: $0) })
    declareEncodable(EmbeddedMediaStickersMessageAttribute.self, f: { EmbeddedMediaStickersMessageAttribute(decoder: $0) })
    declareEncodable(IosappMediaWebpageAttribute.self, f: { IosappMediaWebpageAttribute(decoder: $0) })
    declareEncodable(IosappMediaDice.self, f: { IosappMediaDice(decoder: $0) })
    declareEncodable(SynchronizeChatListFiltersOperation.self, f: { SynchronizeChatListFiltersOperation(decoder: $0) })
    declareEncodable(PromoChatListItem.self, f: { PromoChatListItem(decoder: $0) })
    declareEncodable(IosappMediaFile.VideoThumbnail.self, f: { IosappMediaFile.VideoThumbnail(decoder: $0) })
    declareEncodable(PeerAccessRestrictionInfo.self, f: { PeerAccessRestrictionInfo(decoder: $0) })
    declareEncodable(IosappMediaImage.VideoRepresentation.self, f: { IosappMediaImage.VideoRepresentation(decoder: $0) })
    declareEncodable(ValidationMessageAttribute.self, f: { ValidationMessageAttribute(decoder: $0) })
    declareEncodable(EmojiSearchQueryMessageAttribute.self, f: { EmojiSearchQueryMessageAttribute(decoder: $0) })
    declareEncodable(WallpaperDataResource.self, f: { WallpaperDataResource(decoder: $0) })
    declareEncodable(ForwardOptionsMessageAttribute.self, f: { ForwardOptionsMessageAttribute(decoder: $0) })
    declareEncodable(SendAsMessageAttribute.self, f: { SendAsMessageAttribute(decoder: $0) })
    declareEncodable(ForwardVideoTimestampAttribute.self, f: { ForwardVideoTimestampAttribute(decoder: $0) })
    declareEncodable(AudioTranscriptionMessageAttribute.self, f: { AudioTranscriptionMessageAttribute(decoder: $0) })
    declareEncodable(NonPremiumMessageAttribute.self, f: { NonPremiumMessageAttribute(decoder: $0) })
    declareEncodable(IosappExtendedMedia.self, f: { IosappExtendedMedia(decoder: $0) })
    declareEncodable(IosappPeerUsername.self, f: { IosappPeerUsername(decoder: $0) })
    declareEncodable(MediaSpoilerMessageAttribute.self, f: { MediaSpoilerMessageAttribute(decoder: $0) })
    declareEncodable(AuthSessionInfoAttribute.self, f: { AuthSessionInfoAttribute(decoder: $0) })
    declareEncodable(TranslationMessageAttribute.self, f: { TranslationMessageAttribute(decoder: $0) })
    declareEncodable(TranslationMessageAttribute.Additional.self, f: { TranslationMessageAttribute.Additional(decoder: $0) })
    declareEncodable(SynchronizeAutosaveItemOperation.self, f: { SynchronizeAutosaveItemOperation(decoder: $0) })
    declareEncodable(IosappMediaStory.self, f: { IosappMediaStory(decoder: $0) })
    declareEncodable(SynchronizeViewStoriesOperation.self, f: { SynchronizeViewStoriesOperation(decoder: $0) })
    declareEncodable(SynchronizePeerStoriesOperation.self, f: { SynchronizePeerStoriesOperation(decoder: $0) })
    declareEncodable(MapVenue.self, f: { MapVenue(decoder: $0) })
    declareEncodable(MapGeoAddress.self, f: { MapGeoAddress(decoder: $0) })
    declareEncodable(IosappMediaGiveaway.self, f: { IosappMediaGiveaway(decoder: $0) })
    declareEncodable(IosappMediaGiveawayResults.self, f: { IosappMediaGiveawayResults(decoder: $0) })
    declareEncodable(WebpagePreviewMessageAttribute.self, f: { WebpagePreviewMessageAttribute(decoder: $0) })
    declareEncodable(InvertMediaMessageAttribute.self, f: { InvertMediaMessageAttribute(decoder: $0) })
    declareEncodable(DerivedDataMessageAttribute.self, f: { DerivedDataMessageAttribute(decoder: $0) })
    declareEncodable(IosappApplicationIcons.self, f: { IosappApplicationIcons(decoder: $0) })
    declareEncodable(OutgoingQuickReplyMessageAttribute.self, f: { OutgoingQuickReplyMessageAttribute(decoder: $0) })
    declareEncodable(EffectMessageAttribute.self, f: { EffectMessageAttribute(decoder: $0) })
    declareEncodable(FactCheckMessageAttribute.self, f: { FactCheckMessageAttribute(decoder: $0) })
    declareEncodable(IosappMediaPaidContent.self, f: { IosappMediaPaidContent(decoder: $0) })
    declareEncodable(ReportDeliveryMessageAttribute.self, f: { ReportDeliveryMessageAttribute(decoder: $0) })
    declareEncodable(PaidStarsMessageAttribute.self, f: { PaidStarsMessageAttribute(decoder: $0) })
    declareEncodable(IosappMediaTodo.self, f: { IosappMediaTodo(decoder: $0) })
    declareEncodable(IosappMediaTodo.Item.self, f: { IosappMediaTodo.Item(decoder: $0) })
    declareEncodable(IosappMediaTodo.Completion.self, f: { IosappMediaTodo.Completion(decoder: $0) })
    declareEncodable(SuggestedPostMessageAttribute.self, f: { SuggestedPostMessageAttribute(decoder: $0) })
    declareEncodable(PublishedSuggestedPostMessageAttribute.self, f: { PublishedSuggestedPostMessageAttribute(decoder: $0) })
    declareEncodable(IosappMediaLiveStream.self, f: { IosappMediaLiveStream(decoder: $0) })
    declareEncodable(ScheduledRepeatAttribute.self, f: { ScheduledRepeatAttribute(decoder: $0) })
    declareEncodable(SummarizationMessageAttribute.self, f: { SummarizationMessageAttribute(decoder: $0) })
    declareEncodable(GuestChatMessageAttribute.self, f: { GuestChatMessageAttribute(decoder: $0) })
    return
}()

public func initializeAccountManagement() {
    let _ = declaredEncodables
}

public func rootPathForBasePath(_ appGroupPath: String) -> String {
    return appGroupPath + "/telegram-data"
}

public func performAppGroupUpgrades(appGroupPath: String, rootPath: String) {
    DispatchQueue.global(qos: .default).async {
        let _ = try? FileManager.default.createDirectory(at: URL(fileURLWithPath: rootPath), withIntermediateDirectories: true, attributes: nil)

        if let items = FileManager.default.enumerator(at: URL(fileURLWithPath: appGroupPath), includingPropertiesForKeys: [.isDirectoryKey], options: [.skipsHiddenFiles, .skipsSubdirectoryDescendants], errorHandler: nil) {
            let allowedDirectories: [String] = [
                "telegram-data",
                "Library"
            ]

            for url in items {
                guard let url = url as? URL else {
                    continue
                }
                if let isDirectory = try? url.resourceValues(forKeys: [.isDirectoryKey]).isDirectory, isDirectory {
                    if !allowedDirectories.contains(url.lastPathComponent) {
                        let _ = try? FileManager.default.removeItem(at: url)
                    }
                }
            }
        }
    }
    
    do {
        var resourceValues = URLResourceValues()
        resourceValues.isExcludedFromBackup = true
        var mutableUrl = URL(fileURLWithPath: rootPath)
        try mutableUrl.setResourceValues(resourceValues)
    } catch let e {
        print("\(e)")
    }
}

public func currentAccount(allocateIfNotExists: Bool, networkArguments: NetworkInitializationArguments, supplementary: Bool, manager: AccountManager<IosappAccountManagerTypes>, rootPath: String, auxiliaryMethods: AccountAuxiliaryMethods, encryptionParameters: ValueBoxEncryptionParameters) -> Signal<AccountResult?, NoError> {
    return manager.currentAccountRecord(allocateIfNotExists: allocateIfNotExists)
    |> distinctUntilChanged(isEqual: { lhs, rhs in
        return lhs?.0 == rhs?.0
    })
    |> mapToSignal { record -> Signal<AccountResult?, NoError> in
        if let record = record {
            let reload = ValuePromise<Bool>(true, ignoreRepeated: false)
            return reload.get()
            |> mapToSignal { _ -> Signal<AccountResult?, NoError> in
                let beginWithTestingEnvironment = record.1.contains(where: { attribute in
                    if case let .environment(environment) = attribute, case .test = environment.environment {
                        return true
                    } else {
                        return false
                    }
                })
                let isSupportUser = record.1.contains(where: { attribute in
                    if case .supportUserInfo = attribute {
                        return true
                    } else {
                        return false
                    }
                })
                return accountWithId(accountManager: manager, networkArguments: networkArguments, id: record.0, encryptionParameters: encryptionParameters, supplementary: supplementary, isSupportUser: isSupportUser, rootPath: rootPath, beginWithTestingEnvironment: beginWithTestingEnvironment, backupData: nil, auxiliaryMethods: auxiliaryMethods)
                |> mapToSignal { accountResult -> Signal<AccountResult?, NoError> in
                    let postbox: Postbox
                    let initialKind: AccountKind
                    switch accountResult {
                        case .upgrading:
                            return .complete()
                        case let .unauthorized(account):
                            postbox = account.postbox
                            initialKind = .unauthorized
                        case let .authorized(account):
                            postbox = account.postbox
                            initialKind = .authorized
                    }
                    let updatedKind = postbox.stateView()
                    |> map { view -> Bool in
                        let kind: AccountKind
                        if view.state is AuthorizedAccountState {
                            kind = .authorized
                        } else {
                            kind = .unauthorized
                        }
                        if kind != initialKind {
                            return true
                        } else {
                            return false
                        }
                    }
                    |> distinctUntilChanged
                    
                    return Signal { subscriber in
                        subscriber.putNext(accountResult)
                        
                        return updatedKind.start(next: { value in
                            if value {
                                reload.set(true)
                            }
                        })
                    }
                }
            }
        } else {
            return .single(nil)
        }
    }
}

public func logoutFromAccount(id: AccountRecordId, accountManager: AccountManager<IosappAccountManagerTypes>, alreadyLoggedOutRemotely: Bool) -> Signal<Void, NoError> {
    Logger.shared.log("AccountManager", "logoutFromAccount \(id)")
    return accountManager.transaction { transaction -> Void in
        transaction.updateRecord(id, { current in
            if alreadyLoggedOutRemotely {
                return nil
            } else if let current = current {
                var found = false
                for attribute in current.attributes {
                    if case .loggedOut = attribute {
                        found = true
                        break
                    }
                }
                if found {
                    return current
                } else {
                    return AccountRecord(id: current.id, attributes: current.attributes + [.loggedOut(LoggedOutAccountAttribute())], temporarySessionId: nil)
                }
            } else {
                return nil
            }
        })
    }
}

public func managedCleanupAccounts(networkArguments: NetworkInitializationArguments, accountManager: AccountManager<IosappAccountManagerTypes>, rootPath: String, auxiliaryMethods: AccountAuxiliaryMethods, encryptionParameters: ValueBoxEncryptionParameters) -> Signal<Void, NoError> {
    let currentTemporarySessionId = accountManager.temporarySessionId
    return Signal { subscriber in
        let loggedOutAccounts = Atomic<[AccountRecordId: MetaDisposable]>(value: [:])
        let _ = (accountManager.transaction { transaction -> Void in
            for record in transaction.getRecords() {
                if let temporarySessionId = record.temporarySessionId, temporarySessionId != currentTemporarySessionId {
                    transaction.updateRecord(record.id, { _ in
                        return nil
                    })
                }
            }
        }).start()
        let disposable = accountManager.accountRecords().start(next: { view in
            var disposeList: [(AccountRecordId, MetaDisposable)] = []
            var beginList: [(AccountRecordId, [IosappAccountManagerTypes.Attribute], MetaDisposable)] = []
            let _ = loggedOutAccounts.modify { disposables in
                var validIds: [AccountRecordId: [IosappAccountManagerTypes.Attribute]] = [:]
                outer: for record in view.records {
                    for attribute in record.attributes {
                        if case .loggedOut = attribute {
                            validIds[record.id] = record.attributes
                            continue outer
                        }
                    }
                }
                
                var disposables = disposables
                
                for id in disposables.keys {
                    if validIds[id] == nil {
                        disposeList.append((id, disposables[id]!))
                    }
                }
                
                for (id, _) in disposeList {
                    disposables.removeValue(forKey: id)
                }
                
                for (id, attributes) in validIds {
                    if disposables[id] == nil {
                        let disposable = MetaDisposable()
                        beginList.append((id, attributes, disposable))
                        disposables[id] = disposable
                    }
                }
                
                return disposables
            }
            for (_, disposable) in disposeList {
                disposable.dispose()
            }
            for (id, attributes, disposable) in beginList {
                Logger.shared.log("managedCleanupAccounts", "cleanup \(id), current is \(String(describing: view.currentRecord?.id))")
                disposable.set(cleanupAccount(networkArguments: networkArguments, accountManager: accountManager, id: id, encryptionParameters: encryptionParameters, attributes: attributes, rootPath: rootPath, auxiliaryMethods: auxiliaryMethods).start())
            }
            
            var validPaths = Set<String>()
            for record in view.records {
                if let temporarySessionId = record.temporarySessionId, temporarySessionId != currentTemporarySessionId {
                    continue
                }
                validPaths.insert("\(accountRecordIdPathName(record.id))")
            }
            if let record = view.currentAuthAccount {
                validPaths.insert("\(accountRecordIdPathName(record.id))")
            }
            
            DispatchQueue.global(qos: .utility).async {
                if let files = try? FileManager.default.contentsOfDirectory(at: URL(fileURLWithPath: rootPath), includingPropertiesForKeys: [], options: []) {
                    for url in files {
                        if url.lastPathComponent.hasPrefix("account-") {
                            if !validPaths.contains(url.lastPathComponent) {
                                try? FileManager.default.removeItem(at: url)
                            }
                        }
                    }
                }
            }
        })
        
        return ActionDisposable {
            disposable.dispose()
        }
    }
}

public typealias AccountManagerPreferencesEntry = PreferencesEntry

private func cleanupAccount(networkArguments: NetworkInitializationArguments, accountManager: AccountManager<IosappAccountManagerTypes>, id: AccountRecordId, encryptionParameters: ValueBoxEncryptionParameters, attributes: [IosappAccountManagerTypes.Attribute], rootPath: String, auxiliaryMethods: AccountAuxiliaryMethods) -> Signal<Void, NoError> {
    let beginWithTestingEnvironment = attributes.contains(where: { attribute in
        if case let .environment(accountEnvironment) = attribute, case .test = accountEnvironment.environment {
            return true
        } else {
            return false
        }
    })
    let isSupportUser = attributes.contains(where: { attribute in
        if case .supportUserInfo = attribute {
            return true
        } else {
            return false
        }
    })
    return accountWithId(accountManager: accountManager, networkArguments: networkArguments, id: id, encryptionParameters: encryptionParameters, supplementary: true, isSupportUser: isSupportUser, rootPath: rootPath, beginWithTestingEnvironment: beginWithTestingEnvironment, backupData: nil, auxiliaryMethods: auxiliaryMethods)
    |> mapToSignal { account -> Signal<Void, NoError> in
        switch account {
            case .upgrading:
                return .complete()
            case .unauthorized:
                return .complete()
            case let .authorized(account):
                account.shouldBeServiceTaskMaster.set(.single(.always))
                return account.network.request(Api.functions.auth.logOut())
                |> map(Optional.init)
                |> `catch` { _ -> Signal<Api.auth.LoggedOut?, NoError> in
                    return .single(nil)
                }
                |> mapToSignal { result -> Signal<Void, NoError> in
                    switch result {
                    case let .loggedOut(loggedOutData):
                        let futureAuthToken = loggedOutData.futureAuthToken
                        if let futureAuthToken = futureAuthToken {
                            storeFutureLoginToken(accountManager: accountManager, token: futureAuthToken.makeData())
                        }
                    default:
                        break
                    }
                    account.shouldBeServiceTaskMaster.set(.single(.never))
                    return accountManager.transaction { transaction -> Void in
                        transaction.updateRecord(id, { _ in
                            return nil
                        })
                    }
                }
        }
    }
}
