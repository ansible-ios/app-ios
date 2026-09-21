import Postbox
import FlatBuffers
import FlatSerialization

public enum IosappChannelParticipationStatus: Int32 {
    case member = 0
    case left = 1
    case kicked = 2
    
    public init(rawValue: Int32) {
        switch rawValue {
        case 0:
            self = .member
        case 1:
            self = .left
        case 2:
            self = .kicked
        default:
            self = .left
        }
    }
}

public struct IosappChannelBroadcastFlags: OptionSet {
    public var rawValue: Int32
    
    public init() {
        self.rawValue = 0
    }
    
    public init(rawValue: Int32) {
        self.rawValue = rawValue
    }
    
    public static let messagesShouldHaveSignatures = IosappChannelBroadcastFlags(rawValue: 1 << 0)
    public static let hasDiscussionGroup = IosappChannelBroadcastFlags(rawValue: 1 << 1)
    public static let messagesShouldHaveProfiles = IosappChannelBroadcastFlags(rawValue: 1 << 2)
    public static let hasMonoforum = IosappChannelBroadcastFlags(rawValue: 1 << 3)
}

public struct IosappChannelBroadcastInfo: Equatable {
    public let flags: IosappChannelBroadcastFlags
    
    public init(flags: IosappChannelBroadcastFlags) {
        self.flags = flags
    }
    
    public static func ==(lhs: IosappChannelBroadcastInfo, rhs: IosappChannelBroadcastInfo) -> Bool {
        return lhs.flags == rhs.flags
    }
}

public struct IosappChannelGroupFlags: OptionSet {
    public var rawValue: Int32
    
    public init() {
        self.rawValue = 0
    }
    
    public init(rawValue: Int32) {
        self.rawValue = rawValue
    }
    public static let slowModeEnabled = IosappChannelGroupFlags(rawValue: 1 << 0)
}

public struct IosappChannelGroupInfo: Equatable {
    public let flags: IosappChannelGroupFlags
    
    public init(flags: IosappChannelGroupFlags) {
        self.flags = flags
    }

    public static func ==(lhs: IosappChannelGroupInfo, rhs: IosappChannelGroupInfo) -> Bool {
        return lhs.flags == rhs.flags
    }
}

public enum IosappChannelInfo: Equatable {
    case broadcast(IosappChannelBroadcastInfo)
    case group(IosappChannelGroupInfo)
    
    public static func ==(lhs: IosappChannelInfo, rhs: IosappChannelInfo) -> Bool {
        switch lhs {
            case let .broadcast(lhsInfo):
                switch rhs {
                    case .broadcast(lhsInfo):
                        return true
                    default:
                        return false
                }
            case let .group(lhsInfo):
                switch rhs {
                    case .group(lhsInfo):
                        return true
                    default:
                        return false
                }
        }
    }
    
    fileprivate func encode(encoder: PostboxEncoder) {
        switch self {
            case let .broadcast(info):
                encoder.encodeInt32(0, forKey: "i.t")
                encoder.encodeInt32(info.flags.rawValue, forKey: "i.f")
            case let .group(info):
                encoder.encodeInt32(1, forKey: "i.t")
                encoder.encodeInt32(info.flags.rawValue, forKey: "i.f")
        }
    }
    
    fileprivate static func decode(decoder: PostboxDecoder) -> IosappChannelInfo {
        let type: Int32 = decoder.decodeInt32ForKey("i.t", orElse: 0)
        if type == 0 {
            return .broadcast(IosappChannelBroadcastInfo(flags: IosappChannelBroadcastFlags(rawValue: decoder.decodeInt32ForKey("i.f", orElse: 0))))
        } else {
            return .group(IosappChannelGroupInfo(flags: IosappChannelGroupFlags(rawValue: decoder.decodeInt32ForKey("i.f", orElse: 0))))
        }
    }
    
    public init(flatBuffersObject: IosappCore_IosappChannelInfo) throws {
        switch flatBuffersObject.valueType {
        case .iosappchannelinfoBroadcast:
            guard let value = flatBuffersObject.value(type: IosappCore_IosappChannelInfo_Broadcast.self) else {
                throw FlatBuffersError.missingRequiredField()
            }
            self = .broadcast(IosappChannelBroadcastInfo(flags: IosappChannelBroadcastFlags(rawValue: value.flags)))
        case .iosappchannelinfoGroup:
            guard let value = flatBuffersObject.value(type: IosappCore_IosappChannelInfo_Group.self) else {
                throw FlatBuffersError.missingRequiredField()
            }
            self = .group(IosappChannelGroupInfo(flags: IosappChannelGroupFlags(rawValue: value.flags)))
        case .none_:
            throw FlatBuffersError.missingRequiredField()
        }
    }
    
    public func encodeToFlatBuffers(builder: inout FlatBufferBuilder) -> Offset {
        let valueType: IosappCore_IosappChannelInfo_Value
        let valueOffset: Offset
        
        switch self {
        case let .broadcast(info):
            valueType = .iosappchannelinfoBroadcast
            let start = IosappCore_IosappChannelInfo_Broadcast.startIosappChannelInfo_Broadcast(&builder)
            IosappCore_IosappChannelInfo_Broadcast.add(flags: info.flags.rawValue, &builder)
            valueOffset = IosappCore_IosappChannelInfo_Broadcast.endIosappChannelInfo_Broadcast(&builder, start: start)
        case let .group(info):
            valueType = .iosappchannelinfoGroup
            let start = IosappCore_IosappChannelInfo_Group.startIosappChannelInfo_Group(&builder)
            IosappCore_IosappChannelInfo_Group.add(flags: info.flags.rawValue, &builder)
            valueOffset = IosappCore_IosappChannelInfo_Group.endIosappChannelInfo_Group(&builder, start: start)
        }
        
        let start = IosappCore_IosappChannelInfo.startIosappChannelInfo(&builder)
        IosappCore_IosappChannelInfo.add(valueType: valueType, &builder)
        IosappCore_IosappChannelInfo.add(value: valueOffset, &builder)
        return IosappCore_IosappChannelInfo.endIosappChannelInfo(&builder, start: start)
    }
}

public struct IosappChannelFlags: OptionSet {
    public var rawValue: Int32
    
    public init() {
        self.rawValue = 0
    }
    
    public init(rawValue: Int32) {
        self.rawValue = rawValue
    }
    
    public static let isVerified = IosappChannelFlags(rawValue: 1 << 0)
    public static let isCreator = IosappChannelFlags(rawValue: 1 << 1)
    public static let isScam = IosappChannelFlags(rawValue: 1 << 2)
    public static let hasGeo = IosappChannelFlags(rawValue: 1 << 3)
    public static let hasVoiceChat = IosappChannelFlags(rawValue: 1 << 4)
    public static let hasActiveVoiceChat = IosappChannelFlags(rawValue: 1 << 5)
    public static let isFake = IosappChannelFlags(rawValue: 1 << 6)
    public static let isGigagroup = IosappChannelFlags(rawValue: 1 << 7)
    public static let copyProtectionEnabled = IosappChannelFlags(rawValue: 1 << 8)
    public static let joinToSend = IosappChannelFlags(rawValue: 1 << 9)
    public static let requestToJoin = IosappChannelFlags(rawValue: 1 << 10)
    public static let isForum = IosappChannelFlags(rawValue: 1 << 11)
    public static let autoTranslateEnabled = IosappChannelFlags(rawValue: 1 << 12)
    public static let isMonoforum = IosappChannelFlags(rawValue: 1 << 13)
    public static let displayForumAsTabs = IosappChannelFlags(rawValue: 1 << 14)
}

public final class IosappChannel: Peer, Equatable {
    public let id: PeerId
    public let accessHash: IosappPeerAccessHash?
    public let title: String
    public let username: String?
    public let photo: [IosappMediaImageRepresentation]
    public let creationDate: Int32
    public let version: Int32
    public let participationStatus: IosappChannelParticipationStatus
    public let info: IosappChannelInfo
    public let flags: IosappChannelFlags
    public let restrictionInfo: PeerAccessRestrictionInfo?
    public let adminRights: IosappChatAdminRights?
    public let bannedRights: IosappChatBannedRights?
    public let defaultBannedRights: IosappChatBannedRights?
    public let usernames: [IosappPeerUsername]
    public let storiesHidden: Bool?
    public let nameColor: PeerNameColor?
    public let backgroundEmojiId: Int64?
    public let profileColor: PeerNameColor?
    public let profileBackgroundEmojiId: Int64?
    public let emojiStatus: PeerEmojiStatus?
    public let approximateBoostLevel: Int32?
    public let subscriptionUntilDate: Int32?
    public let verificationIconFileId: Int64?
    public let sendPaidMessageStars: StarsAmount?
    public let linkedMonoforumId: PeerId?
    public let linkedCommunityId: PeerId?
    
    public var associatedPeerId: PeerId? {
        if self.flags.contains(.isMonoforum) {
            return self.linkedMonoforumId
        } else {
            return nil
        }
    }
    
    public var additionalAssociatedPeerId: PeerId? {
        return self.linkedMonoforumId
    }
    
    public var containerPeerId: PeerId? {
        return self.linkedCommunityId
    }
    
    public var notificationSettingsPeerId: PeerId? {
        return nil
    }
    
    public var indexName: PeerIndexNameRepresentation {
        var addressNames = self.usernames.map { $0.username }
        if addressNames.isEmpty, let username = self.username, !username.isEmpty {
            addressNames = [username]
        }
        return .title(title: self.title, addressNames: addressNames)
    }
    
    public var associatedMediaIds: [MediaId]? {
        var mediaIds: [MediaId] = []
        if let emojiStatus = self.emojiStatus {
            switch emojiStatus.content {
            case let .emoji(fileId):
                mediaIds.append(MediaId(namespace: Namespaces.Media.CloudFile, id: fileId))
            case let .starGift(_, fileId, _, _, patternFileId, _, _, _, _):
                mediaIds.append(MediaId(namespace: Namespaces.Media.CloudFile, id: fileId))
                mediaIds.append(MediaId(namespace: Namespaces.Media.CloudFile, id: patternFileId))
            }
        }
        if let backgroundEmojiId = self.backgroundEmojiId {
            mediaIds.append(MediaId(namespace: Namespaces.Media.CloudFile, id: backgroundEmojiId))
        }
        if let profileBackgroundEmojiId = self.profileBackgroundEmojiId {
            mediaIds.append(MediaId(namespace: Namespaces.Media.CloudFile, id: profileBackgroundEmojiId))
        }
        guard !mediaIds.isEmpty else {
            return nil
        }
        return mediaIds
    }
    
    public var timeoutAttribute: UInt32? {
        if let emojiStatus = self.emojiStatus {
            if let expirationDate = emojiStatus.expirationDate {
                return UInt32(max(0, expirationDate))
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    public init(
        id: PeerId,
        accessHash: IosappPeerAccessHash?,
        title: String,
        username: String?,
        photo: [IosappMediaImageRepresentation],
        creationDate: Int32,
        version: Int32,
        participationStatus: IosappChannelParticipationStatus,
        info: IosappChannelInfo,
        flags: IosappChannelFlags,
        restrictionInfo: PeerAccessRestrictionInfo?,
        adminRights: IosappChatAdminRights?,
        bannedRights: IosappChatBannedRights?,
        defaultBannedRights: IosappChatBannedRights?,
        usernames: [IosappPeerUsername],
        storiesHidden: Bool?,
        nameColor: PeerNameColor?,
        backgroundEmojiId: Int64?,
        profileColor: PeerNameColor?,
        profileBackgroundEmojiId: Int64?,
        emojiStatus: PeerEmojiStatus?,
        approximateBoostLevel: Int32?,
        subscriptionUntilDate: Int32?,
        verificationIconFileId: Int64?,
        sendPaidMessageStars: StarsAmount?,
        linkedMonoforumId: PeerId?,
        linkedCommunityId: PeerId? = nil
    ) {
        self.id = id
        self.accessHash = accessHash
        self.title = title
        self.username = username
        self.photo = photo
        self.creationDate = creationDate
        self.version = version
        self.participationStatus = participationStatus
        self.info = info
        self.flags = flags
        self.restrictionInfo = restrictionInfo
        self.adminRights = adminRights
        self.bannedRights = bannedRights
        self.defaultBannedRights = defaultBannedRights
        self.usernames = usernames
        self.storiesHidden = storiesHidden
        self.nameColor = nameColor
        self.backgroundEmojiId = backgroundEmojiId
        self.profileColor = profileColor
        self.profileBackgroundEmojiId = profileBackgroundEmojiId
        self.emojiStatus = emojiStatus
        self.approximateBoostLevel = approximateBoostLevel
        self.subscriptionUntilDate = subscriptionUntilDate
        self.verificationIconFileId = verificationIconFileId
        self.sendPaidMessageStars = sendPaidMessageStars
        self.linkedMonoforumId = linkedMonoforumId
        self.linkedCommunityId = linkedCommunityId
    }
    
    public init(decoder: PostboxDecoder) {
        self.id = PeerId(decoder.decodeInt64ForKey("i", orElse: 0))
        let accessHash = decoder.decodeOptionalInt64ForKey("ah")
        let accessHashType: Int32 = decoder.decodeInt32ForKey("aht", orElse: 0)
        if let accessHash = accessHash {
            if accessHashType == 0 {
                self.accessHash = .personal(accessHash)
            } else {
                self.accessHash = .genericPublic(accessHash)
            }
        } else {
            self.accessHash = nil
        }
        self.title = decoder.decodeStringForKey("t", orElse: "")
        self.username = decoder.decodeOptionalStringForKey("un")
        self.photo = decoder.decodeObjectArrayForKey("ph")
        self.creationDate = decoder.decodeInt32ForKey("d", orElse: 0)
        self.version = decoder.decodeInt32ForKey("v", orElse: 0)
        self.participationStatus = IosappChannelParticipationStatus(rawValue: decoder.decodeInt32ForKey("ps", orElse: 0))
        self.info = IosappChannelInfo.decode(decoder: decoder)
        self.flags = IosappChannelFlags(rawValue: decoder.decodeInt32ForKey("fl", orElse: 0))
        self.restrictionInfo = decoder.decodeObjectForKey("ri") as? PeerAccessRestrictionInfo
        self.adminRights = decoder.decodeObjectForKey("ar", decoder: { IosappChatAdminRights(decoder: $0) }) as? IosappChatAdminRights
        self.bannedRights = decoder.decodeObjectForKey("br", decoder: { IosappChatBannedRights(decoder: $0) }) as? IosappChatBannedRights
        self.defaultBannedRights = decoder.decodeObjectForKey("dbr", decoder: { IosappChatBannedRights(decoder: $0) }) as? IosappChatBannedRights
        self.usernames = decoder.decodeObjectArrayForKey("uns")
        self.storiesHidden = decoder.decodeOptionalBoolForKey("sth")
        self.nameColor = decoder.decodeOptionalInt32ForKey("nclr").flatMap { PeerNameColor(rawValue: $0) }
        self.backgroundEmojiId = decoder.decodeOptionalInt64ForKey("bgem")
        self.profileColor = decoder.decodeOptionalInt32ForKey("pclr").flatMap { PeerNameColor(rawValue: $0) }
        self.profileBackgroundEmojiId = decoder.decodeOptionalInt64ForKey("pgem")
        self.emojiStatus = decoder.decode(PeerEmojiStatus.self, forKey: "emjs")
        self.approximateBoostLevel = decoder.decodeOptionalInt32ForKey("abl")
        self.subscriptionUntilDate = decoder.decodeOptionalInt32ForKey("sud")
        self.verificationIconFileId = decoder.decodeOptionalInt64ForKey("vfid")
        self.sendPaidMessageStars = decoder.decodeCodable(StarsAmount.self, forKey: "sendPaidMessageStars")
        self.linkedMonoforumId = decoder.decodeOptionalInt64ForKey("lmid").flatMap(PeerId.init)
        self.linkedCommunityId = decoder.decodeOptionalInt64ForKey("lcid").flatMap(PeerId.init)
    }
    
    public func encode(_ encoder: PostboxEncoder) {
        encoder.encodeInt64(self.id.toInt64(), forKey: "i")
        if let accessHash = self.accessHash {
            switch accessHash {
            case let .personal(value):
                encoder.encodeInt64(value, forKey: "ah")
                encoder.encodeInt32(0, forKey: "aht")
            case let .genericPublic(value):
                encoder.encodeInt64(value, forKey: "ah")
                encoder.encodeInt32(1, forKey: "aht")
            }
        } else {
            encoder.encodeNil(forKey: "ah")
        }
        encoder.encodeString(self.title, forKey: "t")
        if let username = self.username {
            encoder.encodeString(username, forKey: "un")
        } else {
            encoder.encodeNil(forKey: "un")
        }
        encoder.encodeObjectArray(self.photo, forKey: "ph")
        encoder.encodeInt32(self.creationDate, forKey: "d")
        encoder.encodeInt32(self.version, forKey: "v")
        encoder.encodeInt32(self.participationStatus.rawValue, forKey: "ps")
        self.info.encode(encoder: encoder)
        encoder.encodeInt32(self.flags.rawValue, forKey: "fl")
        if let restrictionInfo = self.restrictionInfo {
            encoder.encodeObject(restrictionInfo, forKey: "ri")
        } else {
            encoder.encodeNil(forKey: "ri")
        }
        if let adminRights = self.adminRights {
            encoder.encodeObject(adminRights, forKey: "ar")
        } else {
            encoder.encodeNil(forKey: "ar")
        }
        if let bannedRights = self.bannedRights {
            encoder.encodeObject(bannedRights, forKey: "br")
        } else {
            encoder.encodeNil(forKey: "br")
        }
        if let defaultBannedRights = self.defaultBannedRights {
            encoder.encodeObject(defaultBannedRights, forKey: "dbr")
        } else {
            encoder.encodeNil(forKey: "dbr")
        }
        encoder.encodeObjectArray(self.usernames, forKey: "uns")
        
        if let storiesHidden = self.storiesHidden {
            encoder.encodeBool(storiesHidden, forKey: "sth")
        } else {
            encoder.encodeNil(forKey: "sth")
        }
        
        if let nameColor = self.nameColor {
            encoder.encodeInt32(nameColor.rawValue, forKey: "nclr")
        } else {
            encoder.encodeNil(forKey: "nclr")
        }
        
        if let backgroundEmojiId = self.backgroundEmojiId {
            encoder.encodeInt64(backgroundEmojiId, forKey: "bgem")
        } else {
            encoder.encodeNil(forKey: "bgem")
        }
        
        if let profileColor = self.profileColor {
            encoder.encodeInt32(profileColor.rawValue, forKey: "pclr")
        } else {
            encoder.encodeNil(forKey: "pclr")
        }
        
        if let profileBackgroundEmojiId = self.profileBackgroundEmojiId {
            encoder.encodeInt64(profileBackgroundEmojiId, forKey: "pgem")
        } else {
            encoder.encodeNil(forKey: "pgem")
        }
        
        if let emojiStatus = self.emojiStatus {
            encoder.encode(emojiStatus, forKey: "emjs")
        } else {
            encoder.encodeNil(forKey: "emjs")
        }
        
        if let approximateBoostLevel = self.approximateBoostLevel {
            encoder.encodeInt32(approximateBoostLevel, forKey: "abl")
        } else {
            encoder.encodeNil(forKey: "abl")
        }
        
        if let subscriptionUntilDate = self.subscriptionUntilDate {
            encoder.encodeInt32(subscriptionUntilDate, forKey: "sud")
        } else {
            encoder.encodeNil(forKey: "sud")
        }
        
        if let verificationIconFileId = self.verificationIconFileId {
            encoder.encodeInt64(verificationIconFileId, forKey: "vfid")
        } else {
            encoder.encodeNil(forKey: "vfid")
        }
        
        if let sendPaidMessageStars = self.sendPaidMessageStars {
            encoder.encodeCodable(sendPaidMessageStars, forKey: "sendPaidMessageStars")
        } else {
            encoder.encodeNil(forKey: "sendPaidMessageStars")
        }
        
        if let linkedMonoforumId = self.linkedMonoforumId {
            encoder.encodeInt64(linkedMonoforumId.toInt64(), forKey: "lmid")
        } else {
            encoder.encodeNil(forKey: "lmid")
        }

        if let linkedCommunityId = self.linkedCommunityId {
            encoder.encodeInt64(linkedCommunityId.toInt64(), forKey: "lcid")
        } else {
            encoder.encodeNil(forKey: "lcid")
        }
    }
    
    public func isEqual(_ other: Peer) -> Bool {
        guard let other = other as? IosappChannel else {
            return false
        }
        
        return self == other
    }

    public static func ==(lhs: IosappChannel, rhs: IosappChannel) -> Bool {
        if lhs.id != rhs.id || lhs.accessHash != rhs.accessHash || lhs.title != rhs.title || lhs.username != rhs.username || lhs.photo != rhs.photo {
            return false
        }

        if lhs.creationDate != rhs.creationDate || lhs.version != rhs.version || lhs.participationStatus != rhs.participationStatus {
            return false
        }

        if lhs.info != rhs.info || lhs.flags != rhs.flags || lhs.restrictionInfo != rhs.restrictionInfo {
            return false
        }

        if lhs.adminRights != rhs.adminRights {
            return false
        }

        if lhs.bannedRights != rhs.bannedRights {
            return false
        }

        if lhs.defaultBannedRights != rhs.defaultBannedRights {
            return false
        }
        if lhs.usernames != rhs.usernames {
            return false
        }
        if lhs.storiesHidden != rhs.storiesHidden {
            return false
        }
        if lhs.nameColor != rhs.nameColor {
            return false
        }
        if lhs.backgroundEmojiId != rhs.backgroundEmojiId {
            return false
        }
        if lhs.profileColor != rhs.profileColor {
            return false
        }
        if lhs.profileBackgroundEmojiId != rhs.profileBackgroundEmojiId {
            return false
        }
        if lhs.emojiStatus != rhs.emojiStatus {
            return false
        }
        if lhs.approximateBoostLevel != rhs.approximateBoostLevel {
            return false
        }
        if lhs.subscriptionUntilDate != rhs.subscriptionUntilDate {
            return false
        }
        if lhs.verificationIconFileId != rhs.verificationIconFileId {
            return false
        }
        if lhs.sendPaidMessageStars != rhs.sendPaidMessageStars {
            return false
        }
        if lhs.linkedMonoforumId != rhs.linkedMonoforumId {
            return false
        }
        if lhs.linkedCommunityId != rhs.linkedCommunityId {
            return false
        }
        return true
    }
    
    public func withUpdatedAddressName(_ addressName: String?) -> IosappChannel {
        return IosappChannel(id: self.id, accessHash: self.accessHash, title: self.title, username: addressName, photo: self.photo, creationDate: self.creationDate, version: self.version, participationStatus: self.participationStatus, info: self.info, flags: self.flags, restrictionInfo: self.restrictionInfo, adminRights: self.adminRights, bannedRights: self.bannedRights, defaultBannedRights: self.defaultBannedRights, usernames: self.usernames, storiesHidden: self.storiesHidden, nameColor: self.nameColor, backgroundEmojiId: self.backgroundEmojiId, profileColor: self.profileColor, profileBackgroundEmojiId: self.profileBackgroundEmojiId, emojiStatus: self.emojiStatus, approximateBoostLevel: self.approximateBoostLevel, subscriptionUntilDate: self.subscriptionUntilDate, verificationIconFileId: self.verificationIconFileId, sendPaidMessageStars: self.sendPaidMessageStars, linkedMonoforumId: self.linkedMonoforumId, linkedCommunityId: self.linkedCommunityId)
    }
    
    public func withUpdatedAddressNames(_ addressNames: [IosappPeerUsername]) -> IosappChannel {
        return IosappChannel(id: self.id, accessHash: self.accessHash, title: self.title, username: self.username, photo: self.photo, creationDate: self.creationDate, version: self.version, participationStatus: self.participationStatus, info: self.info, flags: self.flags, restrictionInfo: self.restrictionInfo, adminRights: self.adminRights, bannedRights: self.bannedRights, defaultBannedRights: self.defaultBannedRights, usernames: addressNames, storiesHidden: self.storiesHidden, nameColor: self.nameColor, backgroundEmojiId: self.backgroundEmojiId, profileColor: self.profileColor, profileBackgroundEmojiId: self.profileBackgroundEmojiId, emojiStatus: self.emojiStatus, approximateBoostLevel: self.approximateBoostLevel, subscriptionUntilDate: self.subscriptionUntilDate, verificationIconFileId: self.verificationIconFileId, sendPaidMessageStars: self.sendPaidMessageStars, linkedMonoforumId: self.linkedMonoforumId, linkedCommunityId: self.linkedCommunityId)
    }
    
    public func withUpdatedDefaultBannedRights(_ defaultBannedRights: IosappChatBannedRights?) -> IosappChannel {
        return IosappChannel(id: self.id, accessHash: self.accessHash, title: self.title, username: self.username, photo: self.photo, creationDate: self.creationDate, version: self.version, participationStatus: self.participationStatus, info: self.info, flags: self.flags, restrictionInfo: self.restrictionInfo, adminRights: self.adminRights, bannedRights: self.bannedRights, defaultBannedRights: defaultBannedRights, usernames: self.usernames, storiesHidden: self.storiesHidden, nameColor: self.nameColor, backgroundEmojiId: self.backgroundEmojiId, profileColor: self.profileColor, profileBackgroundEmojiId: self.profileBackgroundEmojiId, emojiStatus: self.emojiStatus, approximateBoostLevel: self.approximateBoostLevel, subscriptionUntilDate: self.subscriptionUntilDate, verificationIconFileId: self.verificationIconFileId, sendPaidMessageStars: self.sendPaidMessageStars, linkedMonoforumId: self.linkedMonoforumId, linkedCommunityId: self.linkedCommunityId)
    }
    
    public func withUpdatedFlags(_ flags: IosappChannelFlags) -> IosappChannel {
        return IosappChannel(id: self.id, accessHash: self.accessHash, title: self.title, username: self.username, photo: self.photo, creationDate: self.creationDate, version: self.version, participationStatus: self.participationStatus, info: self.info, flags: flags, restrictionInfo: self.restrictionInfo, adminRights: self.adminRights, bannedRights: self.bannedRights, defaultBannedRights: self.defaultBannedRights, usernames: self.usernames, storiesHidden: self.storiesHidden, nameColor: self.nameColor, backgroundEmojiId: self.backgroundEmojiId, profileColor: self.profileColor, profileBackgroundEmojiId: self.profileBackgroundEmojiId, emojiStatus: self.emojiStatus, approximateBoostLevel: self.approximateBoostLevel, subscriptionUntilDate: self.subscriptionUntilDate, verificationIconFileId: self.verificationIconFileId, sendPaidMessageStars: self.sendPaidMessageStars, linkedMonoforumId: self.linkedMonoforumId, linkedCommunityId: self.linkedCommunityId)
    }
    
    public func withUpdatedInfo(_ info: IosappChannelInfo) -> IosappChannel {
        return IosappChannel(id: self.id, accessHash: self.accessHash, title: self.title, username: self.username, photo: self.photo, creationDate: self.creationDate, version: self.version, participationStatus: self.participationStatus, info: info, flags: self.flags, restrictionInfo: self.restrictionInfo, adminRights: self.adminRights, bannedRights: self.bannedRights, defaultBannedRights: self.defaultBannedRights, usernames: self.usernames, storiesHidden: self.storiesHidden, nameColor: self.nameColor, backgroundEmojiId: self.backgroundEmojiId, profileColor: self.profileColor, profileBackgroundEmojiId: self.profileBackgroundEmojiId, emojiStatus: self.emojiStatus, approximateBoostLevel: self.approximateBoostLevel, subscriptionUntilDate: self.subscriptionUntilDate, verificationIconFileId: self.verificationIconFileId, sendPaidMessageStars: self.sendPaidMessageStars, linkedMonoforumId: self.linkedMonoforumId, linkedCommunityId: self.linkedCommunityId)
    }

    public func withUpdatedLinkedCommunityId(_ linkedCommunityId: PeerId?) -> IosappChannel {
        return IosappChannel(id: self.id, accessHash: self.accessHash, title: self.title, username: self.username, photo: self.photo, creationDate: self.creationDate, version: self.version, participationStatus: self.participationStatus, info: self.info, flags: self.flags, restrictionInfo: self.restrictionInfo, adminRights: self.adminRights, bannedRights: self.bannedRights, defaultBannedRights: self.defaultBannedRights, usernames: self.usernames, storiesHidden: self.storiesHidden, nameColor: self.nameColor, backgroundEmojiId: self.backgroundEmojiId, profileColor: self.profileColor, profileBackgroundEmojiId: self.profileBackgroundEmojiId, emojiStatus: self.emojiStatus, approximateBoostLevel: self.approximateBoostLevel, subscriptionUntilDate: self.subscriptionUntilDate, verificationIconFileId: self.verificationIconFileId, sendPaidMessageStars: self.sendPaidMessageStars, linkedMonoforumId: self.linkedMonoforumId, linkedCommunityId: linkedCommunityId)
    }

    public func withUpdatedSendPaidMessageStars(_ sendPaidMessageStars: StarsAmount?) -> IosappChannel {
        return IosappChannel(id: self.id, accessHash: self.accessHash, title: self.title, username: self.username, photo: self.photo, creationDate: self.creationDate, version: self.version, participationStatus: self.participationStatus, info: self.info, flags: self.flags, restrictionInfo: self.restrictionInfo, adminRights: self.adminRights, bannedRights: self.bannedRights, defaultBannedRights: self.defaultBannedRights, usernames: self.usernames, storiesHidden: self.storiesHidden, nameColor: self.nameColor, backgroundEmojiId: self.backgroundEmojiId, profileColor: self.profileColor, profileBackgroundEmojiId: self.profileBackgroundEmojiId, emojiStatus: self.emojiStatus, approximateBoostLevel: self.approximateBoostLevel, subscriptionUntilDate: self.subscriptionUntilDate, verificationIconFileId: self.verificationIconFileId, sendPaidMessageStars: sendPaidMessageStars, linkedMonoforumId: self.linkedMonoforumId, linkedCommunityId: self.linkedCommunityId)
    }
    
    public func withUpdatedStoriesHidden(_ storiesHidden: Bool?) -> IosappChannel {
        return IosappChannel(id: self.id, accessHash: self.accessHash, title: self.title, username: self.username, photo: self.photo, creationDate: self.creationDate, version: self.version, participationStatus: self.participationStatus, info: self.info, flags: self.flags, restrictionInfo: self.restrictionInfo, adminRights: self.adminRights, bannedRights: self.bannedRights, defaultBannedRights: self.defaultBannedRights, usernames: self.usernames, storiesHidden: storiesHidden, nameColor: self.nameColor, backgroundEmojiId: self.backgroundEmojiId, profileColor: self.profileColor, profileBackgroundEmojiId: self.profileBackgroundEmojiId, emojiStatus: self.emojiStatus, approximateBoostLevel: self.approximateBoostLevel, subscriptionUntilDate: self.subscriptionUntilDate, verificationIconFileId: self.verificationIconFileId, sendPaidMessageStars: self.sendPaidMessageStars, linkedMonoforumId: self.linkedMonoforumId, linkedCommunityId: self.linkedCommunityId)
    }
    
    public func withUpdatedNameColor(_ nameColor: PeerNameColor?) -> IosappChannel {
        return IosappChannel(id: self.id, accessHash: self.accessHash, title: self.title, username: self.username, photo: self.photo, creationDate: self.creationDate, version: self.version, participationStatus: self.participationStatus, info: self.info, flags: self.flags, restrictionInfo: self.restrictionInfo, adminRights: self.adminRights, bannedRights: self.bannedRights, defaultBannedRights: self.defaultBannedRights, usernames: self.usernames, storiesHidden: self.storiesHidden, nameColor: nameColor, backgroundEmojiId: self.backgroundEmojiId, profileColor: self.profileColor, profileBackgroundEmojiId: self.profileBackgroundEmojiId, emojiStatus: self.emojiStatus, approximateBoostLevel: self.approximateBoostLevel, subscriptionUntilDate: self.subscriptionUntilDate, verificationIconFileId: self.verificationIconFileId, sendPaidMessageStars: self.sendPaidMessageStars, linkedMonoforumId: self.linkedMonoforumId, linkedCommunityId: self.linkedCommunityId)
    }
    
    public func withUpdatedBackgroundEmojiId(_ backgroundEmojiId: Int64?) -> IosappChannel {
        return IosappChannel(id: self.id, accessHash: self.accessHash, title: self.title, username: self.username, photo: self.photo, creationDate: self.creationDate, version: self.version, participationStatus: self.participationStatus, info: self.info, flags: self.flags, restrictionInfo: self.restrictionInfo, adminRights: self.adminRights, bannedRights: self.bannedRights, defaultBannedRights: self.defaultBannedRights, usernames: self.usernames, storiesHidden: self.storiesHidden, nameColor: self.nameColor, backgroundEmojiId: backgroundEmojiId, profileColor: self.profileColor, profileBackgroundEmojiId: self.profileBackgroundEmojiId, emojiStatus: self.emojiStatus, approximateBoostLevel: self.approximateBoostLevel, subscriptionUntilDate: self.subscriptionUntilDate, verificationIconFileId: self.verificationIconFileId, sendPaidMessageStars: self.sendPaidMessageStars, linkedMonoforumId: self.linkedMonoforumId, linkedCommunityId: self.linkedCommunityId)
    }
    
    public func withUpdatedProfileColor(_ profileColor: PeerNameColor?) -> IosappChannel {
        return IosappChannel(id: self.id, accessHash: self.accessHash, title: self.title, username: self.username, photo: self.photo, creationDate: self.creationDate, version: self.version, participationStatus: self.participationStatus, info: self.info, flags: self.flags, restrictionInfo: self.restrictionInfo, adminRights: self.adminRights, bannedRights: self.bannedRights, defaultBannedRights: self.defaultBannedRights, usernames: self.usernames, storiesHidden: self.storiesHidden, nameColor: self.nameColor, backgroundEmojiId: self.backgroundEmojiId, profileColor: profileColor, profileBackgroundEmojiId: self.profileBackgroundEmojiId, emojiStatus: self.emojiStatus, approximateBoostLevel: self.approximateBoostLevel, subscriptionUntilDate: self.subscriptionUntilDate, verificationIconFileId: self.verificationIconFileId, sendPaidMessageStars: self.sendPaidMessageStars, linkedMonoforumId: self.linkedMonoforumId, linkedCommunityId: self.linkedCommunityId)
    }
    
    public func withUpdatedProfileBackgroundEmojiId(_ profileBackgroundEmojiId: Int64?) -> IosappChannel {
        return IosappChannel(id: self.id, accessHash: self.accessHash, title: self.title, username: self.username, photo: self.photo, creationDate: self.creationDate, version: self.version, participationStatus: self.participationStatus, info: self.info, flags: self.flags, restrictionInfo: self.restrictionInfo, adminRights: self.adminRights, bannedRights: self.bannedRights, defaultBannedRights: self.defaultBannedRights, usernames: self.usernames, storiesHidden: self.storiesHidden, nameColor: self.nameColor, backgroundEmojiId: self.backgroundEmojiId, profileColor: self.profileColor, profileBackgroundEmojiId: profileBackgroundEmojiId, emojiStatus: self.emojiStatus, approximateBoostLevel: self.approximateBoostLevel, subscriptionUntilDate: self.subscriptionUntilDate, verificationIconFileId: self.verificationIconFileId, sendPaidMessageStars: self.sendPaidMessageStars, linkedMonoforumId: self.linkedMonoforumId, linkedCommunityId: self.linkedCommunityId)
    }
    
    public func withUpdatedEmojiStatus(_ emojiStatus: PeerEmojiStatus?) -> IosappChannel {
        return IosappChannel(id: self.id, accessHash: self.accessHash, title: self.title, username: self.username, photo: self.photo, creationDate: self.creationDate, version: self.version, participationStatus: self.participationStatus, info: self.info, flags: self.flags, restrictionInfo: self.restrictionInfo, adminRights: self.adminRights, bannedRights: self.bannedRights, defaultBannedRights: self.defaultBannedRights, usernames: self.usernames, storiesHidden: self.storiesHidden, nameColor: self.nameColor, backgroundEmojiId: self.backgroundEmojiId, profileColor: self.profileColor, profileBackgroundEmojiId: self.profileBackgroundEmojiId, emojiStatus: emojiStatus, approximateBoostLevel: self.approximateBoostLevel, subscriptionUntilDate: self.subscriptionUntilDate, verificationIconFileId: self.verificationIconFileId, sendPaidMessageStars: self.sendPaidMessageStars, linkedMonoforumId: self.linkedMonoforumId, linkedCommunityId: self.linkedCommunityId)
    }
    
    public func withUpdatedApproximateBoostLevel(_ approximateBoostLevel: Int32?) -> IosappChannel {
        return IosappChannel(id: self.id, accessHash: self.accessHash, title: self.title, username: self.username, photo: self.photo, creationDate: self.creationDate, version: self.version, participationStatus: self.participationStatus, info: self.info, flags: self.flags, restrictionInfo: self.restrictionInfo, adminRights: self.adminRights, bannedRights: self.bannedRights, defaultBannedRights: self.defaultBannedRights, usernames: self.usernames, storiesHidden: self.storiesHidden, nameColor: self.nameColor, backgroundEmojiId: self.backgroundEmojiId, profileColor: self.profileColor, profileBackgroundEmojiId: self.profileBackgroundEmojiId, emojiStatus: self.emojiStatus, approximateBoostLevel: approximateBoostLevel, subscriptionUntilDate: self.subscriptionUntilDate, verificationIconFileId: self.verificationIconFileId, sendPaidMessageStars: self.sendPaidMessageStars, linkedMonoforumId: self.linkedMonoforumId, linkedCommunityId: self.linkedCommunityId)
    }
    
    public func withUpdatedSubscriptionUntilDate(_ subscriptionUntilDate: Int32?) -> IosappChannel {
        return IosappChannel(id: self.id, accessHash: self.accessHash, title: self.title, username: self.username, photo: self.photo, creationDate: self.creationDate, version: self.version, participationStatus: self.participationStatus, info: self.info, flags: self.flags, restrictionInfo: self.restrictionInfo, adminRights: self.adminRights, bannedRights: self.bannedRights, defaultBannedRights: self.defaultBannedRights, usernames: self.usernames, storiesHidden: self.storiesHidden, nameColor: self.nameColor, backgroundEmojiId: self.backgroundEmojiId, profileColor: self.profileColor, profileBackgroundEmojiId: self.profileBackgroundEmojiId, emojiStatus: self.emojiStatus, approximateBoostLevel: self.approximateBoostLevel, subscriptionUntilDate: subscriptionUntilDate, verificationIconFileId: self.verificationIconFileId, sendPaidMessageStars: self.sendPaidMessageStars, linkedMonoforumId: self.linkedMonoforumId, linkedCommunityId: self.linkedCommunityId)
    }
    
    public func withUpdatedVerificationIconFileId(_ verificationIconFileId: Int64?) -> IosappChannel {
        return IosappChannel(id: self.id, accessHash: self.accessHash, title: self.title, username: self.username, photo: self.photo, creationDate: self.creationDate, version: self.version, participationStatus: self.participationStatus, info: self.info, flags: self.flags, restrictionInfo: self.restrictionInfo, adminRights: self.adminRights, bannedRights: self.bannedRights, defaultBannedRights: self.defaultBannedRights, usernames: self.usernames, storiesHidden: self.storiesHidden, nameColor: self.nameColor, backgroundEmojiId: self.backgroundEmojiId, profileColor: self.profileColor, profileBackgroundEmojiId: self.profileBackgroundEmojiId, emojiStatus: self.emojiStatus, approximateBoostLevel: self.approximateBoostLevel, subscriptionUntilDate: self.subscriptionUntilDate, verificationIconFileId: verificationIconFileId, sendPaidMessageStars: self.sendPaidMessageStars, linkedMonoforumId: self.linkedMonoforumId, linkedCommunityId: self.linkedCommunityId)
    }
    
    public init(flatBuffersObject: IosappCore_IosappChannel) throws {
        self.id = PeerId(flatBuffersObject: flatBuffersObject.id)
        self.accessHash = try flatBuffersObject.accessHash.flatMap(IosappPeerAccessHash.init)
        self.title = flatBuffersObject.title
        self.username = flatBuffersObject.username
        self.photo = try (0 ..< flatBuffersObject.photoCount).map { try IosappMediaImageRepresentation(flatBuffersObject: flatBuffersObject.photo(at: $0)!) }
        self.creationDate = flatBuffersObject.creationDate
        self.version = flatBuffersObject.version
        self.participationStatus = IosappChannelParticipationStatus(rawValue: flatBuffersObject.participationStatus)
        
        guard let infoObj = flatBuffersObject.info else {
            throw FlatBuffersError.missingRequiredField()
        }
        self.info = try IosappChannelInfo(flatBuffersObject: infoObj)
        
        self.flags = IosappChannelFlags(rawValue: flatBuffersObject.flags)
        self.restrictionInfo = try flatBuffersObject.restrictionInfo.flatMap { try PeerAccessRestrictionInfo(flatBuffersObject: $0) }
        self.adminRights = try flatBuffersObject.adminRights.flatMap { try IosappChatAdminRights(flatBuffersObject: $0) }
        self.bannedRights = try flatBuffersObject.bannedRights.flatMap { try IosappChatBannedRights(flatBuffersObject: $0) }
        self.defaultBannedRights = try flatBuffersObject.defaultBannedRights.map { try IosappChatBannedRights(flatBuffersObject: $0) }
        self.usernames = try (0 ..< flatBuffersObject.usernamesCount).map { try IosappPeerUsername(flatBuffersObject: flatBuffersObject.usernames(at: $0)!) }
        self.storiesHidden = flatBuffersObject.storiesHidden?.value
        self.nameColor = try flatBuffersObject.nameColor.flatMap(PeerNameColor.init(flatBuffersObject:))
        self.backgroundEmojiId = flatBuffersObject.backgroundEmojiId == Int64.min ? nil : flatBuffersObject.backgroundEmojiId
        self.profileColor = try flatBuffersObject.profileColor.flatMap(PeerNameColor.init)
        self.profileBackgroundEmojiId = flatBuffersObject.profileBackgroundEmojiId == Int64.min ? nil : flatBuffersObject.profileBackgroundEmojiId
        self.emojiStatus = try flatBuffersObject.emojiStatus.flatMap { try PeerEmojiStatus(flatBuffersObject: $0) }
        self.approximateBoostLevel = flatBuffersObject.approximateBoostLevel == Int32.min ? nil : flatBuffersObject.approximateBoostLevel
        self.subscriptionUntilDate = flatBuffersObject.subscriptionUntilDate == Int32.min ? nil : flatBuffersObject.subscriptionUntilDate
        self.verificationIconFileId = flatBuffersObject.verificationIconFileId == Int64.min ? nil : flatBuffersObject.verificationIconFileId
        self.sendPaidMessageStars = try flatBuffersObject.sendPaidMessageStars.flatMap { try StarsAmount(flatBuffersObject: $0) }
        self.linkedMonoforumId = flatBuffersObject.linkedMonoforumId.flatMap { PeerId(flatBuffersObject: $0) }
        self.linkedCommunityId = flatBuffersObject.linkedCommunityId.flatMap { PeerId(flatBuffersObject: $0) }
    }
    
    public func encodeToFlatBuffers(builder: inout FlatBufferBuilder) -> Offset {
        let accessHashOffset = self.accessHash.flatMap { $0.encodeToFlatBuffers(builder: &builder) }
        
        let photoOffsets = self.photo.map { $0.encodeToFlatBuffers(builder: &builder) }
        let photoOffset = builder.createVector(ofOffsets: photoOffsets, len: photoOffsets.count)
        
        let usernamesOffsets = self.usernames.map { $0.encodeToFlatBuffers(builder: &builder) }
        let usernamesOffset = builder.createVector(ofOffsets: usernamesOffsets, len: usernamesOffsets.count)
        
        let titleOffset = builder.create(string: self.title)
        let usernameOffset = self.username.map { builder.create(string: $0) }
        let nameColorOffset = self.nameColor.flatMap { $0.encodeToFlatBuffers(builder: &builder) }
        let profileColorOffset = self.profileColor.flatMap { $0.encodeToFlatBuffers(builder: &builder) }
        
        let infoOffset = self.info.encodeToFlatBuffers(builder: &builder)
        
        let restrictionInfoOffset = self.restrictionInfo?.encodeToFlatBuffers(builder: &builder)
        let adminRightsOffset = self.adminRights?.encodeToFlatBuffers(builder: &builder)
        let bannedRightsOffset = self.bannedRights?.encodeToFlatBuffers(builder: &builder)
        let defaultBannedRightsOffset = self.defaultBannedRights?.encodeToFlatBuffers(builder: &builder)
        let emojiStatusOffset = self.emojiStatus?.encodeToFlatBuffers(builder: &builder)
        let sendPaidMessageStarsOffset = self.sendPaidMessageStars?.encodeToFlatBuffers(builder: &builder)
        
        let start = IosappCore_IosappChannel.startIosappChannel(&builder)
        
        IosappCore_IosappChannel.add(id: self.id.asFlatBuffersObject(), &builder)
        if let accessHashOffset {
            IosappCore_IosappChannel.add(accessHash: accessHashOffset, &builder)
        }
        IosappCore_IosappChannel.add(title: titleOffset, &builder)
        if let usernameOffset {
            IosappCore_IosappChannel.add(username: usernameOffset, &builder)
        }
        IosappCore_IosappChannel.addVectorOf(photo: photoOffset, &builder)
        IosappCore_IosappChannel.add(creationDate: self.creationDate, &builder)
        IosappCore_IosappChannel.add(version: self.version, &builder)
        IosappCore_IosappChannel.add(participationStatus: self.participationStatus.rawValue, &builder)
        IosappCore_IosappChannel.add(info: infoOffset, &builder)
        IosappCore_IosappChannel.add(flags: self.flags.rawValue, &builder)
        
        if let restrictionInfoOffset {
            IosappCore_IosappChannel.add(restrictionInfo: restrictionInfoOffset, &builder)
        }
        if let adminRightsOffset {
            IosappCore_IosappChannel.add(adminRights: adminRightsOffset, &builder)
        }
        if let bannedRightsOffset {
            IosappCore_IosappChannel.add(bannedRights: bannedRightsOffset, &builder)
        }
        if let defaultBannedRightsOffset {
            IosappCore_IosappChannel.add(defaultBannedRights: defaultBannedRightsOffset, &builder)
        }
        
        IosappCore_IosappChannel.addVectorOf(usernames: usernamesOffset, &builder)
        
        if let storiesHidden = self.storiesHidden {
            IosappCore_IosappChannel.add(storiesHidden: IosappCore_OptionalBool(value: storiesHidden), &builder)
        }
        if let nameColorOffset {
            IosappCore_IosappChannel.add(nameColor: nameColorOffset, &builder)
        }
        IosappCore_IosappChannel.add(backgroundEmojiId: self.backgroundEmojiId ?? Int64.min, &builder)
        if let profileColorOffset {
            IosappCore_IosappChannel.add(profileColor: profileColorOffset, &builder)
        }
        IosappCore_IosappChannel.add(profileBackgroundEmojiId: self.profileBackgroundEmojiId ?? Int64.min, &builder)
        if let emojiStatusOffset {
            IosappCore_IosappChannel.add(emojiStatus: emojiStatusOffset, &builder)
        }
        IosappCore_IosappChannel.add(approximateBoostLevel: self.approximateBoostLevel ?? Int32.min, &builder)
        IosappCore_IosappChannel.add(subscriptionUntilDate: self.subscriptionUntilDate ?? Int32.min, &builder)
        IosappCore_IosappChannel.add(verificationIconFileId: self.verificationIconFileId ?? Int64.min, &builder)
        if let sendPaidMessageStarsOffset {
            IosappCore_IosappChannel.add(sendPaidMessageStars: sendPaidMessageStarsOffset, &builder)
        }
        if let linkedMonoforumId = self.linkedMonoforumId {
            IosappCore_IosappChannel.add(linkedMonoforumId: linkedMonoforumId.asFlatBuffersObject(), &builder)
        }
        if let linkedCommunityId = self.linkedCommunityId {
            IosappCore_IosappChannel.add(linkedCommunityId: linkedCommunityId.asFlatBuffersObject(), &builder)
        }
        
        return IosappCore_IosappChannel.endIosappChannel(&builder, start: start)
    }
}
