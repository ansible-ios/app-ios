import SwiftSignalKit
import Postbox

public typealias EngineExportedPeerInvitation = ExportedInvitation
public typealias EngineSecretChatKeyFingerprint = SecretChatKeyFingerprint


public enum EnginePeerCachedInfoItem<T> {
    case known(T)
    case unknown
    
    public var knownValue: T? {
        switch self {
        case let .known(value):
            return value
        case .unknown:
            return nil
        }
    }
}

public struct EngineDisplaySavedChatsAsTopics: Codable, Equatable {
    public var value: Bool
    
    public init(value: Bool) {
        self.value = value
    }
}

extension EnginePeerCachedInfoItem: Equatable where T: Equatable {
    public static func ==(lhs: EnginePeerCachedInfoItem<T>, rhs: EnginePeerCachedInfoItem<T>) -> Bool {
        switch lhs {
        case let .known(value):
            if case .known(value) = rhs {
                return true
            } else {
                return false
            }
        case .unknown:
            if case .unknown = rhs {
                return true
            } else {
                return false
            }
        }
    }
}

public enum EngineChannelParticipant: Equatable {
    case creator(id: EnginePeer.Id, adminInfo: ChannelParticipantAdminInfo?, rank: String?)
    case member(id: EnginePeer.Id, invitedAt: Int32, adminInfo: ChannelParticipantAdminInfo?, banInfo: ChannelParticipantBannedInfo?, rank: String?, subscriptionUntilDate: Int32?)
    
    public var peerId: EnginePeer.Id {
        switch self {
        case let .creator(id, _, _):
            return id
        case let .member(id, _, _, _, _, _):
            return id
        }
    }
}

public extension EngineChannelParticipant {
    init(_ participant: ChannelParticipant) {
        switch participant {
        case let .creator(id, adminInfo, rank):
            self = .creator(id: id, adminInfo: adminInfo, rank: rank)
        case let .member(id, invitedAt, adminInfo, banInfo, rank, subscriptionUntilDate):
            self = .member(id: id, invitedAt: invitedAt, adminInfo: adminInfo, banInfo: banInfo, rank: rank, subscriptionUntilDate: subscriptionUntilDate)
        }
    }
    
    func _asParticipant() -> ChannelParticipant {
        switch self {
        case let .creator(id, adminInfo, rank):
            return .creator(id: id, adminInfo: adminInfo, rank: rank)
        case let .member(id, invitedAt, adminInfo, banInfo, rank, subscriptionUntilDate):
            return .member(id: id, invitedAt: invitedAt, adminInfo: adminInfo, banInfo: banInfo, rank: rank, subscriptionUntilDate: subscriptionUntilDate)
        }
    }
}

public enum EngineLegacyGroupParticipant: Equatable {
    case member(id: EnginePeer.Id, invitedBy: EnginePeer.Id, invitedAt: Int32, rank: String?)
    case creator(id: EnginePeer.Id, rank: String?)
    case admin(id: EnginePeer.Id, invitedBy: EnginePeer.Id, invitedAt: Int32, rank: String?)
    
    public var peerId: EnginePeer.Id {
        switch self {
        case let .member(id, _, _, _):
            return id
        case let .creator(id, _):
            return id
        case let .admin(id, _, _, _):
            return id
        }
    }

    public var rank: String? {
        switch self {
        case let .member(_, _, _, rank):
            return rank
        case let .creator(_, rank):
            return rank
        case let .admin(_, _, _, rank):
            return rank
        }
    }
}

public extension EngineLegacyGroupParticipant {
    init(_ participant: GroupParticipant) {
        switch participant {
        case let .member(id, invitedBy, invitedAt, rank):
            self = .member(id: id, invitedBy: invitedBy, invitedAt: invitedAt, rank: rank)
        case let .creator(id, rank):
            self = .creator(id: id, rank: rank)
        case let .admin(id, invitedBy, invitedAt, rank):
            self = .admin(id: id, invitedBy: invitedBy, invitedAt: invitedAt, rank: rank)
        }
    }
    
    func _asParticipant() -> GroupParticipant {
        switch self {
        case let .member(id, invitedBy, invitedAt, rank):
            return .member(id: id, invitedBy: invitedBy, invitedAt: invitedAt, rank: rank)
        case let .creator(id, rank):
            return .creator(id: id, rank: rank)
        case let .admin(id, invitedBy, invitedAt, rank):
            return .admin(id: id, invitedBy: invitedBy, invitedAt: invitedAt, rank: rank)
        }
    }
}

public extension IosappEngine.EngineData.Item {
    enum NotificationSettings {
        public struct Global: IosappEngineDataItem, PostboxViewDataItem {
            public typealias Result = EngineGlobalNotificationSettings

            public init() {
            }

            var key: PostboxViewKey {
                return .preferences(keys: Set([PreferencesKeys.globalNotifications]))
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? PreferencesView else {
                    preconditionFailure()
                }
                guard let notificationSettings = view.values[PreferencesKeys.globalNotifications]?.get(GlobalNotificationSettings.self) else {
                    return EngineGlobalNotificationSettings(GlobalNotificationSettings.defaultSettings.effective)
                }
                return EngineGlobalNotificationSettings(notificationSettings.effective)
            }
        }
    }
    
    enum Peer {
        public struct Peer: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Optional<EnginePeer>

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .basicPeer(self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? BasicPeerView else {
                    preconditionFailure()
                }
                guard let peer = view.peer else {
                    return nil
                }
                return EnginePeer(peer)
            }
        }

        public struct MainPeer: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Optional<EnginePeer>

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .peer(peerId: self.id, components: [])
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? PeerView else {
                    preconditionFailure()
                }
                guard let peer = view.peers[self.id] else {
                    return nil
                }
                if let secretChat = peer as? IosappSecretChat {
                    return view.peers[secretChat.regularPeerId].flatMap(EnginePeer.init)
                }
                return EnginePeer(peer)
            }
        }

        public struct RenderedPeer: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Optional<EngineRenderedPeer>

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .peer(peerId: self.id, components: [])
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? PeerView else {
                    preconditionFailure()
                }
                var peers: [EnginePeer.Id: EnginePeer] = [:]
                guard let peer = view.peers[self.id] else {
                    return nil
                }
                peers[peer.id] = EnginePeer(peer)

                if let secretChat = peer as? IosappSecretChat {
                    guard let mainPeer = view.peers[secretChat.regularPeerId] else {
                        return nil
                    }
                    peers[mainPeer.id] = EnginePeer(mainPeer)
                } else if let channel = peer as? IosappChannel, channel.isMonoForum, let linkedMonoforumId = channel.linkedMonoforumId {
                    guard let mainChannel = view.peers[linkedMonoforumId] else {
                        return nil
                    }
                    peers[mainChannel.id] = EnginePeer(mainChannel)
                }

                return EngineRenderedPeer(peerId: self.id, peers: peers, associatedMedia: view.media)
            }
        }

        public struct Presence: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Optional<EnginePeer.Presence>

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .peer(peerId: self.id, components: [])
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? PeerView else {
                    preconditionFailure()
                }
                var presencePeerId = self.id
                if let secretChat = view.peers[self.id] as? IosappSecretChat {
                    presencePeerId = secretChat.regularPeerId
                }
                guard let presence = view.peerPresences[presencePeerId] else {
                    return nil
                }
                return EnginePeer.Presence(presence)
            }
        }

        public struct NotificationSettings: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = EnginePeer.NotificationSettings

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .peer(peerId: self.id, components: [])
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? PeerView else {
                    preconditionFailure()
                }
                guard let notificationSettings = view.notificationSettings as? IosappPeerNotificationSettings else {
                    return EnginePeer.NotificationSettings(IosappPeerNotificationSettings.defaultSettings)
                }
                return EnginePeer.NotificationSettings(notificationSettings)
            }
        }
        
        public struct ThreadNotificationSettings: IosappEngineDataItem, PostboxViewDataItem {
            public typealias Result = EnginePeer.NotificationSettings

            fileprivate var id: EnginePeer.Id
            fileprivate var threadId: Int64

            public init(id: EnginePeer.Id, threadId: Int64) {
                self.id = id
                self.threadId = threadId
            }

            var key: PostboxViewKey {
                return .messageHistoryThreadInfo(peerId: self.id, threadId: self.threadId)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? MessageHistoryThreadInfoView else {
                    preconditionFailure()
                }
                guard let data = view.info?.data.get(MessageHistoryThreadData.self) else {
                    return EnginePeer.NotificationSettings(IosappPeerNotificationSettings.defaultSettings)
                }
                return EnginePeer.NotificationSettings(data.notificationSettings)
            }
        }

        public struct CachedData: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Optional<EngineCachedPeerData>

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                return view.cachedPeerData
            }
        }

        public struct ParticipantCount: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Optional<Int>

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                guard let cachedPeerData = view.cachedPeerData else {
                    return nil
                }
                switch cachedPeerData {
                case let channel as CachedChannelData:
                    return channel.participantsSummary.memberCount.flatMap(Int.init)
                case let group as CachedGroupData:
                    return group.participants?.participants.count
                default:
                    return nil
                }
            }
        }
        
        public struct Wallpaper: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Optional<IosappWallpaper>

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                guard let cachedPeerData = view.cachedPeerData else {
                    return nil
                }
                switch cachedPeerData {
                case let user as CachedUserData:
                    return user.wallpaper
                case let channel as CachedChannelData:
                    return channel.wallpaper
                default:
                    return nil
                }
            }
        }
        
        public struct SendPaidMessageStars: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Optional<StarsAmount>

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .peer(peerId: self.id, components: [.cachedData])
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? PeerView else {
                    preconditionFailure()
                }
                if let cachedPeerData = view.cachedData as? CachedUserData {
                    return cachedPeerData.sendPaidMessageStars
                } else if let channel = peerViewMainPeer(view) as? IosappChannel {
                    return channel.sendPaidMessageStars
                } else {
                    return nil
                }
            }
        }
        
        public struct SendMessageToChannelPrice: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Optional<StarsAmount>

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .peer(peerId: self.id, components: [])
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? PeerView else {
                    preconditionFailure()
                }
                if let channel = peerViewMainPeer(view) as? IosappChannel {
                    return channel.sendPaidMessageStars
                } else {
                    return nil
                }
            }
        }

        public struct GroupCallDescription: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Optional<EngineGroupCallDescription>

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                guard let cachedPeerData = view.cachedPeerData else {
                    return nil
                }
                switch cachedPeerData {
                case let channel as CachedChannelData:
                    return channel.activeCall.flatMap(EngineGroupCallDescription.init)
                case let group as CachedGroupData:
                    return group.activeCall.flatMap(EngineGroupCallDescription.init)
                default:
                    return nil
                }
            }
        }

        public struct ExportedInvitation: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Optional<EngineExportedPeerInvitation>

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                guard let cachedPeerData = view.cachedPeerData else {
                    return nil
                }
                switch cachedPeerData {
                case let channel as CachedChannelData:
                    return channel.exportedInvitation
                case let group as CachedGroupData:
                    return group.exportedInvitation
                default:
                    return nil
                }
            }
        }
        
        public struct StatsDatacenterId: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Optional<Int32>

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                guard let cachedPeerData = view.cachedPeerData else {
                    return nil
                }
                switch cachedPeerData {
                case let channel as CachedChannelData:
                    return channel.statsDatacenterId
                default:
                    return nil
                }
            }
        }
        
        public struct ChatTheme: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Optional<IosappCore.ChatTheme>

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                guard let cachedPeerData = view.cachedPeerData else {
                    return nil
                }
                if let cachedData = cachedPeerData as? CachedUserData {
                    return cachedData.chatTheme
                } else if let cachedData = cachedPeerData as? CachedGroupData {
                    return cachedData.chatTheme
                } else if let cachedData = cachedPeerData as? CachedChannelData {
                    return cachedData.chatTheme
                } else {
                    return nil
                }
            }
        }
        
        public struct IsContact: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Bool

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .isContact(id: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? IsContactView else {
                    preconditionFailure()
                }
                return view.isContact
            }
        }
        
        public struct CanSetStickerPack: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Bool

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedChannelData {
                    return cachedData.flags.contains(.canSetStickerSet)
                } else {
                    return false
                }
            }
        }
        
        public struct StickerPack: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = StickerPackCollectionInfo?

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                guard let cachedData = view.cachedPeerData as? CachedChannelData else {
                    return nil
                }
                return cachedData.stickerPack
            }
        }
        
        public struct EmojiPack: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = StickerPackCollectionInfo?

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                guard let cachedData = view.cachedPeerData as? CachedChannelData else {
                    return nil
                }
                return cachedData.emojiPack
            }
        }
        
        public struct AllowedReactions: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = EnginePeerCachedInfoItem<PeerAllowedReactions>

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedChannelData {
                    switch cachedData.reactionSettings {
                    case let .known(value):
                        return .known(value.allowedReactions)
                    case .unknown:
                        return .unknown
                    }
                } else if let cachedData = view.cachedPeerData as? CachedGroupData {
                    switch cachedData.reactionSettings {
                    case let .known(value):
                        return .known(value.allowedReactions)
                    case .unknown:
                        return .unknown
                    }
                } else {
                    return .unknown
                }
            }
        }
        
        public struct ReactionSettings: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = EnginePeerCachedInfoItem<PeerReactionSettings>

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedChannelData {
                    return cachedData.reactionSettings
                } else if let cachedData = view.cachedPeerData as? CachedGroupData {
                    return cachedData.reactionSettings
                } else {
                    return .unknown
                }
            }
        }
        
        public struct CallJoinAsPeerId: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = EnginePeer.Id?

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedChannelData {
                    return cachedData.callJoinPeerId
                } else if let cachedData = view.cachedPeerData as? CachedGroupData {
                    return cachedData.callJoinPeerId
                } else {
                    return nil
                }
            }
        }
        
        public struct CommonGroupCount: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Int32?

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    return cachedData.commonGroupCount
                }  else {
                    return nil
                }
            }
        }
        
        public struct StarGiftsCount: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Int32?

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    return cachedData.starGiftsCount
                }
                if let cachedData = view.cachedPeerData as? CachedChannelData {
                    return cachedData.starGiftsCount
                }
                return nil
                
            }
        }
                
        public struct LinkedDiscussionPeerId: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = EnginePeerCachedInfoItem<EnginePeer.Id?>

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedChannelData {
                    switch cachedData.linkedDiscussionPeerId {
                    case let .known(value):
                        return .known(value)
                    case .unknown:
                        return .unknown
                    }
                } else {
                    return .unknown
                }
            }
        }
        
        public struct StatusSettings: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = EnginePeer.StatusSettings?

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    return cachedData.peerStatusSettings.flatMap(EnginePeer.StatusSettings.init)
                } else if let cachedData = view.cachedPeerData as? CachedChannelData {
                    return cachedData.peerStatusSettings.flatMap(EnginePeer.StatusSettings.init)
                } else if let cachedData = view.cachedPeerData as? CachedGroupData {
                    return cachedData.peerStatusSettings.flatMap(EnginePeer.StatusSettings.init)
                } else {
                    return nil
                }
            }
        }
        
        public struct PeerSettings: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Optional<PeerStatusSettings>

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    return cachedData.peerStatusSettings
                } else if let cachedData = view.cachedPeerData as? CachedChannelData {
                    return cachedData.peerStatusSettings
                } else if let cachedData = view.cachedPeerData as? CachedGroupData {
                    return cachedData.peerStatusSettings
                } else {
                    return nil
                }
            }
        }
        
        public struct AreVideoCallsAvailable: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Bool

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    return cachedData.videoCallsAvailable
                } else {
                    return false
                }
            }
        }
        
        public struct AreVoiceCallsAvailable: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Bool

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    return !cachedData.callsPrivate
                } else {
                    return true
                }
            }
        }
        
        public struct AreVoiceMessagesAvailable: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Bool

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    return cachedData.voiceMessagesAvailable
                } else {
                    return true
                }
            }
        }
        
        public struct AboutText: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = EnginePeerCachedInfoItem<String?>

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    return .known(cachedData.about)
                } else if let cachedData = view.cachedPeerData as? CachedGroupData {
                    return .known(cachedData.about)
                } else if let cachedData = view.cachedPeerData as? CachedChannelData {
                    return .known(cachedData.about)
                } else {
                    return .unknown
                }
            }
        }
        
        public struct Photo: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = EnginePeerCachedInfoItem<IosappMediaImage?>

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    if case let .known(value) = cachedData.photo {
                        return .known(value)
                    } else {
                        return .unknown
                    }
                } else if let cachedData = view.cachedPeerData as? CachedGroupData {
                    return .known(cachedData.photo)
                } else if let cachedData = view.cachedPeerData as? CachedChannelData {
                    return .known(cachedData.photo)
                } else {
                    return .unknown
                }
            }
        }
        
        public struct PersonalPhoto: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = EnginePeerCachedInfoItem<IosappMediaImage?>

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    if case let .known(value) = cachedData.personalPhoto {
                        return .known(value)
                    } else {
                        return .unknown
                    }
                } else {
                    return .unknown
                }
            }
        }
        
        public struct PublicPhoto: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = EnginePeerCachedInfoItem<IosappMediaImage?>

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    if case let .known(value) = cachedData.fallbackPhoto {
                        return .known(value)
                    } else {
                        return .unknown
                    }
                } else {
                    return .unknown
                }
            }
        }
        
        public struct Birthday: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = IosappBirthday?

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    return cachedData.birthday
                } else {
                    return nil
                }
            }
        }
        
        public struct CanViewStats: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Bool

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedChannelData {
                    return cachedData.flags.contains(.canViewStats)
                } else {
                    return false
                }
            }
        }
        
        public struct CanViewRevenue: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Bool

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    return cachedData.flags.contains(.canViewRevenue)
                } else if let cachedData = view.cachedPeerData as? CachedChannelData {
                    return cachedData.flags.contains(.canViewRevenue)
                } else {
                    return false
                }
            }
        }
        
        public struct CanManageEmojiStatus: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Bool

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    return cachedData.flags.contains(.botCanManageEmojiStatus)
                } else {
                    return false
                }
            }
        }
        
        public struct CanViewStarsRevenue: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Bool

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedChannelData {
                    return cachedData.flags.contains(.canViewStarsRevenue)
                } else {
                    return false
                }
            }
        }
        
        
        public struct StarGiftsAvailable: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Bool

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedChannelData {
                    return cachedData.flags.contains(.starGiftsAvailable)
                } else {
                    return false
                }
            }
        }
        
        public struct PaidMediaAllowed: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Bool

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedChannelData {
                    return cachedData.flags.contains(.paidMediaAllowed)
                } else {
                    return false
                }
            }
        }
        
        public struct BoostsToUnrestrict: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Int32?

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedChannelData {
                    return cachedData.boostsToUnrestrict
                } else {
                    return nil
                }
            }
        }
        
        public struct AppliedBoosts: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Int32?

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedChannelData {
                    return cachedData.appliedBoosts
                } else {
                    return nil
                }
            }
        }
        
        public struct MessageReadStatsAreHidden: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Bool?

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                
                if self.id.namespace == Namespaces.Peer.CloudUser {
                    if let cachedData = view.cachedPeerData as? CachedUserData, cachedData.flags.contains(.readDatesPrivate) {
                        return true
                    } else {
                        return false
                    }
                } else {
                    return false
                }
            }
        }

        
        public struct CanDeleteHistory: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Bool

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedChannelData {
                    return cachedData.flags.contains(.canDeleteHistory)
                } else {
                    return false
                }
            }
        }
        
        public struct AntiSpamEnabled: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Bool

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedChannelData {
                    return cachedData.flags.contains(.antiSpamEnabled)
                } else {
                    return false
                }
            }
        }
        
        public struct IsBlocked: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = EnginePeerCachedInfoItem<Bool>

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    return .known(cachedData.isBlocked)
                } else {
                    return .unknown
                }
            }
        }
        
        public struct IsBlockedFromStories: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = EnginePeerCachedInfoItem<Bool>

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    return .known(cachedData.flags.contains(.isBlockedFromStories))
                } else {
                    return .unknown
                }
            }
        }
        
        public struct TranslationHidden: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Bool

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    return cachedData.flags.contains(.translationHidden)
                } else if let cachedData = view.cachedPeerData as? CachedGroupData {
                    return cachedData.flags.contains(.translationHidden)
                } else if let cachedData = view.cachedPeerData as? CachedChannelData {
                    return cachedData.flags.contains(.translationHidden)
                } else {
                    return false
                }
            }
        }
        
        public struct SlowmodeTimeout: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Int32?

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedChannelData {
                    return cachedData.slowModeTimeout
                } else {
                    return nil
                }
            }
        }
        public struct SlowmodeValidUntilTimeout: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Int32?

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedChannelData {
                    return cachedData.slowModeValidUntilTimestamp
                }
                return nil
            }
        }
        
        public struct CanAvoidGroupRestrictions: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Bool

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedChannelData {
                    if let boostsToUnrestrict = cachedData.boostsToUnrestrict {
                        let appliedBoosts = cachedData.appliedBoosts ?? 0
                        return boostsToUnrestrict <= appliedBoosts
                    }
                }
                return true
            }
        }

        
        public struct IsPremiumRequiredForMessaging: IosappEngineDataItem, IosappEngineMapKeyDataItem, AnyPostboxViewDataItem {
            public typealias Result = Bool

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            func keys(data: IosappEngine.EngineData) -> [PostboxViewKey] {
                return [
                    .cachedPeerData(peerId: self.id),
                    .basicPeer(data.accountPeerId),
                    .basicPeer(self.id)
                ]
            }

            func _extract(data: IosappEngine.EngineData, views: [PostboxViewKey: PostboxView]) -> Any {
                guard self.id != data.accountPeerId else {
                    return false
                }
                guard let basicPeerView = views[.basicPeer(data.accountPeerId)] as? BasicPeerView else {
                    assertionFailure()
                    return false
                }
                guard let basicTargetPeerView = views[.basicPeer(self.id)] as? BasicPeerView else {
                    assertionFailure()
                    return false
                }
                guard let view = views[.cachedPeerData(peerId: self.id)] as? CachedPeerDataView else {
                    assertionFailure()
                    return false
                }
                
                if let peer = basicPeerView.peer, peer.isPremium {
                    return false
                }
                
                guard let targetPeer = basicTargetPeerView.peer as? IosappUser else {
                    return false
                }
                if !targetPeer.flags.contains(.requirePremium) {
                    return false
                }
                
                if self.id.namespace == Namespaces.Peer.CloudUser {
                    if let cachedData = view.cachedPeerData as? CachedUserData {
                        return cachedData.flags.contains(.premiumRequired)
                    } else {
                        return true
                    }
                } else {
                    return false
                }
            }
        }
        
        public struct LegacyGroupParticipants: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = EnginePeerCachedInfoItem<[EngineLegacyGroupParticipant]>

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedGroupData {
                    if let participants = cachedData.participants {
                        return .known(participants.participants.map(EngineLegacyGroupParticipant.init))
                    } else {
                        return .unknown
                    }
                } else {
                    return .unknown
                }
            }
        }
        
        public struct SecretChatKeyFingerprint: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = EngineSecretChatKeyFingerprint?

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .peerChatState(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? PeerChatStateView else {
                    preconditionFailure()
                }
                
                if let peerChatState = view.chatState?.getLegacy() as? SecretChatState {
                    return peerChatState.keyFingerprint
                } else {
                    return nil
                }
            }
        }
        
        public struct SecretChatLayer: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Int?

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .peerChatState(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? PeerChatStateView else {
                    preconditionFailure()
                }
                
                if let peerChatState = view.chatState?.getLegacy() as? SecretChatState {
                    switch peerChatState.embeddedState {
                    case .terminated:
                        return nil
                    case .handshake:
                        return nil
                    case .basicLayer:
                        return 7
                    case let .sequenceBasedLayer(secretChatSequenceBasedLayerState):
                        return Int(secretChatSequenceBasedLayerState.layerNegotiationState.activeLayer.rawValue)
                    }
                } else {
                    return nil
                }
            }
        }
        
        public struct ThreadData: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public struct Key: Hashable {
                public var id: EnginePeer.Id
                public var threadId: Int64
                
                public init(id: EnginePeer.Id, threadId: Int64) {
                    self.id = id
                    self.threadId = threadId
                }
            }
            
            public typealias Result = MessageHistoryThreadData?

            fileprivate var id: EnginePeer.Id
            fileprivate var threadId: Int64
            
            public var mapKey: Key {
                return Key(id: self.id, threadId: self.threadId)
            }

            public init(id: EnginePeer.Id, threadId: Int64) {
                self.id = id
                self.threadId = threadId
            }

            var key: PostboxViewKey {
                return .messageHistoryThreadInfo(peerId: self.id, threadId: self.threadId)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? MessageHistoryThreadInfoView else {
                    preconditionFailure()
                }
                
                return view.info?.data.get(MessageHistoryThreadData.self)
            }
        }
        
        public struct StoryStats: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = PeerStoryStats?

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .peerStoryStats(peerIds: Set([self.id]))
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? PeerStoryStatsView else {
                    preconditionFailure()
                }
                
                if let result = view.storyStats[self.id] {
                    return result
                } else {
                    return nil
                }
            }
        }
        
        public struct DisplaySavedChatsAsTopics: IosappEngineDataItem, PostboxViewDataItem {
            public typealias Result = Bool

            public init() {
            }

            var key: PostboxViewKey {
                return .preferences(keys: Set([PreferencesKeys.displaySavedChatsAsTopics()]))
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? PreferencesView else {
                    preconditionFailure()
                }
                
                if let value = view.values[PreferencesKeys.displaySavedChatsAsTopics()]?.get(EngineDisplaySavedChatsAsTopics.self) {
                    return value.value
                } else {
                    return false
                }
            }
        }
        
        public struct BusinessHours: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = IosappBusinessHours?

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    return cachedData.businessHours
                } else {
                    return nil
                }
            }
        }

        public struct BusinessLocation: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = IosappBusinessLocation?

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    return cachedData.businessLocation
                } else {
                    return nil
                }
            }
        }
        
        public struct BusinessGreetingMessage: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = IosappBusinessGreetingMessage?

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    return cachedData.greetingMessage
                } else {
                    return nil
                }
            }
        }
        
        public struct BusinessAwayMessage: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = IosappBusinessAwayMessage?

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    return cachedData.awayMessage
                } else {
                    return nil
                }
            }
        }
        
        public struct BusinessIntro: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = CachedIosappBusinessIntro

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    return cachedData.businessIntro
                } else {
                    return .unknown
                }
            }
        }
        
        public struct BusinessConnectedBot: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = IosappAccountConnectedBot?

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    return cachedData.connectedBot
                } else {
                    return nil
                }
            }
        }
        
        public struct ChatManagingBot: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = PeerStatusSettings.ManagingBot?

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    return cachedData.peerStatusSettings?.managingBot
                } else {
                    return nil
                }
            }
        }
        
        public struct BotBiometricsState: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = IosappBotBiometricsState?

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .preferences(keys: Set([PreferencesKeys.botBiometricsState(peerId: self.id)]))
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? PreferencesView else {
                    preconditionFailure()
                }
                if let state = view.values[PreferencesKeys.botBiometricsState(peerId: self.id)]?.get(IosappBotBiometricsState.self) {
                    return state
                } else {
                    return nil
                }
            }
        }
        
        public struct BotStorageValue: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = String?

            fileprivate var id: EnginePeer.Id
            fileprivate var storageKey: String
            
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id, key: String) {
                self.id = id
                self.storageKey = key
            }

            var key: PostboxViewKey {
                return .preferences(keys: Set([PreferencesKeys.botStorageState(peerId: self.id)]))
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? PreferencesView else {
                    preconditionFailure()
                }
                if let state = view.values[PreferencesKeys.botStorageState(peerId: self.id)]?.get(IosappBotStorageState.self) {
                    return state.data[self.storageKey]
                } else {
                    return nil
                }
            }
        }
        
        public struct BusinessChatLinks: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = IosappBusinessChatLinks?

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .preferences(keys: Set([PreferencesKeys.businessLinks()]))
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? PreferencesView else {
                    preconditionFailure()
                }
                return view.values[PreferencesKeys.businessLinks()]?.get(IosappBusinessChatLinks.self)
            }
        }
        
        public struct PersonalChannel: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = CachedIosappPersonalChannel

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    return cachedData.personalChannel
                } else {
                    return .unknown
                }
            }
        }
        
        public struct AdsRestricted: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Bool

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedChannelData {
                    return cachedData.flags.contains(.adsRestricted)
                } else {
                    return false
                }
            }
        }
        
        public struct AdsEnabled: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Bool

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    return cachedData.flags.contains(.adsEnabled)
                } else {
                    return false
                }
            }
        }
        
        public struct CopyProtectionEnabled: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Bool

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .peer(peerId: self.id, components: [.cachedData])
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? PeerView else {
                    preconditionFailure()
                }
                guard let peer = peerViewMainPeer(view) else {
                    return false
                }
                if let cachedPeerData = view.cachedData as? CachedUserData {
                    return cachedPeerData.flags.contains(.copyProtectionEnabled)
                } else if let group = peer as? IosappGroup {
                    return group.flags.contains(.copyProtectionEnabled)
                } else if let channel = peer as? IosappChannel {
                    return channel.flags.contains(.copyProtectionEnabled)
                } else {
                    return false
                }
            }
        }
        
        public struct MyCopyProtectionEnabled: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Bool

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    return cachedData.flags.contains(.myCopyProtectionEnabled)
                } else {
                    return false
                }
            }
        }
        
        public struct BotPreview: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = CachedUserData.BotPreview?

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    return cachedData.botPreview
                } else {
                    return nil
                }
            }
        }

        public struct BotMenu: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Optional<BotMenuButton>
            
            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }
            
            public init(id: EnginePeer.Id) {
                self.id = id
            }
            
            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }
            
            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    return cachedData.botInfo?.menuButton
                } else {
                    return nil
                }
            }
        }
        
        public struct BotAppSettings: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Optional<IosappCore.BotAppSettings>
            
            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }
            
            public init(id: EnginePeer.Id) {
                self.id = id
            }
            
            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }
            
            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    return cachedData.botInfo?.appSettings
                } else {
                    return nil
                }
            }
        }
        
        public struct BotCommands: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Optional<[BotCommand]>
            
            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }
            
            public init(id: EnginePeer.Id) {
                self.id = id
            }
            
            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }
            
            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    return cachedData.botInfo?.commands
                } else {
                    return nil
                }
            }
        }
        
        public struct ProfileMainTab: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Optional<IosappProfileTab>
            
            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }
            
            public init(id: EnginePeer.Id) {
                self.id = id
            }
            
            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }
            
            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    return cachedData.mainProfileTab
                } else if let cachedData = view.cachedPeerData as? CachedChannelData {
                    return cachedData.mainProfileTab
                } else {
                    return nil
                }
            }
        }
                
        public struct BotPrivacyPolicyUrl: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Optional<String>
            
            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }
            
            public init(id: EnginePeer.Id) {
                self.id = id
            }
            
            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }
            
            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    return cachedData.botInfo?.privacyPolicyUrl
                } else {
                    return nil
                }
            }
        }
        
        public struct BotGroupAdminRights: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Optional<IosappChatAdminRights>
            
            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }
            
            public init(id: EnginePeer.Id) {
                self.id = id
            }
            
            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }
            
            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    return cachedData.botGroupAdminRights
                } else {
                    return nil
                }
            }
        }
        
        public struct BotChannelAdminRights: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Optional<IosappChatAdminRights>
            
            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }
            
            public init(id: EnginePeer.Id) {
                self.id = id
            }
            
            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }
            
            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    return cachedData.botChannelAdminRights
                } else {
                    return nil
                }
            }
        }
        
        public struct StarsReactionDefaultPrivacy: IosappEngineDataItem, PostboxViewDataItem {
            public typealias Result = IosappPaidReactionPrivacy
            
            public init() {
            }
            
            var key: PostboxViewKey {
                return .cachedItem(ItemCacheEntryId(collectionId: Namespaces.CachedItemCollection.starsReactionDefaultToPrivate, key: StarsReactionDefaultToPrivateData.key()))
            }
            
            func extract(view: PostboxView) -> Result {
                if let value = (view as? CachedItemView)?.value?.get(StarsReactionDefaultToPrivateData.self) {
                    return value.privacy
                } else {
                    return .default
                }
            }
        }
        
        public struct StarRefProgram: IosappEngineDataItem, PostboxViewDataItem {
            public typealias Result = IosappStarRefProgram?
            
            public let id: EnginePeer.Id
            
            public init(id: EnginePeer.Id) {
                self.id = id
            }
            
            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }
            
            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    return cachedData.starRefProgram
                } else {
                    return nil
                }
            }
        }
        
        public struct Verification: IosappEngineDataItem, PostboxViewDataItem {
            public typealias Result = PeerVerification?
            
            public let id: EnginePeer.Id
            
            public init(id: EnginePeer.Id) {
                self.id = id
            }
            
            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }
            
            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    return cachedData.verification
                } else if let cachedData = view.cachedPeerData as? CachedChannelData {
                    return cachedData.verification
                } else {
                    return nil
                }
            }
        }
        
        public struct DisallowedGifts: IosappEngineDataItem, PostboxViewDataItem {
            public typealias Result = IosappDisallowedGifts?
            
            public let id: EnginePeer.Id
            
            public init(id: EnginePeer.Id) {
                self.id = id
            }
            
            var key: PostboxViewKey {
                return .cachedPeerData(peerId: self.id)
            }
            
            func extract(view: PostboxView) -> Result {
                guard let view = view as? CachedPeerDataView else {
                    preconditionFailure()
                }
                if let cachedData = view.cachedPeerData as? CachedUserData {
                    return cachedData.disallowedGifts
                } else {
                    return nil
                }
            }
        }
        
        public struct AutoTranslateEnabled: IosappEngineDataItem, IosappEngineMapKeyDataItem, PostboxViewDataItem {
            public typealias Result = Bool

            fileprivate var id: EnginePeer.Id
            public var mapKey: EnginePeer.Id {
                return self.id
            }

            public init(id: EnginePeer.Id) {
                self.id = id
            }

            var key: PostboxViewKey {
                return .peer(peerId: self.id, components: [])
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? PeerView else {
                    preconditionFailure()
                }
                if let channel = peerViewMainPeer(view) as? IosappChannel {
                    return channel.flags.contains(.autoTranslateEnabled)
                }
                return false
            }
        }
    }
}
