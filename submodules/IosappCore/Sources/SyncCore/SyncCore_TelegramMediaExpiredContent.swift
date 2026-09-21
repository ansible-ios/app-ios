import Foundation
import Postbox

public enum IosappMediaExpiredContentData: Int32 {
    case image
    case file
    case voiceMessage
    case videoMessage
}

public final class IosappMediaExpiredContent: Media, Equatable {
    public let data: IosappMediaExpiredContentData
    
    public let id: MediaId? = nil
    public let peerIds: [PeerId] = []
    
    public init(data: IosappMediaExpiredContentData) {
        self.data = data
    }
    
    public init(decoder: PostboxDecoder) {
        self.data = IosappMediaExpiredContentData(rawValue: decoder.decodeInt32ForKey("d", orElse: 0))!
    }
    
    public func encode(_ encoder: PostboxEncoder) {
        encoder.encodeInt32(self.data.rawValue, forKey: "d")
    }
    
    public static func ==(lhs: IosappMediaExpiredContent, rhs: IosappMediaExpiredContent) -> Bool {
        return lhs.isEqual(to: rhs)
    }
    
    public func isEqual(to other: Media) -> Bool {
        if let other = other as? IosappMediaExpiredContent {
            return self.data == other.data
        } else {
            return false
        }
    }
    
    public func isSemanticallyEqual(to other: Media) -> Bool {
        return self.isEqual(to: other)
    }
}
