import Foundation
import FlatBuffers
import FlatSerialization
import Postbox

public func IosappMedia_parse(flatBuffersObject: IosappCore_Media) throws -> Media {
    //TODO:release support other media types
    switch flatBuffersObject.valueType {
    case .mediaIosappmediafile:
        guard let value = flatBuffersObject.value(type: IosappCore_Media_IosappMediaFile.self) else {
            throw FlatBuffersError.missingRequiredField()
        }
        return try IosappMediaFile(flatBuffersObject: value.file)
    case .mediaIosappmediaimage:
        guard let value = flatBuffersObject.value(type: IosappCore_Media_IosappMediaImage.self) else {
            throw FlatBuffersError.missingRequiredField()
        }
        return try IosappMediaImage(flatBuffersObject: value.image)
    case .none_:
        throw FlatBuffersError.missingRequiredField()
    }
}

public func IosappMedia_serialize(media: Media, flatBuffersBuilder builder: inout FlatBufferBuilder) -> Offset? {
    //TODO:release support other media types
    switch media {
    case let file as IosappMediaFile:
        let fileOffset = file.encodeToFlatBuffers(builder: &builder)
        let start = IosappCore_Media_IosappMediaFile.startMedia_IosappMediaFile(&builder)
        IosappCore_Media_IosappMediaFile.add(file: fileOffset, &builder)
        let offset = IosappCore_Media_IosappMediaFile.endMedia_IosappMediaFile(&builder, start: start)
        return IosappCore_Media.createMedia(&builder, valueType: .mediaIosappmediafile, valueOffset: offset)
    case let image as IosappMediaImage:
        let imageOffset = image.encodeToFlatBuffers(builder: &builder)
        let start = IosappCore_Media_IosappMediaImage.startMedia_IosappMediaImage(&builder)
        IosappCore_Media_IosappMediaImage.add(image: imageOffset, &builder)
        let offset = IosappCore_Media_IosappMediaImage.endMedia_IosappMediaImage(&builder, start: start)
        return IosappCore_Media.createMedia(&builder, valueType: .mediaIosappmediaimage, valueOffset: offset)
    default:
        assert(false)
        return nil
    }
}

public enum IosappMedia {
    public struct Accessor {
        let _wrappedMedia: Media?
        let _wrapped: IosappCore_Media?
        
        public init(_ wrapped: IosappCore_Media) {
            self._wrapped = wrapped
            self._wrappedMedia = nil
        }
        
        public init(_ wrapped: Media) {
            self._wrapped = nil
            self._wrappedMedia = wrapped
        }
        
        public func _parse() -> Media {
            if let _wrappedMedia = self._wrappedMedia {
                return _wrappedMedia
            } else {
                return try! IosappMedia_parse(flatBuffersObject: self._wrapped!)
            }
        }
    }
}

public extension IosappMedia.Accessor {
    var id: MediaId? {
        //TODO:release support other media types
        if let _wrappedMedia = self._wrappedMedia {
            return _wrappedMedia.id
        }
        
        switch self._wrapped!.valueType {
        case .mediaIosappmediafile:
            guard let value = self._wrapped!.value(type: IosappCore_Media_IosappMediaFile.self) else {
                return nil
            }
            return MediaId(value.file.fileId)
        case .mediaIosappmediaimage:
            guard let value = self._wrapped!.value(type: IosappCore_Media_IosappMediaImage.self) else {
                return nil
            }
            return MediaId(value.image.imageId)
        case .none_:
            return nil
        }
    }
}
