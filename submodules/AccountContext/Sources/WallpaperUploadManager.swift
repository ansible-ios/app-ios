import Foundation
import SwiftSignalKit
import IosappCore
import IosappPresentationData

public enum WallpaperUploadManagerStatus {
    case none
    case uploading(IosappWallpaper, Float)
    case uploaded(IosappWallpaper, IosappWallpaper)
    
    public var wallpaper: IosappWallpaper? {
        switch self {
        case let .uploading(wallpaper, _), let .uploaded(wallpaper, _):
            return wallpaper
        default:
            return nil
        }
    }
}

public protocol WallpaperUploadManager: AnyObject {
    func stateSignal() -> Signal<WallpaperUploadManagerStatus, NoError>
    func presentationDataUpdated(_ presentationData: PresentationData)
}
