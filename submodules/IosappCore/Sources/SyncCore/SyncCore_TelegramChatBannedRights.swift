import Postbox
import FlatBuffers
import FlatSerialization

public struct IosappChatBannedRightsFlags: OptionSet, Hashable {
    public var rawValue: Int32
    
    public init(rawValue: Int32) {
        self.rawValue = rawValue
    }
    
    public init() {
        self.rawValue = 0
    }
    
    public static let banReadMessages = IosappChatBannedRightsFlags(rawValue: 1 << 0)
    public static let banSendMedia = IosappChatBannedRightsFlags(rawValue: 1 << 2)
    public static let banSendStickers = IosappChatBannedRightsFlags(rawValue: 1 << 3)
    public static let banSendGifs = IosappChatBannedRightsFlags(rawValue: 1 << 4)
    public static let banSendGames = IosappChatBannedRightsFlags(rawValue: 1 << 5)
    public static let banSendInline = IosappChatBannedRightsFlags(rawValue: 1 << 6)
    public static let banEmbedLinks = IosappChatBannedRightsFlags(rawValue: 1 << 7)
    public static let banSendPolls = IosappChatBannedRightsFlags(rawValue: 1 << 8)
    public static let banChangeInfo = IosappChatBannedRightsFlags(rawValue: 1 << 10)
    public static let banAddMembers = IosappChatBannedRightsFlags(rawValue: 1 << 15)
    public static let banPinMessages = IosappChatBannedRightsFlags(rawValue: 1 << 17)
    public static let banManageTopics = IosappChatBannedRightsFlags(rawValue: 1 << 18)
    public static let banSendPhotos = IosappChatBannedRightsFlags(rawValue: 1 << 19)
    public static let banSendVideos = IosappChatBannedRightsFlags(rawValue: 1 << 20)
    public static let banSendInstantVideos = IosappChatBannedRightsFlags(rawValue: 1 << 21)
    public static let banSendMusic = IosappChatBannedRightsFlags(rawValue: 1 << 22)
    public static let banSendVoice = IosappChatBannedRightsFlags(rawValue: 1 << 23)
    public static let banSendFiles = IosappChatBannedRightsFlags(rawValue: 1 << 24)
    public static let banSendText = IosappChatBannedRightsFlags(rawValue: 1 << 25)
    public static let banSendReactions = IosappChatBannedRightsFlags(rawValue: 1 << 27)
    public static let banEditRank = IosappChatBannedRightsFlags(rawValue: 1 << 26)
    public static let banManageLinkedPeers = IosappChatBannedRightsFlags(rawValue: 1 << 28)
}

public struct IosappChatBannedRights: PostboxCoding, Equatable {
    public let flags: IosappChatBannedRightsFlags
    public let untilDate: Int32
    
    public init(flags: IosappChatBannedRightsFlags, untilDate: Int32) {
        self.flags = flags
        self.untilDate = untilDate
    }
    
    public init(decoder: PostboxDecoder) {
        self.flags = IosappChatBannedRightsFlags(rawValue: decoder.decodeInt32ForKey("f", orElse: 0))
        self.untilDate = decoder.decodeInt32ForKey("d", orElse: 0)
    }
    
    public func encode(_ encoder: PostboxEncoder) {
        encoder.encodeInt32(self.flags.rawValue, forKey: "f")
        encoder.encodeInt32(self.untilDate, forKey: "d")
    }
    
    public static func ==(lhs: IosappChatBannedRights, rhs: IosappChatBannedRights) -> Bool {
        return lhs.flags == rhs.flags && lhs.untilDate == rhs.untilDate
    }
    
    public init(flatBuffersObject: IosappCore_IosappChatBannedRights) throws {
        self.flags = IosappChatBannedRightsFlags(rawValue: flatBuffersObject.flags)
        self.untilDate = flatBuffersObject.untilDate
    }
    
    public func encodeToFlatBuffers(builder: inout FlatBufferBuilder) -> Offset {
        let start = IosappCore_IosappChatBannedRights.startIosappChatBannedRights(&builder)
        IosappCore_IosappChatBannedRights.add(flags: self.flags.rawValue, &builder)
        IosappCore_IosappChatBannedRights.add(untilDate: self.untilDate, &builder)
        return IosappCore_IosappChatBannedRights.endIosappChatBannedRights(&builder, start: start)
    }
}
