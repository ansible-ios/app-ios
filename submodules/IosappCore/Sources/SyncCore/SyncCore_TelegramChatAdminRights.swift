import Postbox
import FlatBuffers
import FlatSerialization

public struct IosappChatAdminRightsFlags: OptionSet, Hashable {
    public var rawValue: Int32
    
    public init(rawValue: Int32) {
        self.rawValue = rawValue
    }
    
    public init() {
        self.rawValue = 0
    }
    
    public static let canChangeInfo = IosappChatAdminRightsFlags(rawValue: 1 << 0)
    public static let canPostMessages = IosappChatAdminRightsFlags(rawValue: 1 << 1)
    public static let canEditMessages = IosappChatAdminRightsFlags(rawValue: 1 << 2)
    public static let canDeleteMessages = IosappChatAdminRightsFlags(rawValue: 1 << 3)
    public static let canBanUsers = IosappChatAdminRightsFlags(rawValue: 1 << 4)
    public static let canInviteUsers = IosappChatAdminRightsFlags(rawValue: 1 << 5)
    public static let canPinMessages = IosappChatAdminRightsFlags(rawValue: 1 << 7)
    public static let canAddAdmins = IosappChatAdminRightsFlags(rawValue: 1 << 9)
    public static let canBeAnonymous = IosappChatAdminRightsFlags(rawValue: 1 << 10)
    public static let canManageCalls = IosappChatAdminRightsFlags(rawValue: 1 << 11)
    public static let canManageTopics = IosappChatAdminRightsFlags(rawValue: 1 << 13)
    public static let canPostStories = IosappChatAdminRightsFlags(rawValue: 1 << 14)
    public static let canEditStories = IosappChatAdminRightsFlags(rawValue: 1 << 15)
    public static let canDeleteStories = IosappChatAdminRightsFlags(rawValue: 1 << 16)
    public static let canManageDirect = IosappChatAdminRightsFlags(rawValue: 1 << 17)
    public static let canManageRanks = IosappChatAdminRightsFlags(rawValue: 1 << 18)
    public static let canManageLinkedPeers = IosappChatAdminRightsFlags(rawValue: 1 << 19)
    
    public static var all: IosappChatAdminRightsFlags {
        return [.canChangeInfo, .canPostMessages, .canEditMessages, .canDeleteMessages, .canBanUsers, .canInviteUsers, .canPinMessages, .canAddAdmins, .canBeAnonymous, .canManageCalls, .canManageTopics, .canPostStories, .canEditStories, .canDeleteStories, .canManageRanks, .canManageLinkedPeers]
    }
    
    public static var allChannel: IosappChatAdminRightsFlags {
        return [.canChangeInfo, .canPostMessages, .canEditMessages, .canDeleteMessages, .canBanUsers, .canInviteUsers, .canPinMessages, .canAddAdmins, .canManageCalls, .canManageTopics, .canPostStories, .canEditStories, .canDeleteStories, .canManageDirect]
    }
    
    public static var allCommunity: IosappChatAdminRightsFlags {
        return [.canChangeInfo, .canBanUsers, .canManageLinkedPeers, .canAddAdmins]
    }
    
    public static let internal_groupSpecific: IosappChatAdminRightsFlags = [
        .canChangeInfo,
        .canDeleteMessages,
        .canBanUsers,
        .canInviteUsers,
        .canPinMessages,
        .canManageCalls,
        .canBeAnonymous,
        .canAddAdmins,
        .canPostStories,
        .canEditStories,
        .canDeleteStories,
        .canManageRanks
    ]
    
    public static let internal_broadcastSpecific: IosappChatAdminRightsFlags = [
        .canChangeInfo,
        .canPostMessages,
        .canEditMessages,
        .canDeleteMessages,
        .canManageCalls,
        .canInviteUsers,
        .canAddAdmins,
        .canPostStories,
        .canEditStories,
        .canDeleteStories,
        .canManageDirect,
        .canBanUsers
    ]
    
    public static func peerSpecific(peer: EnginePeer) -> IosappChatAdminRightsFlags {
        if case let .channel(channel) = peer {
            if channel.flags.contains(.isForum) {
                return internal_groupSpecific.union(.canManageTopics)
            } else if case .broadcast = channel.info {
                return internal_broadcastSpecific
            } else {
                return internal_groupSpecific
            }
        } else if case .community = peer {
            return allCommunity
        } else {
            return internal_groupSpecific
        }
    }
    
    public var count: Int {
        var result = 0
        var index = 0
        while index < 31 {
            let currentValue = self.rawValue >> Int32(index)
            index += 1
            if currentValue == 0 {
                break
            }
            
            if (currentValue & 1) != 0 {
                result += 1
            }
        }
        return result
    }
}

public struct IosappChatAdminRights: PostboxCoding, Codable, Equatable {
    public let rights: IosappChatAdminRightsFlags
    
    public init(rights: IosappChatAdminRightsFlags) {
        self.rights = rights
    }
    
    public init(decoder: PostboxDecoder) {
        self.rights = IosappChatAdminRightsFlags(rawValue: decoder.decodeInt32ForKey("f", orElse: 0))
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StringCodingKey.self)
        
        self.rights = IosappChatAdminRightsFlags(rawValue: try container.decode(Int32.self, forKey: "f"))
    }
    
    public func encode(_ encoder: PostboxEncoder) {
        encoder.encodeInt32(self.rights.rawValue, forKey: "f")
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: StringCodingKey.self)
        
        try container.encode(self.rights.rawValue, forKey: "f")
    }
    
    public static func ==(lhs: IosappChatAdminRights, rhs: IosappChatAdminRights) -> Bool {
        return lhs.rights == rhs.rights
    }
    
    public init(flatBuffersObject: IosappCore_IosappChatAdminRights) throws {
        self.rights = IosappChatAdminRightsFlags(rawValue: flatBuffersObject.rights)
    }
    
    public func encodeToFlatBuffers(builder: inout FlatBufferBuilder) -> Offset {
        let start = IosappCore_IosappChatAdminRights.startIosappChatAdminRights(&builder)
        IosappCore_IosappChatAdminRights.add(rights: self.rights.rawValue, &builder)
        return IosappCore_IosappChatAdminRights.endIosappChatAdminRights(&builder, start: start)
    }
}
