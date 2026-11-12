import Foundation
import UIKit
import SwiftSignalKit
import IosappCore
import AccountContext
import Photos
import MediaEditor
import MediaAssetsContext
import Display
import LegacyComponents
import ImageCompression

public let passportAssetImageTargetSize = CGSize(width: 2048.0, height: 2048.0)

public enum PassportImageSource {
    case asset(identifier: String)
    case imageFile(path: String, dimensions: PixelDimensions)
}

public struct PassportImageItem {
    public let uniqueId: String
    public let source: PassportImageSource
    public let values: MediaEditorValues?

    public init(uniqueId: String, source: PassportImageSource, values: MediaEditorValues?) {
        self.uniqueId = uniqueId
        self.source = source
        self.values = values
    }
}

public func passportFittedImage(_ image: UIImage) -> UIImage {
    let pixelSize = CGSize(width: image.size.width * image.scale, height: image.size.height * image.scale)
    let targetSize = passportOutputImageSize(pixelSize)
    if image.imageOrientation == .up && image.scale == 1.0 && targetSize == pixelSize {
        return image
    }
    let format = UIGraphicsImageRendererFormat()
    format.scale = 1.0
    format.opaque = true
    return UIGraphicsImageRenderer(size: targetSize, format: format).image { _ in
        image.draw(in: CGRect(origin: .zero, size: targetSize))
    }
}

private func passportSourceImage(_ source: PassportImageSource) -> Signal<UIImage?, NoError> {
    switch source {
    case let .asset(identifier):
        guard let asset = PHAsset.fetchAssets(withLocalIdentifiers: [identifier], options: nil).firstObject else {
            return .single(nil)
        }
        return chatMediaSendFirstResultImage(assetFullImage(asset, targetSize: passportAssetImageTargetSize, contentMode: .aspectFit)
        |> map { result -> ChatMediaSendRenderEvent in
            switch result {
            case let .progress(progress):
                return .progress(progress)
            case let .result(image):
                return .result(image)
            case .unavailable:
                return .result(nil)
            }
        })
    case let .imageFile(path, _):
        return chatMediaSendFirstResultImage(chatMediaSendFileImage(path: path))
    }
}

public func passportAttachmentResource(image: UIImage) -> IosappMediaResource? {
    let randomId = Int64.random(in: Int64.min ... Int64.max)
    let tempFilePath = NSTemporaryDirectory() + "\(randomId).jpeg"
    let scaledSize = image.size.aspectFitted(CGSize(width: 2048.0, height: 2048.0))
    let tempFile = EngineTempBox.shared.tempFile(fileName: "file")
    defer {
        EngineTempBox.shared.dispose(tempFile)
    }
    guard let scaledImage = TGScaleImageToPixelSize(image, scaledSize), let scaledImageData = compressImageToJPEG(scaledImage, quality: Float(passportImageCompressionQuality), tempFilePath: tempFile.path) else {
        return nil
    }
    let _ = try? scaledImageData.write(to: URL(fileURLWithPath: tempFilePath))
    return LocalFileReferenceMediaResource(localFilePath: tempFilePath, randomId: randomId)
}

public func passportFittedImageResource(_ image: UIImage) -> Signal<IosappMediaResource?, NoError> {
    return Signal<IosappMediaResource?, NoError> { subscriber in
        subscriber.putNext(passportAttachmentResource(image: passportFittedImage(image)))
        subscriber.putCompletion()
        return EmptyDisposable
    }
    |> runOn(Queue.concurrentDefaultQueue())
}

private func passportRenderedResource(renderer: ChatMediaSendRendering, item: PassportImageItem) -> Signal<IosappMediaResource?, NoError> {
    let image: Signal<UIImage?, NoError>
    if let values = item.values {
        let source: ChatMediaSendItem.Source
        switch item.source {
        case let .asset(identifier):
            source = .libraryAsset(identifier: identifier, pixelSize: values.originalDimensions.cgSize, isVideo: false, duration: 0.0)
        case let .imageFile(path, dimensions):
            source = .imageFile(path: path, dimensions: dimensions)
        }
        let sendItem = ChatMediaSendItem(uniqueId: item.uniqueId, source: source, values: values, options: ChatMediaSendItemOptions())
        image = chatMediaSendFirstResultImage(renderer.renderPhoto(item: sendItem, forceHd: true))
    } else {
        image = passportSourceImage(item.source)
    }
    return image
    |> take(1)
    |> mapToSignal { image -> Signal<IosappMediaResource?, NoError> in
        guard let image else {
            return .single(nil)
        }
        return passportFittedImageResource(image)
    }
}

public func passportRenderedResources(renderer: ChatMediaSendRendering, items: [PassportImageItem]) -> Signal<[IosappMediaResource], NoError> {
    guard !items.isEmpty else {
        return .single([])
    }
    var result: Signal<[IosappMediaResource], NoError> = .single([])
    for item in items {
        result = result
        |> mapToSignal { resources -> Signal<[IosappMediaResource], NoError> in
            return passportRenderedResource(renderer: renderer, item: item)
            |> take(1)
            |> map { resource -> [IosappMediaResource] in
                guard let resource else {
                    return resources
                }
                return resources + [resource]
            }
        }
    }
    return result
    |> take(1)
}

public func passportRenderedResources(context: AccountContext, items: [PassportImageItem]) -> Signal<[IosappMediaResource], NoError> {
    return passportRenderedResources(renderer: ChatMediaSendDefaultRenderer(context: context), items: items)
}
