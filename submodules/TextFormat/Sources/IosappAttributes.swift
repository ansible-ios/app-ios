import Foundation
import IosappCore

public final class IosappHashtag {
    public let peerName: String?
    public let hashtag: String
    
    public init(peerName: String?, hashtag: String) {
        self.peerName = peerName
        self.hashtag = hashtag
    }
}

public final class IosappPeerMention {
    public let peerId: EnginePeer.Id
    public let mention: String
    
    public init(peerId: EnginePeer.Id, mention: String) {
        self.peerId = peerId
        self.mention = mention
    }
}

public final class IosappTimecode {
    public let time: Double
    public let text: String
    
    public init(time: Double, text: String) {
        self.time = time
        self.text = text
    }
}

public struct IosappTextAttributes {
    public static let URL = "UrlAttributeT"
    public static let PeerMention = "IosappPeerMention"
    public static let PeerTextMention = "IosappPeerTextMention"
    public static let BotCommand = "IosappBotCommand"
    public static let Hashtag = "IosappHashtag"
    public static let BankCard = "IosappBankCard"
    public static let Timecode = "IosappTimecode"
    public static let BlockQuote = "IosappBlockQuote"
    public static let Pre = "IosappPre"
    public static let Spoiler = "IosappSpoiler"
    public static let Code = "IosappCode"
    public static let Button = "IosappButton"
    public static let Date = "IosappDate"
}
