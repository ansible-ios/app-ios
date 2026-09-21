import Foundation
import Postbox
import FlatBuffers
import FlatSerialization

public enum IosappMediaImageReferenceDecodingError: Error {
    case generic
}

public enum IosappMediaImageReference: PostboxCoding, Equatable {
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    case cloud(imageId: Int64, accessHash: Int64, fileReference: Data?)
    
    public init(decoder: PostboxDecoder) {
        switch decoder.decodeInt32ForKey("_v", orElse: 0) {
            case 0:
                self = .cloud(imageId: decoder.decodeInt64ForKey("i", orElse: 0), accessHash: decoder.decodeInt64ForKey("h", orElse: 0), fileReference: decoder.decodeBytesForKey("fr")?.makeData())
            default:
                self = .cloud(imageId: 0, accessHash: 0, fileReference: nil)
                assertionFailure()
        }
    }
    
    public func encode(_ encoder: PostboxEncoder) {
        switch self {
            case let .cloud(imageId, accessHash, fileReference):
                encoder.encodeInt32(0, forKey: "_v")
                encoder.encodeInt64(imageId, forKey: "i")
                encoder.encodeInt64(accessHash, forKey: "h")
                if let fileReference = fileReference {
                    encoder.encodeBytes(MemoryBuffer(data: fileReference), forKey: "fr")
                } else {
                    encoder.encodeNil(forKey: "fr")
                }
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.decode(Data.self, forKey: .data)
        let postboxDecoder = PostboxDecoder(buffer: MemoryBuffer(data: data))
        guard let object = postboxDecoder.decodeRootObject() as? IosappMediaImageReference else {
            throw IosappMediaImageReferenceDecodingError.generic
        }
        self = object
    }
    
    public func encode(to encoder: Encoder) throws {
        let postboxEncoder = PostboxEncoder()
        postboxEncoder.encodeRootObject(self)
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(postboxEncoder.makeData(), forKey: .data)
    }
    
    public init(flatBuffersObject: IosappCore_IosappMediaImageReference) throws {
        self = .cloud(
            imageId: flatBuffersObject.imageId,
            accessHash: flatBuffersObject.accessHash,
            fileReference: flatBuffersObject.fileReference.isEmpty ? nil : Data(flatBuffersObject.fileReference)
        )
    }
    
    public func encodeToFlatBuffers(builder: inout FlatBufferBuilder) -> Offset {
        switch self {
        case let .cloud(imageId, accessHash, fileReference):
            let fileReferenceOffset = fileReference.flatMap { builder.createVector(bytes: $0) }
            
            let start = IosappCore_IosappMediaImageReference.startIosappMediaImageReference(&builder)
            
            IosappCore_IosappMediaImageReference.add(imageId: imageId, &builder)
            IosappCore_IosappMediaImageReference.add(accessHash: accessHash, &builder)
            if let fileReferenceOffset {
                IosappCore_IosappMediaImageReference.addVectorOf(fileReference: fileReferenceOffset, &builder)
            }
            
            return IosappCore_IosappMediaImageReference.endIosappMediaImageReference(&builder, start: start)
        }
    }
    
    public static func ==(lhs: IosappMediaImageReference, rhs: IosappMediaImageReference) -> Bool {
        switch lhs {
            case let .cloud(imageId, accessHash, fileReference):
                if case .cloud(imageId, accessHash, fileReference) = rhs {
                    return true
                } else {
                    return false
                }
        }
    }
}

public struct IosappMediaImageFlags: OptionSet {
    public var rawValue: Int32
    
    public init(rawValue: Int32) {
        self.rawValue = rawValue
    }
    
    public static let hasStickers = IosappMediaImageFlags(rawValue: 1 << 0)
    public static let isLivePhoto = IosappMediaImageFlags(rawValue: 1 << 1)
}

public enum IosappMediaImageDecodingError: Error {
    case generic
}

public final class IosappMediaImage: Media, Equatable, Codable {
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    public final class VideoRepresentation: Equatable, PostboxCoding {
        public let dimensions: PixelDimensions
        public let resource: IosappMediaResource
        public let startTimestamp: Double?
        
        public init(dimensions: PixelDimensions, resource: IosappMediaResource, startTimestamp: Double?) {
            self.dimensions = dimensions
            self.resource = resource
            self.startTimestamp = startTimestamp
        }
        
        public init(decoder: PostboxDecoder) {
            self.dimensions = PixelDimensions(width: decoder.decodeInt32ForKey("w", orElse: 0), height: decoder.decodeInt32ForKey("h", orElse: 0))
            self.resource = decoder.decodeObjectForKey("r") as! IosappMediaResource
            self.startTimestamp = decoder.decodeOptionalDoubleForKey("s").flatMap({ Double(Float32($0)) })
        }
        
        public func encode(_ encoder: PostboxEncoder) {
            encoder.encodeInt32(self.dimensions.width, forKey: "w")
            encoder.encodeInt32(self.dimensions.height, forKey: "h")
            encoder.encodeObject(self.resource, forKey: "r")
            if let startTimestamp = self.startTimestamp {
                encoder.encodeDouble(startTimestamp, forKey: "s")
            } else {
                encoder.encodeNil(forKey: "s")
            }
        }
        
        public init(flatBuffersObject: IosappCore_VideoRepresentation) throws {
            self.dimensions = PixelDimensions(width: flatBuffersObject.width, height: flatBuffersObject.height)
            self.resource = try IosappMediaResource_parse(flatBuffersObject: flatBuffersObject.resource)
            if flatBuffersObject.startTimestamp != -1.0 {
                self.startTimestamp = Double(flatBuffersObject.startTimestamp)
            } else {
                self.startTimestamp = nil
            }
        }
        
        public func encodeToFlatBuffers(builder: inout FlatBufferBuilder) -> Offset {
            let resourceOffset = IosappMediaResource_serialize(resource: self.resource, flatBuffersBuilder: &builder)!
            
            let start = IosappCore_VideoRepresentation.startVideoRepresentation(&builder)
            
            IosappCore_VideoRepresentation.add(width: self.dimensions.width, &builder)
            IosappCore_VideoRepresentation.add(height: self.dimensions.height, &builder)
            IosappCore_VideoRepresentation.add(resource: resourceOffset, &builder)
            IosappCore_VideoRepresentation.add(startTimestamp: Float32(self.startTimestamp ?? -1.0), &builder)
            
            return IosappCore_VideoRepresentation.endVideoRepresentation(&builder, start: start)
        }
        
        public static func ==(lhs: VideoRepresentation, rhs: VideoRepresentation) -> Bool {
            if lhs === rhs {
                return true
            }
            if lhs.dimensions != rhs.dimensions {
                return false
            }
            if !lhs.resource.isEqual(to: rhs.resource) {
                return false
            }
            if lhs.startTimestamp != rhs.startTimestamp {
                return false
            }
            return true
        }
    }
    
    public final class EmojiMarkup: Equatable, PostboxCoding {
        public enum Content: Equatable {
            case emoji(fileId: Int64)
            case sticker(packReference: StickerPackReference, fileId: Int64)
        }
        public let content: Content
        public let backgroundColors: [Int32]
        
        public init(content: Content, backgroundColors: [Int32]) {
            self.content = content
            self.backgroundColors = backgroundColors
        }
        
        public init(decoder: PostboxDecoder) {
            if let fileId = decoder.decodeOptionalInt64ForKey("f") {
                self.content = .emoji(fileId: fileId)
            } else if let packReference = decoder.decodeObjectForKey("p", decoder: { StickerPackReference(decoder: $0) }) as? StickerPackReference {
                self.content = .sticker(packReference: packReference, fileId: decoder.decodeInt64ForKey("sf", orElse: 0))
            } else {
                fatalError()
            }
            self.backgroundColors = decoder.decodeInt32ArrayForKey("b")
        }
        
        public func encode(_ encoder: PostboxEncoder) {
            switch self.content {
            case let .emoji(fileId):
                encoder.encodeInt64(fileId, forKey: "f")
            case let .sticker(packReference, fileId):
                encoder.encodeObject(packReference, forKey: "p")
                encoder.encodeInt64(fileId, forKey: "sf")
            }
            encoder.encodeInt32Array(self.backgroundColors, forKey: "b")
        }
        
        init(flatBuffersObject: IosappCore_EmojiMarkup) throws {
            switch flatBuffersObject.contentType {
            case .emojimarkupContentEmoji:
                guard let value = flatBuffersObject.content(type: IosappCore_EmojiMarkup_Content_Emoji.self) else {
                    throw FlatBuffersError.missingRequiredField()
                }
                self.content = .emoji(fileId: value.fileId)
            case .emojimarkupContentSticker:
                guard let value = flatBuffersObject.content(type: IosappCore_EmojiMarkup_Content_Sticker.self) else {
                    throw FlatBuffersError.missingRequiredField()
                }
                self.content = .sticker(packReference: try StickerPackReference(flatBuffersObject: value.packReference), fileId: value.fileId)
            case .none_:
                throw FlatBuffersError.missingRequiredField()
            }
            
            self.backgroundColors = flatBuffersObject.backgroundColors
        }
        
        func encodeToFlatBuffers(builder: inout FlatBufferBuilder) -> Offset {
            let contentOffset: Offset
            let contentType: IosappCore_EmojiMarkup_Content
            switch self.content {
            case let .emoji(fileId):
                contentType = .emojimarkupContentEmoji
                let start = IosappCore_EmojiMarkup_Content_Emoji.startEmojiMarkup_Content_Emoji(&builder)
                IosappCore_EmojiMarkup_Content_Emoji.add(fileId: fileId, &builder)
                contentOffset = IosappCore_EmojiMarkup_Content_Emoji.endEmojiMarkup_Content_Emoji(&builder, start: start)
            case let .sticker(packReference, fileId):
                contentType = .emojimarkupContentSticker
                let packReferenceOffset = packReference.encodeToFlatBuffers(builder: &builder)
                let start = IosappCore_EmojiMarkup_Content_Sticker.startEmojiMarkup_Content_Sticker(&builder)
                IosappCore_EmojiMarkup_Content_Sticker.add(packReference: packReferenceOffset, &builder)
                IosappCore_EmojiMarkup_Content_Sticker.add(fileId: fileId, &builder)
                contentOffset = IosappCore_EmojiMarkup_Content_Sticker.endEmojiMarkup_Content_Sticker(&builder, start: start)
            }
            
            let backgroundColorsOffset = builder.createVector(self.backgroundColors)
            
            let start = IosappCore_EmojiMarkup.startEmojiMarkup(&builder)
            IosappCore_EmojiMarkup.add(contentType: contentType, &builder)
            IosappCore_EmojiMarkup.add(content: contentOffset, &builder)
            IosappCore_EmojiMarkup.addVectorOf(backgroundColors: backgroundColorsOffset, &builder)
            return IosappCore_EmojiMarkup.endEmojiMarkup(&builder, start: start)
        }
        
        public static func ==(lhs: EmojiMarkup, rhs: EmojiMarkup) -> Bool {
            if lhs.content != rhs.content {
                return false
            }
            if lhs.backgroundColors != rhs.backgroundColors {
                return false
            }
            return true
        }
    }
    
    
    public let imageId: MediaId
    public let representations: [IosappMediaImageRepresentation]
    public let videoRepresentations: [IosappMediaImage.VideoRepresentation]
    public let immediateThumbnailData: Data?
    public let emojiMarkup: IosappMediaImage.EmojiMarkup?
    public let reference: IosappMediaImageReference?
    public let partialReference: PartialMediaReference?
    public let peerIds: [PeerId] = []
    public let flags: IosappMediaImageFlags
    public let video: IosappMediaFile?
    
    public var id: MediaId? {
        return self.imageId
    }
    
    public init(imageId: MediaId, representations: [IosappMediaImageRepresentation], videoRepresentations: [IosappMediaImage.VideoRepresentation] = [], immediateThumbnailData: Data?, emojiMarkup: IosappMediaImage.EmojiMarkup? = nil, reference: IosappMediaImageReference?, partialReference: PartialMediaReference?, flags: IosappMediaImageFlags, video: IosappMediaFile? = nil) {
        self.imageId = imageId
        self.representations = representations
        self.videoRepresentations = videoRepresentations
        self.immediateThumbnailData = immediateThumbnailData
        self.emojiMarkup = emojiMarkup
        self.reference = reference
        self.partialReference = partialReference
        self.flags = flags
        self.video = video
    }
    
    public init(decoder: PostboxDecoder) {
        self.imageId = MediaId(decoder.decodeBytesForKeyNoCopy("i")!)
        self.representations = decoder.decodeObjectArrayForKey("r")
        self.videoRepresentations = decoder.decodeObjectArrayForKey("vr")
        self.immediateThumbnailData = decoder.decodeDataForKey("itd")
        self.emojiMarkup = decoder.decodeObjectForKey("em", decoder: { IosappMediaImage.EmojiMarkup(decoder: $0) }) as? IosappMediaImage.EmojiMarkup
        self.reference = decoder.decodeObjectForKey("rf", decoder: { IosappMediaImageReference(decoder: $0) }) as? IosappMediaImageReference
        self.partialReference = decoder.decodeAnyObjectForKey("prf", decoder: { PartialMediaReference(decoder: $0) }) as? PartialMediaReference
        self.flags = IosappMediaImageFlags(rawValue: decoder.decodeInt32ForKey("fl", orElse: 0))
        self.video = decoder.decodeObjectForKey("vid", decoder: { IosappMediaFile(decoder: $0) }) as? IosappMediaFile
    }
    
    public func encode(_ encoder: PostboxEncoder) {
        let buffer = WriteBuffer()
        self.imageId.encodeToBuffer(buffer)
        encoder.encodeBytes(buffer, forKey: "i")
        encoder.encodeObjectArray(self.representations, forKey: "r")
        encoder.encodeObjectArray(self.videoRepresentations, forKey: "vr")
        if let immediateThumbnailData = self.immediateThumbnailData {
            encoder.encodeData(immediateThumbnailData, forKey: "itd")
        } else {
            encoder.encodeNil(forKey: "itd")
        }
        if let emojiMarkup = self.emojiMarkup {
            encoder.encodeObject(emojiMarkup, forKey: "em")
        } else {
            encoder.encodeNil(forKey: "em")
        }
        if let reference = self.reference {
            encoder.encodeObject(reference, forKey: "rf")
        } else {
            encoder.encodeNil(forKey: "rf")
        }
        if let partialReference = self.partialReference {
            encoder.encodeObjectWithEncoder(partialReference, encoder: partialReference.encode, forKey: "prf")
        } else {
            encoder.encodeNil(forKey: "prf")
        }
        encoder.encodeInt32(self.flags.rawValue, forKey: "fl")
        if let video = self.video {
            encoder.encodeObject(video, forKey: "vid")
        } else {
            encoder.encodeNil(forKey: "vid")
        }
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.decode(Data.self, forKey: .data)
        let postboxDecoder = PostboxDecoder(buffer: MemoryBuffer(data: data))
        guard let object = postboxDecoder.decodeRootObject() as? IosappMediaImage else {
            throw IosappMediaImageDecodingError.generic
        }
        self.imageId = object.imageId
        self.representations = object.representations
        self.videoRepresentations = object.videoRepresentations
        self.immediateThumbnailData = object.immediateThumbnailData
        self.emojiMarkup = object.emojiMarkup
        self.reference = object.reference
        self.partialReference = object.partialReference
        self.flags = object.flags
        self.video = object.video
    }
    
    public func encode(to encoder: Encoder) throws {
        let postboxEncoder = PostboxEncoder()
        postboxEncoder.encodeRootObject(self)
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(postboxEncoder.makeData(), forKey: .data)
    }
    
    public init(flatBuffersObject: IosappCore_IosappMediaImage) throws {
        self.imageId = MediaId(namespace: flatBuffersObject.imageId.namespace, id: flatBuffersObject.imageId.id)
        self.representations = try (0 ..< flatBuffersObject.representationsCount).map { i in
            return try IosappMediaImageRepresentation(flatBuffersObject: flatBuffersObject.representations(at: i)!)
        }
        self.videoRepresentations = try (0 ..< flatBuffersObject.videoRepresentationsCount).map { i in
            return try IosappMediaImage.VideoRepresentation(flatBuffersObject: flatBuffersObject.videoRepresentations(at: i)!)
        }
        self.immediateThumbnailData = flatBuffersObject.immediateThumbnailData.isEmpty ? nil : Data(flatBuffersObject.immediateThumbnailData)
        self.emojiMarkup = try flatBuffersObject.emojiMarkup.flatMap { try EmojiMarkup(flatBuffersObject: $0) }
        self.reference = try flatBuffersObject.reference.flatMap { try IosappMediaImageReference(flatBuffersObject: $0) }
        self.partialReference = try flatBuffersObject.partialReference.flatMap { try PartialMediaReference(flatBuffersObject: $0) }
        self.flags = IosappMediaImageFlags(rawValue: flatBuffersObject.flags)
        self.video = try flatBuffersObject.video.flatMap { try IosappMediaFile(flatBuffersObject: $0) }
    }
    
    public func encodeToFlatBuffers(builder: inout FlatBufferBuilder) -> Offset {
        let representationsOffsets = self.representations.map { item in
            return item.encodeToFlatBuffers(builder: &builder)
        }
        let representationsOffset = builder.createVector(ofOffsets: representationsOffsets, len: representationsOffsets.count)
        
        let videoRepresentationsOffsets = self.videoRepresentations.map { item in
            return item.encodeToFlatBuffers(builder: &builder)
        }
        let videoRepresentationsOffset = builder.createVector(ofOffsets: videoRepresentationsOffsets, len: videoRepresentationsOffsets.count)
        
        let immediateThumbnailDataOffset = self.immediateThumbnailData.flatMap { builder.createVector(bytes: $0) }
        let emojiMarkupOffset = self.emojiMarkup.flatMap { $0.encodeToFlatBuffers(builder: &builder) }
        let referenceOffset = self.reference.flatMap { $0.encodeToFlatBuffers(builder: &builder) }
        let partialReferenceOffset = self.partialReference.flatMap { $0.encodeToFlatBuffers(builder: &builder) }
        let videoOffset = self.video.flatMap { $0.encodeToFlatBuffers(builder: &builder) }
        
        let start = IosappCore_IosappMediaImage.startIosappMediaImage(&builder)
        
        IosappCore_IosappMediaImage.add(imageId: IosappCore_MediaId(namespace: self.imageId.namespace, id: self.imageId.id), &builder)
        IosappCore_IosappMediaImage.addVectorOf(representations: representationsOffset, &builder)
        IosappCore_IosappMediaImage.addVectorOf(videoRepresentations: videoRepresentationsOffset, &builder)
        if let immediateThumbnailDataOffset {
            IosappCore_IosappMediaImage.addVectorOf(immediateThumbnailData: immediateThumbnailDataOffset, &builder)
        }
        if let emojiMarkupOffset {
            IosappCore_IosappMediaImage.add(emojiMarkup: emojiMarkupOffset, &builder)
        }
        if let referenceOffset {
            IosappCore_IosappMediaImage.add(reference: referenceOffset, &builder)
        }
        if let partialReferenceOffset {
            IosappCore_IosappMediaImage.add(partialReference: partialReferenceOffset, &builder)
        }
        IosappCore_IosappMediaImage.add(flags: self.flags.rawValue, &builder)
        if let videoOffset {
            IosappCore_IosappMediaImage.add(video: videoOffset, &builder)
        }
        
        return IosappCore_IosappMediaImage.endIosappMediaImage(&builder, start: start)
    }
    
    public func representationForDisplayAtSize(_ size: PixelDimensions) -> IosappMediaImageRepresentation? {
        if self.representations.count == 0 {
            return nil
        } else {
            var dimensions = self.representations[0].dimensions
            var index = 0
            
            for i in 0 ..< self.representations.count {
                let representationDimensions = self.representations[i].dimensions
                
                if dimensions.width >= size.width && dimensions.height >= size.height {
                    if representationDimensions.width >= size.width && representationDimensions.height >= dimensions.height && representationDimensions.width < dimensions.width && representationDimensions.height < dimensions.height {
                        dimensions = representationDimensions
                        index = i
                    }
                } else {
                    if representationDimensions.width >= dimensions.width && representationDimensions.height >= dimensions.height {
                        dimensions = representationDimensions
                        index = i
                    }
                }
            }
            
            return self.representations[index]
        }
    }
    
    public func isEqual(to other: Media) -> Bool {
        if let other = other as? IosappMediaImage {
            if other.imageId != self.imageId {
                return false
            }
            if other.representations != self.representations {
                return false
            }
            if other.videoRepresentations != self.videoRepresentations {
                return false
            }
            if other.immediateThumbnailData != self.immediateThumbnailData {
                return false
            }
            if other.emojiMarkup != self.emojiMarkup {
                return false
            }
            if other.partialReference != self.partialReference {
                return false
            }
            if other.flags != self.flags {
                return false
            }
            if other.video != self.video {
                return false
            }
            return true
        }
        return false
    }
    
    public func isSemanticallyEqual(to other: Media) -> Bool {
        if let other = other as? IosappMediaImage {
            if other.imageId != self.imageId {
                return false
            }
            if other.representations.count != self.representations.count {
                return false
            }
            if other.videoRepresentations.count != self.videoRepresentations.count {
                return false
            }
            for i in 0 ..< self.representations.count {
                if !self.representations[i].isSemanticallyEqual(to: other.representations[i]) {
                    return false
                }
            }
            
            if self.partialReference != other.partialReference {
                return false
            }
            if self.flags != other.flags {
                return false
            }
            if self.video != other.video {
                return false
            }
            return true
        }
        return false
    }
    
    public static func ==(lhs: IosappMediaImage, rhs: IosappMediaImage) -> Bool {
        return lhs.isEqual(to: rhs)
    }
    
    public func withUpdatedPartialReference(_ partialReference: PartialMediaReference?) -> IosappMediaImage {
        return IosappMediaImage(imageId: self.imageId, representations: self.representations, videoRepresentations: self.videoRepresentations, immediateThumbnailData: self.immediateThumbnailData, reference: self.reference, partialReference: partialReference, flags: self.flags, video: self.video)
    }
}

public final class IosappMediaImageRepresentation: PostboxCoding, Equatable, CustomStringConvertible {
    public enum TypeHint: Int32 {
        case generic
        case animated
        case video
    }
    
    public let dimensions: PixelDimensions
    public let resource: IosappMediaResource
    public let progressiveSizes: [Int32]
    public let immediateThumbnailData: Data?
    public let hasVideo: Bool
    public let isPersonal: Bool
    public let typeHint: TypeHint
    
    public init(
        dimensions: PixelDimensions,
        resource: IosappMediaResource,
        progressiveSizes: [Int32],
        immediateThumbnailData: Data?,
        hasVideo: Bool = false,
        isPersonal: Bool = false,
        typeHint: TypeHint = .generic
    ) {
        self.dimensions = dimensions
        self.resource = resource
        self.progressiveSizes = progressiveSizes
        self.immediateThumbnailData = immediateThumbnailData
        self.hasVideo = hasVideo
        self.isPersonal = isPersonal
        self.typeHint = typeHint
    }
    
    public init(decoder: PostboxDecoder) {
        self.dimensions = PixelDimensions(width: decoder.decodeInt32ForKey("dx", orElse: 0), height: decoder.decodeInt32ForKey("dy", orElse: 0))
        self.resource = decoder.decodeObjectForKey("r") as? IosappMediaResource ?? EmptyMediaResource()
        self.progressiveSizes = decoder.decodeInt32ArrayForKey("ps")
        self.immediateThumbnailData = decoder.decodeDataForKey("th")
        self.hasVideo = decoder.decodeBoolForKey("hv", orElse: false)
        self.isPersonal = decoder.decodeBoolForKey("ip", orElse: false)
        self.typeHint = TypeHint(rawValue: decoder.decodeInt32ForKey("th", orElse: 0)) ?? .generic
    }
    
    public func encode(_ encoder: PostboxEncoder) {
        encoder.encodeInt32(self.dimensions.width, forKey: "dx")
        encoder.encodeInt32(self.dimensions.height, forKey: "dy")
        encoder.encodeObject(self.resource, forKey: "r")
        encoder.encodeInt32Array(self.progressiveSizes, forKey: "ps")
        if let immediateThumbnailData = self.immediateThumbnailData {
            encoder.encodeData(immediateThumbnailData, forKey: "th")
        } else {
            encoder.encodeNil(forKey: "th")
        }
        encoder.encodeBool(self.hasVideo, forKey: "hv")
        encoder.encodeBool(self.isPersonal, forKey: "ip")
        encoder.encodeInt32(self.typeHint.rawValue, forKey: "th")
    }
    
    public init(flatBuffersObject: IosappCore_IosappMediaImageRepresentation) throws {
        self.dimensions = PixelDimensions(width: flatBuffersObject.width, height: flatBuffersObject.height)
        self.resource = try IosappMediaResource_parse(flatBuffersObject: flatBuffersObject.resource)
        self.progressiveSizes = flatBuffersObject.progressiveSizes
        self.immediateThumbnailData = flatBuffersObject.immediateThumbnailData.isEmpty ? nil : Data(flatBuffersObject.immediateThumbnailData)
        self.hasVideo = flatBuffersObject.hasVideo
        self.isPersonal = flatBuffersObject.isPersonal
        
        switch flatBuffersObject.typeHint {
        case .generic:
            self.typeHint = .generic
        case .animated:
            self.typeHint = .animated
        case .video:
            self.typeHint = .video
        }
    }
    
    func encodeToFlatBuffers(builder: inout FlatBufferBuilder) -> Offset {
        let resourceOffset = IosappMediaResource_serialize(resource: self.resource, flatBuffersBuilder: &builder)!
        let progressiveSizesOffset = builder.createVector(self.progressiveSizes)
        let immediateThumbnailDataOffset = self.immediateThumbnailData.flatMap { builder.createVector(bytes: $0) }
        
        let start = IosappCore_IosappMediaImageRepresentation.startIosappMediaImageRepresentation(&builder)
        
        IosappCore_IosappMediaImageRepresentation.add(width: self.dimensions.width, &builder)
        IosappCore_IosappMediaImageRepresentation.add(height: self.dimensions.height, &builder)
        IosappCore_IosappMediaImageRepresentation.add(resource: resourceOffset, &builder)
        IosappCore_IosappMediaImageRepresentation.addVectorOf(progressiveSizes: progressiveSizesOffset, &builder)
        if let immediateThumbnailDataOffset {
            IosappCore_IosappMediaImageRepresentation.addVectorOf(immediateThumbnailData: immediateThumbnailDataOffset, &builder)
        }
        IosappCore_IosappMediaImageRepresentation.add(hasVideo: self.hasVideo, &builder)
        IosappCore_IosappMediaImageRepresentation.add(isPersonal: self.isPersonal, &builder)
        
        let mappedTypeHint: IosappCore_IosappMediaImageRepresentation_TypeHint
        switch self.typeHint {
        case .generic:
            mappedTypeHint = .generic
        case .animated:
            mappedTypeHint = .animated
        case .video:
            mappedTypeHint = .video
        }
        IosappCore_IosappMediaImageRepresentation.add(typeHint: mappedTypeHint, &builder)
        
        return IosappCore_IosappMediaImageRepresentation.endIosappMediaImageRepresentation(&builder, start: start)
    }
    
    public var description: String {
        return "(\(Int(dimensions.width))x\(Int(dimensions.height)))"
    }
    
    public func isSemanticallyEqual(to other: IosappMediaImageRepresentation) -> Bool {
        if self.dimensions != other.dimensions {
            return false
        }
        if self.resource.id != other.resource.id {
            return false
        }
        if self.progressiveSizes != other.progressiveSizes {
            return false
        }
        if self.immediateThumbnailData != other.immediateThumbnailData {
            return false
        }
        if self.hasVideo != other.hasVideo {
            return false
        }
        if self.isPersonal != other.isPersonal {
            return false
        }
        if self.typeHint != other.typeHint {
            return false
        }
        return true
    }
}

public func ==(lhs: IosappMediaImageRepresentation, rhs: IosappMediaImageRepresentation) -> Bool {
    if lhs.dimensions != rhs.dimensions {
        return false
    }
    if !lhs.resource.isEqual(to: rhs.resource) {
        return false
    }
    return true
}
