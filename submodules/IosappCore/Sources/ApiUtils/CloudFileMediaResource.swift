import Foundation
import Postbox
import IosappApi


protocol IosappCloudMediaResource: IosappMediaResource {
    func apiInputLocation(fileReference: Data?) -> Api.InputFileLocation?
}

public func extractMediaResourceDebugInfo(resource: MediaResource) -> String? {
    if let resource = resource as? IosappCloudMediaResource {
        guard let inputLocation = resource.apiInputLocation(fileReference: nil) else {
            return nil
        }
        return String(describing: inputLocation)
    } else {
        return nil
    }
}

public protocol IosappMultipartFetchableResource: IosappMediaResource {
    var datacenterId: Int { get }
}

public protocol IosappCloudMediaResourceWithFileReference {
    var fileReference: Data? { get }
}

extension CloudFileMediaResource: IosappCloudMediaResource, IosappMultipartFetchableResource, IosappCloudMediaResourceWithFileReference {
    func apiInputLocation(fileReference: Data?) -> Api.InputFileLocation? {
        return Api.InputFileLocation.inputFileLocation(.init(volumeId: self.volumeId, localId: self.localId, secret: self.secret, fileReference: Buffer(data: fileReference ?? Data())))
    }
}

extension CloudPhotoSizeMediaResource: IosappCloudMediaResource, IosappMultipartFetchableResource, IosappCloudMediaResourceWithFileReference {
    func apiInputLocation(fileReference: Data?) -> Api.InputFileLocation? {
        return Api.InputFileLocation.inputPhotoFileLocation(.init(id: self.photoId, accessHash: self.accessHash, fileReference: Buffer(data: fileReference ?? Data()), thumbSize: self.sizeSpec))
    }
}

extension CloudDocumentSizeMediaResource: IosappCloudMediaResource, IosappMultipartFetchableResource, IosappCloudMediaResourceWithFileReference {
    func apiInputLocation(fileReference: Data?) -> Api.InputFileLocation? {
        return Api.InputFileLocation.inputDocumentFileLocation(.init(id: self.documentId, accessHash: self.accessHash, fileReference: Buffer(data: fileReference ?? Data()), thumbSize: self.sizeSpec))
    }
}

extension CloudPeerPhotoSizeMediaResource: IosappMultipartFetchableResource {
    func apiInputLocation(peerReference: PeerReference) -> Api.InputFileLocation? {
        let flags: Int32
        switch self.sizeSpec {
            case .small:
                flags = 0
            case .fullSize:
                flags = 1 << 0
        }
        if let photoId = self.photoId {
            return Api.InputFileLocation.inputPeerPhotoFileLocation(.init(flags: flags, peer: peerReference.inputPeer, photoId: photoId))
        } else {
            return nil
        }
    }
}

extension CloudStickerPackThumbnailMediaResource: IosappMultipartFetchableResource {
    func apiInputLocation(packReference: StickerPackReference) -> Api.InputFileLocation? {
        if let thumbVersion = self.thumbVersion {
            return Api.InputFileLocation.inputStickerSetThumb(.init(stickerset: packReference.apiInputStickerSet, thumbVersion: thumbVersion))
        } else {
            return nil
        }
    }
}

extension CloudDocumentMediaResource: IosappCloudMediaResource, IosappMultipartFetchableResource, IosappCloudMediaResourceWithFileReference {
    func apiInputLocation(fileReference: Data?) -> Api.InputFileLocation? {
        return Api.InputFileLocation.inputDocumentFileLocation(.init(id: self.fileId, accessHash: self.accessHash, fileReference: Buffer(data: fileReference ?? Data()), thumbSize: ""))
    }
}

extension SecretFileMediaResource: IosappCloudMediaResource, IosappMultipartFetchableResource {
    func apiInputLocation(fileReference: Data?) -> Api.InputFileLocation? {
        return .inputEncryptedFileLocation(.init(id: self.fileId, accessHash: self.accessHash))
    }
}
