import Foundation
import Postbox

public final class IosappMediaPaidContent: Media, Equatable {
    public var peerIds: [PeerId] = []

    public var id: MediaId? {
        return nil
    }

    public let amount: Int64
    public let extendedMedia: [IosappExtendedMedia]
        
    public init(amount: Int64, extendedMedia: [IosappExtendedMedia]) {
        self.amount = amount
        self.extendedMedia = extendedMedia
    }
    
    public init(decoder: PostboxDecoder) {
        self.amount = decoder.decodeInt64ForKey("a", orElse: 0)
        self.extendedMedia = (try? decoder.decodeObjectArrayWithCustomDecoderForKey("m", decoder: { IosappExtendedMedia(decoder: $0) })) ?? []
    }
    
    public func encode(_ encoder: PostboxEncoder) {
        encoder.encodeInt64(self.amount, forKey: "a")
        encoder.encodeObjectArray(self.extendedMedia, forKey: "m")
    }
    
    public static func ==(lhs: IosappMediaPaidContent, rhs: IosappMediaPaidContent) -> Bool {
        return lhs.isEqual(to: rhs)
    }
    
    public func isEqual(to other: Media) -> Bool {
        guard let other = other as? IosappMediaPaidContent else {
            return false
        }
        
        if self.amount != other.amount {
            return false
        }
        
        if self.extendedMedia != other.extendedMedia {
            return false
        }
        
        return true
    }
    
    public func isSemanticallyEqual(to other: Media) -> Bool {
        return self.isEqual(to: other)
    }
    
    public func withUpdatedExtendedMedia(_ extendedMedia: [IosappExtendedMedia]) -> IosappMediaPaidContent {
        return IosappMediaPaidContent(
            amount: self.amount,
            extendedMedia: extendedMedia
        )
    }
}
