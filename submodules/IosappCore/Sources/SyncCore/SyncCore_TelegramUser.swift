import Postbox
import FlatBuffers
import FlatSerialization

public struct UserInfoFlags: OptionSet {
    public var rawValue: Int32
    
    public init() {
        self.rawValue = 0
    }
    
    public init(rawValue: Int32) {
        self.rawValue = rawValue
    }
    
    public static let isVerified = UserInfoFlags(rawValue: (1 << 0))
    public static let isSupport = UserInfoFlags(rawValue: (1 << 1))
    public static let isScam = UserInfoFlags(rawValue: (1 << 2))
    public static let isFake = UserInfoFlags(rawValue: (1 << 3))
    public static let isPremium = UserInfoFlags(rawValue: (1 << 4))
    public static let isCloseFriend = UserInfoFlags(rawValue: (1 << 5))
    public static let requirePremium = UserInfoFlags(rawValue: (1 << 6))
    public static let mutualContact = UserInfoFlags(rawValue: (1 << 7))
    public static let requireStars = UserInfoFlags(rawValue: (1 << 8))
}

public struct BotUserInfoFlags: OptionSet {
    public var rawValue: Int32
    
    public init() {
        self.rawValue = 0
    }
    
    public init(rawValue: Int32) {
        self.rawValue = rawValue
    }
    
    public static let hasAccessToChatHistory = BotUserInfoFlags(rawValue: (1 << 0))
    public static let worksWithGroups = BotUserInfoFlags(rawValue: (1 << 1))
    public static let requiresGeolocationForInlineRequests = BotUserInfoFlags(rawValue: (1 << 3))
    public static let canBeAddedToAttachMenu = BotUserInfoFlags(rawValue: (1 << 4))
    public static let canEdit = BotUserInfoFlags(rawValue: (1 << 5))
    public static let isBusiness = BotUserInfoFlags(rawValue: (1 << 6))
    public static let hasWebApp = BotUserInfoFlags(rawValue: (1 << 7))
    public static let hasForum = BotUserInfoFlags(rawValue: (1 << 8))
    public static let forumManagedByUser = BotUserInfoFlags(rawValue: (1 << 9))
    public static let canManageBots = BotUserInfoFlags(rawValue: (1 << 10))
    public static let isGuestChat = BotUserInfoFlags(rawValue: (1 << 11))
    public static let isGuardBot = BotUserInfoFlags(rawValue: (1 << 12))
}

public struct BotUserInfo: PostboxCoding, Equatable {
    public let flags: BotUserInfoFlags
    public let inlinePlaceholder: String?
    
    public init(flags: BotUserInfoFlags, inlinePlaceholder: String?) {
        self.flags = flags
        self.inlinePlaceholder = inlinePlaceholder
    }
    
    public init(decoder: PostboxDecoder) {
        self.flags = BotUserInfoFlags(rawValue: decoder.decodeInt32ForKey("f", orElse: 0))
        self.inlinePlaceholder = decoder.decodeOptionalStringForKey("ip")
    }
    
    public func encode(_ encoder: PostboxEncoder) {
        encoder.encodeInt32(self.flags.rawValue, forKey: "f")
        if let inlinePlaceholder = self.inlinePlaceholder {
            encoder.encodeString(inlinePlaceholder, forKey: "ip")
        } else {
            encoder.encodeNil(forKey: "ip")
        }
    }
    
    public init(flatBuffersObject: IosappCore_BotUserInfo) throws {
        self.flags = BotUserInfoFlags(rawValue: flatBuffersObject.flags)
        self.inlinePlaceholder = flatBuffersObject.inlinePlaceholder
    }
    
    public func encodeToFlatBuffers(builder: inout FlatBufferBuilder) -> Offset {
        let inlinePlaceholderOffset = self.inlinePlaceholder.map { builder.create(string: $0) }
        
        let start = IosappCore_BotUserInfo.startBotUserInfo(&builder)
        IosappCore_BotUserInfo.add(flags: self.flags.rawValue, &builder)
        if let inlinePlaceholderOffset {
            IosappCore_BotUserInfo.add(inlinePlaceholder: inlinePlaceholderOffset, &builder)
        }
        return IosappCore_BotUserInfo.endBotUserInfo(&builder, start: start)
    }
}

public struct IosappPeerUsername: PostboxCoding, Equatable {
    public struct Flags: OptionSet {
        public var rawValue: Int32
        
        public init() {
            self.rawValue = 0
        }
        
        public init(rawValue: Int32) {
            self.rawValue = rawValue
        }
        
        public static let isEditable = Flags(rawValue: (1 << 0))
        public static let isActive = Flags(rawValue: (1 << 1))
    }
    
    public let flags: Flags
    public let username: String
    
    public init(flags: Flags, username: String) {
        self.flags = flags
        self.username = username
    }
    
    public init(decoder: PostboxDecoder) {
        self.flags = Flags(rawValue: decoder.decodeInt32ForKey("f", orElse: 0))
        self.username = decoder.decodeStringForKey("un", orElse: "")
    }
    
    public func encode(_ encoder: PostboxEncoder) {
        encoder.encodeInt32(self.flags.rawValue, forKey: "f")
        encoder.encodeString(self.username, forKey: "un")
    }
    
    public init(flatBuffersObject: IosappCore_IosappPeerUsername) throws {
        self.flags = Flags(rawValue: flatBuffersObject.flags)
        self.username = flatBuffersObject.username
    }
    
    public func encodeToFlatBuffers(builder: inout FlatBufferBuilder) -> Offset {
        let usernameOffset = builder.create(string: self.username)
        
        let start = IosappCore_IosappPeerUsername.startIosappPeerUsername(&builder)
        IosappCore_IosappPeerUsername.add(flags: self.flags.rawValue, &builder)
        IosappCore_IosappPeerUsername.add(username: usernameOffset, &builder)
        return IosappCore_IosappPeerUsername.endIosappPeerUsername(&builder, start: start)
    }
}

public struct PeerVerification: Codable, Equatable {
    public let botId: PeerId
    public let iconFileId: Int64
    public let description: String
    
    public init(
        botId: PeerId,
        iconFileId: Int64,
        description: String
    ) {
        self.botId = botId
        self.iconFileId = iconFileId
        self.description = description
    }
}

public final class IosappUser: Peer, Equatable {
    public let id: PeerId
    public let accessHash: IosappPeerAccessHash?
    public let firstName: String?
    public let lastName: String?
    public let username: String?
    public let phone: String?
    public let photo: [IosappMediaImageRepresentation]
    public let botInfo: BotUserInfo?
    public let restrictionInfo: PeerAccessRestrictionInfo?
    public let flags: UserInfoFlags
    public let emojiStatus: PeerEmojiStatus?
    public let usernames: [IosappPeerUsername]
    public let storiesHidden: Bool?
    public let nameColor: PeerColor?
    public let backgroundEmojiId: Int64?
    public let profileColor: PeerNameColor?
    public let profileBackgroundEmojiId: Int64?
    public let subscriberCount: Int32?
    public let verificationIconFileId: Int64?
    public let linkedCommunityId: PeerId?

    public var nameOrPhone: String {
        if let firstName = self.firstName {
            if let lastName = self.lastName {
                return "\(firstName) \(lastName)"
            } else {
                return firstName
            }
        } else if let lastName = self.lastName {
            return lastName
        } else if let phone = self.phone, !phone.isEmpty {
            return phone
        } else {
            return ""
        }
    }
    
    public var shortNameOrPhone: String {
        if let firstName = self.firstName {
            return firstName
        } else if let lastName = self.lastName {
            return lastName
        } else if let phone = self.phone, !phone.isEmpty {
            return phone
        } else {
            return ""
        }
    }
    
    public var indexName: PeerIndexNameRepresentation {
        var addressNames = self.usernames.map { $0.username }
        if addressNames.isEmpty, let username = self.username, !username.isEmpty {
            addressNames = [username]
        }
        return .personName(first: self.firstName ?? "", last: self.lastName ?? "", addressNames: addressNames, phoneNumber: self.phone)
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
    
    public let associatedPeerId: PeerId? = nil
    public let notificationSettingsPeerId: PeerId? = nil

    public var containerPeerId: PeerId? {
        return self.linkedCommunityId
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
        firstName: String?,
        lastName: String?,
        username: String?,
        phone: String?,
        photo: [IosappMediaImageRepresentation], 
        botInfo: BotUserInfo?,
        restrictionInfo: PeerAccessRestrictionInfo?,
        flags: UserInfoFlags,
        emojiStatus: PeerEmojiStatus?,
        usernames: [IosappPeerUsername],
        storiesHidden: Bool?,
        nameColor: PeerColor?,
        backgroundEmojiId: Int64?,
        profileColor: PeerNameColor?,
        profileBackgroundEmojiId: Int64?,
        subscriberCount: Int32?,
        verificationIconFileId: Int64?,
        linkedCommunityId: PeerId? = nil
    ) {
        self.id = id
        self.accessHash = accessHash
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.phone = phone
        self.photo = photo
        self.botInfo = botInfo
        self.restrictionInfo = restrictionInfo
        self.flags = flags
        self.emojiStatus = emojiStatus
        self.usernames = usernames
        self.storiesHidden = storiesHidden
        self.nameColor = nameColor
        self.backgroundEmojiId = backgroundEmojiId
        self.profileColor = profileColor
        self.profileBackgroundEmojiId = profileBackgroundEmojiId
        self.subscriberCount = subscriberCount
        self.verificationIconFileId = verificationIconFileId
        self.linkedCommunityId = linkedCommunityId
    }
    
    public init(decoder: PostboxDecoder) {
        self.id = PeerId(decoder.decodeInt64ForKey("i", orElse: 0))
        
        let accessHash: Int64 = decoder.decodeInt64ForKey("ah", orElse: 0)
        let accessHashType: Int32 = decoder.decodeInt32ForKey("aht", orElse: 0)
        if accessHash != 0 {
            if accessHashType == 0 {
                self.accessHash = .personal(accessHash)
            } else {
                self.accessHash = .genericPublic(accessHash)
            }
        } else {
            self.accessHash = nil
        }
        
        self.firstName = decoder.decodeOptionalStringForKey("fn")
        self.lastName = decoder.decodeOptionalStringForKey("ln")
        
        self.username = decoder.decodeOptionalStringForKey("un")
        self.phone = decoder.decodeOptionalStringForKey("p")
        
        self.photo = decoder.decodeObjectArrayForKey("ph")
        
        if let botInfo = decoder.decodeObjectForKey("bi", decoder: { return BotUserInfo(decoder: $0) }) as? BotUserInfo {
            self.botInfo = botInfo
        } else {
            self.botInfo = nil
        }
        
        self.restrictionInfo = decoder.decodeObjectForKey("ri") as? PeerAccessRestrictionInfo
        
        self.flags = UserInfoFlags(rawValue: decoder.decodeInt32ForKey("fl", orElse: 0))
        
        self.emojiStatus = decoder.decode(PeerEmojiStatus.self, forKey: "emjs")
        
        self.usernames = decoder.decodeObjectArrayForKey("uns")
        self.storiesHidden = decoder.decodeOptionalBoolForKey("sth")
        
        if let collectibleColor = decoder.decodeCodable(PeerCollectibleColor.self, forKey: "clclr") {
            self.nameColor = .collectible(collectibleColor)
        } else if let nameColor = decoder.decodeOptionalInt32ForKey("nclr").flatMap({ PeerNameColor(rawValue: $0) }) {
            self.nameColor = .preset(nameColor)
        } else {
            self.nameColor = nil
        }
        self.backgroundEmojiId = decoder.decodeOptionalInt64ForKey("bgem")
        self.profileColor = decoder.decodeOptionalInt32ForKey("pclr").flatMap { PeerNameColor(rawValue: $0) }
        self.profileBackgroundEmojiId = decoder.decodeOptionalInt64ForKey("pgem")
        self.subscriberCount = decoder.decodeOptionalInt32ForKey("ssc")
        self.verificationIconFileId = decoder.decodeOptionalInt64ForKey("vfid")
        self.linkedCommunityId = decoder.decodeOptionalInt64ForKey("lcid").flatMap(PeerId.init)
        
        #if DEBUG && false
        var builder = FlatBufferBuilder(initialSize: 1024)
        let offset = self.encodeToFlatBuffers(builder: &builder)
        builder.finish(offset: offset)
        let serializedData = builder.data
        var byteBuffer = ByteBuffer(data: serializedData)
        let deserializedValue = FlatBuffers_getRoot(byteBuffer: &byteBuffer) as IosappCore_IosappUser
        let parsedValue = try! IosappUser(flatBuffersObject: deserializedValue)
        assert(self == parsedValue)
        #endif
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
        }
        
        if let firstName = self.firstName {
            encoder.encodeString(firstName, forKey: "fn")
        }
        if let lastName = self.lastName {
            encoder.encodeString(lastName, forKey: "ln")
        }
        
        if let username = self.username {
            encoder.encodeString(username, forKey: "un")
        }
        if let phone = self.phone {
            encoder.encodeString(phone, forKey: "p")
        }
        
        encoder.encodeObjectArray(self.photo, forKey: "ph")
        
        if let botInfo = self.botInfo {
            encoder.encodeObject(botInfo, forKey: "bi")
        } else {
            encoder.encodeNil(forKey: "bi")
        }
        
        if let restrictionInfo = self.restrictionInfo {
            encoder.encodeObject(restrictionInfo, forKey: "ri")
        } else {
            encoder.encodeNil(forKey: "ri")
        }
        
        encoder.encodeInt32(self.flags.rawValue, forKey: "fl")
        
        if let emojiStatus = self.emojiStatus {
            encoder.encode(emojiStatus, forKey: "emjs")
        } else {
            encoder.encodeNil(forKey: "emjs")
        }
        
        encoder.encodeObjectArray(self.usernames, forKey: "uns")
        
        if let storiesHidden = self.storiesHidden {
            encoder.encodeBool(storiesHidden, forKey: "sth")
        } else {
            encoder.encodeNil(forKey: "sth")
        }
        
        if let nameColor = self.nameColor {
            switch nameColor {
            case let .preset(nameColor):
                encoder.encodeInt32(nameColor.rawValue, forKey: "nclr")
                encoder.encodeNil(forKey: "clclr")
            case let .collectible(collectibleColor):
                encoder.encodeCodable(collectibleColor, forKey: "clclr")
                encoder.encodeNil(forKey: "nclr")
            }
        } else {
            encoder.encodeNil(forKey: "clclr")
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
        
        if let subscriberCount = self.subscriberCount {
            encoder.encodeInt32(subscriberCount, forKey: "ssc")
        } else {
            encoder.encodeNil(forKey: "ssc")
        }
        
        if let verificationIconFileId = self.verificationIconFileId {
            encoder.encodeInt64(verificationIconFileId, forKey: "vfid")
        } else {
            encoder.encodeNil(forKey: "vfid")
        }

        if let linkedCommunityId = self.linkedCommunityId {
            encoder.encodeInt64(linkedCommunityId.toInt64(), forKey: "lcid")
        } else {
            encoder.encodeNil(forKey: "lcid")
        }
    }
    
    public func isEqual(_ other: Peer) -> Bool {
        if let other = other as? IosappUser {
            return self == other
        } else {
            return false
        }
    }

    public static func ==(lhs: IosappUser, rhs: IosappUser) -> Bool {
        if lhs === rhs {
            return true
        }
        if lhs.id != rhs.id {
            return false
        }
        if lhs.accessHash != rhs.accessHash {
            return false
        }
        if lhs.firstName != rhs.firstName {
            return false
        }
        if lhs.lastName != rhs.lastName {
            return false
        }
        if lhs.phone != rhs.phone {
            return false
        }
        if lhs.photo.count != rhs.photo.count {
            return false
        }
        for i in 0 ..< lhs.photo.count {
            if lhs.photo[i] != rhs.photo[i] {
                return false
            }
        }
        if lhs.botInfo != rhs.botInfo {
            return false
        }
        if lhs.restrictionInfo != rhs.restrictionInfo {
            return false
        }
        if lhs.flags != rhs.flags {
            return false
        }
        if lhs.emojiStatus != rhs.emojiStatus {
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
        if lhs.subscriberCount != rhs.subscriberCount {
            return false
        }
        if lhs.verificationIconFileId != rhs.verificationIconFileId {
            return false
        }
        if lhs.linkedCommunityId != rhs.linkedCommunityId {
            return false
        }
        return true
    }
    
    public func withUpdatedUsername(_ username: String?) -> IosappUser {
        return IosappUser(id: self.id, accessHash: self.accessHash, firstName: self.firstName, lastName: self.lastName, username: username, phone: self.phone, photo: self.photo, botInfo: self.botInfo, restrictionInfo: self.restrictionInfo, flags: self.flags, emojiStatus: self.emojiStatus, usernames: self.usernames, storiesHidden: self.storiesHidden, nameColor: self.nameColor, backgroundEmojiId: self.backgroundEmojiId, profileColor: self.profileColor, profileBackgroundEmojiId: self.profileBackgroundEmojiId, subscriberCount: self.subscriberCount, verificationIconFileId: self.verificationIconFileId, linkedCommunityId: self.linkedCommunityId)
    }
    
    public func withUpdatedUsernames(_ usernames: [IosappPeerUsername]) -> IosappUser {
        return IosappUser(id: self.id, accessHash: self.accessHash, firstName: self.firstName, lastName: self.lastName, username: self.username, phone: self.phone, photo: self.photo, botInfo: self.botInfo, restrictionInfo: self.restrictionInfo, flags: self.flags, emojiStatus: self.emojiStatus, usernames: usernames, storiesHidden: self.storiesHidden, nameColor: self.nameColor, backgroundEmojiId: self.backgroundEmojiId, profileColor: self.profileColor, profileBackgroundEmojiId: self.profileBackgroundEmojiId, subscriberCount: self.subscriberCount, verificationIconFileId: self.verificationIconFileId, linkedCommunityId: self.linkedCommunityId)
    }
    
    public func withUpdatedNames(firstName: String?, lastName: String?) -> IosappUser {
        return IosappUser(id: self.id, accessHash: self.accessHash, firstName: firstName, lastName: lastName, username: self.username, phone: self.phone, photo: self.photo, botInfo: self.botInfo, restrictionInfo: self.restrictionInfo, flags: self.flags, emojiStatus: self.emojiStatus, usernames: self.usernames, storiesHidden: self.storiesHidden, nameColor: self.nameColor, backgroundEmojiId: self.backgroundEmojiId, profileColor: self.profileColor, profileBackgroundEmojiId: self.profileBackgroundEmojiId, subscriberCount: self.subscriberCount, verificationIconFileId: self.verificationIconFileId, linkedCommunityId: self.linkedCommunityId)
    }
    
    public func withUpdatedPhone(_ phone: String?) -> IosappUser {
        return IosappUser(id: self.id, accessHash: self.accessHash, firstName: self.firstName, lastName: self.lastName, username: self.username, phone: phone, photo: self.photo, botInfo: self.botInfo, restrictionInfo: self.restrictionInfo, flags: self.flags, emojiStatus: self.emojiStatus, usernames: self.usernames, storiesHidden: self.storiesHidden, nameColor: self.nameColor, backgroundEmojiId: self.backgroundEmojiId, profileColor: self.profileColor, profileBackgroundEmojiId: self.profileBackgroundEmojiId, subscriberCount: self.subscriberCount, verificationIconFileId: self.verificationIconFileId, linkedCommunityId: self.linkedCommunityId)
    }
    
    public func withUpdatedPhoto(_ representations: [IosappMediaImageRepresentation]) -> IosappUser {
        return IosappUser(id: self.id, accessHash: self.accessHash, firstName: self.firstName, lastName: self.lastName, username: self.username, phone: phone, photo: representations, botInfo: self.botInfo, restrictionInfo: self.restrictionInfo, flags: self.flags, emojiStatus: self.emojiStatus, usernames: self.usernames, storiesHidden: self.storiesHidden, nameColor: self.nameColor, backgroundEmojiId: self.backgroundEmojiId, profileColor: self.profileColor, profileBackgroundEmojiId: self.profileBackgroundEmojiId, subscriberCount: self.subscriberCount, verificationIconFileId: self.verificationIconFileId, linkedCommunityId: self.linkedCommunityId)
    }
    
    public func withUpdatedEmojiStatus(_ emojiStatus: PeerEmojiStatus?) -> IosappUser {
        return IosappUser(id: self.id, accessHash: self.accessHash, firstName: self.firstName, lastName: self.lastName, username: self.username, phone: phone, photo: self.photo, botInfo: self.botInfo, restrictionInfo: self.restrictionInfo, flags: self.flags, emojiStatus: emojiStatus, usernames: self.usernames, storiesHidden: self.storiesHidden, nameColor: self.nameColor, backgroundEmojiId: self.backgroundEmojiId, profileColor: self.profileColor, profileBackgroundEmojiId: self.profileBackgroundEmojiId, subscriberCount: self.subscriberCount, verificationIconFileId: self.verificationIconFileId, linkedCommunityId: self.linkedCommunityId)
    }
    
    public func withUpdatedFlags(_ flags: UserInfoFlags) -> IosappUser {
        return IosappUser(id: self.id, accessHash: self.accessHash, firstName: self.firstName, lastName: self.lastName, username: self.username, phone: self.phone, photo: self.photo, botInfo: self.botInfo, restrictionInfo: self.restrictionInfo, flags: flags, emojiStatus: self.emojiStatus, usernames: self.usernames, storiesHidden: self.storiesHidden, nameColor: self.nameColor, backgroundEmojiId: self.backgroundEmojiId, profileColor: self.profileColor, profileBackgroundEmojiId: self.profileBackgroundEmojiId, subscriberCount: self.subscriberCount, verificationIconFileId: self.verificationIconFileId, linkedCommunityId: self.linkedCommunityId)
    }
    
    public func withUpdatedStoriesHidden(_ storiesHidden: Bool?) -> IosappUser {
        return IosappUser(id: self.id, accessHash: self.accessHash, firstName: self.firstName, lastName: self.lastName, username: self.username, phone: self.phone, photo: self.photo, botInfo: self.botInfo, restrictionInfo: self.restrictionInfo, flags: self.flags, emojiStatus: self.emojiStatus, usernames: self.usernames, storiesHidden: storiesHidden, nameColor: self.nameColor, backgroundEmojiId: self.backgroundEmojiId, profileColor: self.profileColor, profileBackgroundEmojiId: self.profileBackgroundEmojiId, subscriberCount: self.subscriberCount, verificationIconFileId: self.verificationIconFileId, linkedCommunityId: self.linkedCommunityId)
    }
    
    public func withUpdatedNameColor(_ nameColor: PeerColor) -> IosappUser {
        return IosappUser(id: self.id, accessHash: self.accessHash, firstName: self.firstName, lastName: self.lastName, username: self.username, phone: self.phone, photo: self.photo, botInfo: self.botInfo, restrictionInfo: self.restrictionInfo, flags: self.flags, emojiStatus: self.emojiStatus, usernames: self.usernames, storiesHidden: self.storiesHidden, nameColor: nameColor, backgroundEmojiId: self.backgroundEmojiId, profileColor: self.profileColor, profileBackgroundEmojiId: self.profileBackgroundEmojiId, subscriberCount: self.subscriberCount, verificationIconFileId: self.verificationIconFileId, linkedCommunityId: self.linkedCommunityId)
    }
    
    public func withUpdatedBackgroundEmojiId(_ backgroundEmojiId: Int64?) -> IosappUser {
        return IosappUser(id: self.id, accessHash: self.accessHash, firstName: self.firstName, lastName: self.lastName, username: self.username, phone: self.phone, photo: self.photo, botInfo: self.botInfo, restrictionInfo: self.restrictionInfo, flags: self.flags, emojiStatus: self.emojiStatus, usernames: self.usernames, storiesHidden: self.storiesHidden, nameColor: self.nameColor, backgroundEmojiId: backgroundEmojiId, profileColor: self.profileColor, profileBackgroundEmojiId: self.profileBackgroundEmojiId, subscriberCount: self.subscriberCount, verificationIconFileId: self.verificationIconFileId, linkedCommunityId: self.linkedCommunityId)
    }
    
    public func withUpdatedProfileColor(_ profileColor: PeerNameColor?) -> IosappUser {
        return IosappUser(id: self.id, accessHash: self.accessHash, firstName: self.firstName, lastName: self.lastName, username: self.username, phone: self.phone, photo: self.photo, botInfo: self.botInfo, restrictionInfo: self.restrictionInfo, flags: self.flags, emojiStatus: self.emojiStatus, usernames: self.usernames, storiesHidden: self.storiesHidden, nameColor: self.nameColor, backgroundEmojiId: self.backgroundEmojiId, profileColor: profileColor, profileBackgroundEmojiId: self.profileBackgroundEmojiId, subscriberCount: self.subscriberCount, verificationIconFileId: self.verificationIconFileId, linkedCommunityId: self.linkedCommunityId)
    }
    
    public func withUpdatedProfileBackgroundEmojiId(_ profileBackgroundEmojiId: Int64?) -> IosappUser {
        return IosappUser(id: self.id, accessHash: self.accessHash, firstName: self.firstName, lastName: self.lastName, username: self.username, phone: self.phone, photo: self.photo, botInfo: self.botInfo, restrictionInfo: self.restrictionInfo, flags: self.flags, emojiStatus: self.emojiStatus, usernames: self.usernames, storiesHidden: self.storiesHidden, nameColor: self.nameColor, backgroundEmojiId: self.backgroundEmojiId, profileColor: self.profileColor, profileBackgroundEmojiId: profileBackgroundEmojiId, subscriberCount: self.subscriberCount, verificationIconFileId: self.verificationIconFileId, linkedCommunityId: self.linkedCommunityId)
    }
    
    public init(flatBuffersObject: IosappCore_IosappUser) throws {
        self.id = PeerId(flatBuffersObject.id)
        self.accessHash = try flatBuffersObject.accessHash.flatMap(IosappPeerAccessHash.init)
        self.firstName = flatBuffersObject.firstName
        self.lastName = flatBuffersObject.lastName
        self.username = flatBuffersObject.username
        self.phone = flatBuffersObject.phone
        self.photo = try (0 ..< flatBuffersObject.photoCount).map { try IosappMediaImageRepresentation(flatBuffersObject: flatBuffersObject.photo(at: $0)!) }
        self.botInfo = try flatBuffersObject.botInfo.flatMap { try BotUserInfo(flatBuffersObject: $0) }
        self.restrictionInfo = try flatBuffersObject.restrictionInfo.flatMap { try PeerAccessRestrictionInfo(flatBuffersObject: $0) }
        self.flags = UserInfoFlags(rawValue: flatBuffersObject.flags)
        self.emojiStatus = try flatBuffersObject.emojiStatus.flatMap { try PeerEmojiStatus(flatBuffersObject: $0) }
        self.usernames = try (0 ..< flatBuffersObject.usernamesCount).map { try IosappPeerUsername(flatBuffersObject: flatBuffersObject.usernames(at: $0)!) }
        self.storiesHidden = flatBuffersObject.storiesHidden?.value
        if let collectibleColor = try flatBuffersObject.collectibleColor.flatMap(PeerCollectibleColor.init) {
            self.nameColor = .collectible(collectibleColor)
        } else if let nameColor = try flatBuffersObject.nameColor.flatMap(PeerNameColor.init) {
            self.nameColor = .preset(nameColor)
        } else {
            self.nameColor = nil
        }
        self.backgroundEmojiId = flatBuffersObject.backgroundEmojiId == Int64.min ? nil : flatBuffersObject.backgroundEmojiId
        self.profileColor = try flatBuffersObject.profileColor.flatMap(PeerNameColor.init)
        self.profileBackgroundEmojiId = flatBuffersObject.profileBackgroundEmojiId == Int64.min ? nil : flatBuffersObject.profileBackgroundEmojiId
        self.subscriberCount = flatBuffersObject.subscriberCount == Int32.min ? nil : flatBuffersObject.subscriberCount
        self.verificationIconFileId = flatBuffersObject.verificationIconFileId == Int64.min ? nil : flatBuffersObject.verificationIconFileId
        self.linkedCommunityId = flatBuffersObject.linkedCommunityId.flatMap { PeerId(flatBuffersObject: $0) }
    }
    
    public func encodeToFlatBuffers(builder: inout FlatBufferBuilder) -> Offset {
        let accessHashOffset = self.accessHash.flatMap { $0.encodeToFlatBuffers(builder: &builder) }
        
        let firstNameOffset = self.firstName.map { builder.create(string: $0) }
        let lastNameOffset = self.lastName.map { builder.create(string: $0) }
        let usernameOffset = self.username.map { builder.create(string: $0) }
        let phoneOffset = self.phone.map { builder.create(string: $0) }
        
        let photoOffsets = self.photo.map { $0.encodeToFlatBuffers(builder: &builder) }
        let photoOffset = builder.createVector(ofOffsets: photoOffsets, len: photoOffsets.count)
        
        let botInfoOffset = self.botInfo?.encodeToFlatBuffers(builder: &builder)
        let restrictionInfoOffset = self.restrictionInfo?.encodeToFlatBuffers(builder: &builder)
        
        let usernamesOffsets = self.usernames.map { $0.encodeToFlatBuffers(builder: &builder) }
        let usernamesOffset = builder.createVector(ofOffsets: usernamesOffsets, len: usernamesOffsets.count)
        
        let nameColorOffset: Offset?
        let collectibleColorOffset: Offset?
        if case let .collectible(collectibleColor) = self.nameColor {
            nameColorOffset = nil
            collectibleColorOffset = collectibleColor.encodeToFlatBuffers(builder: &builder)
        } else if case let .preset(nameColor) = self.nameColor {
            nameColorOffset = nameColor.encodeToFlatBuffers(builder: &builder)
            collectibleColorOffset = nil
        } else {
            nameColorOffset = nil
            collectibleColorOffset = nil
        }        
        let profileColorOffset = self.profileColor.flatMap { $0.encodeToFlatBuffers(builder: &builder) }
        let emojiStatusOffset = self.emojiStatus?.encodeToFlatBuffers(builder: &builder)
        
        let start = IosappCore_IosappUser.startIosappUser(&builder)
        
        IosappCore_IosappUser.add(id: self.id.asFlatBuffersObject(), &builder)
        if let accessHashOffset {
            IosappCore_IosappUser.add(accessHash: accessHashOffset, &builder)
        }
        if let firstNameOffset {
            IosappCore_IosappUser.add(firstName: firstNameOffset, &builder)
        }
        if let lastNameOffset {
            IosappCore_IosappUser.add(lastName: lastNameOffset, &builder)
        }
        if let usernameOffset {
            IosappCore_IosappUser.add(username: usernameOffset, &builder)
        }
        if let phoneOffset {
            IosappCore_IosappUser.add(phone: phoneOffset, &builder)
        }
        IosappCore_IosappUser.addVectorOf(photo: photoOffset, &builder)
        if let botInfoOffset {
            IosappCore_IosappUser.add(botInfo: botInfoOffset, &builder)
        }
        if let restrictionInfoOffset {
            IosappCore_IosappUser.add(restrictionInfo: restrictionInfoOffset, &builder)
        }
        IosappCore_IosappUser.add(flags: self.flags.rawValue, &builder)
        if let emojiStatusOffset {
            IosappCore_IosappUser.add(emojiStatus: emojiStatusOffset, &builder)
        }
        IosappCore_IosappUser.addVectorOf(usernames: usernamesOffset, &builder)
        
        if let storiesHidden = self.storiesHidden {
            IosappCore_IosappUser.add(storiesHidden: IosappCore_OptionalBool(value: storiesHidden), &builder)
        }
        if let nameColorOffset {
            IosappCore_IosappUser.add(nameColor: nameColorOffset, &builder)
        }
        if let collectibleColorOffset {
            IosappCore_IosappUser.add(collectibleColor: collectibleColorOffset, &builder)
        }
        IosappCore_IosappUser.add(backgroundEmojiId: self.backgroundEmojiId ?? Int64.min, &builder)
        if let profileColorOffset {
            IosappCore_IosappUser.add(profileColor: profileColorOffset, &builder)
        }
        IosappCore_IosappUser.add(profileBackgroundEmojiId: self.profileBackgroundEmojiId ?? Int64.min, &builder)
        IosappCore_IosappUser.add(subscriberCount: self.subscriberCount ?? Int32.min, &builder)
        IosappCore_IosappUser.add(verificationIconFileId: self.verificationIconFileId ?? Int64.min, &builder)
        if let linkedCommunityId = self.linkedCommunityId {
            IosappCore_IosappUser.add(linkedCommunityId: linkedCommunityId.asFlatBuffersObject(), &builder)
        }
        
        return IosappCore_IosappUser.endIosappUser(&builder, start: start)
    }
}
