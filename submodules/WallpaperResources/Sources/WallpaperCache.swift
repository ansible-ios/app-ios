import Foundation
import UIKit
import SwiftSignalKit
import IosappApi
import IosappCore
import IosappUIPreferences
import PersistentStringHash

public final class CachedWallpaper: Codable {
    public let wallpaper: IosappWallpaper
    
    public init(wallpaper: IosappWallpaper) {
        self.wallpaper = wallpaper
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StringCodingKey.self)

        self.wallpaper = (try container.decode(IosappWallpaperNativeCodable.self, forKey: "wallpaper")).value
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: StringCodingKey.self)

        try container.encode(IosappWallpaperNativeCodable(self.wallpaper), forKey: "wallpaper")
    }
}

public func cachedWallpaper(engine: IosappEngine, network: Network, slug: String, settings: WallpaperSettings?, update: Bool = false) -> Signal<CachedWallpaper?, NoError> {
    let slugKey = EngineDataBuffer(length: 8)
    slugKey.setInt64(0, value: Int64(bitPattern: slug.persistentHashValue))
    return engine.data.get(IosappEngine.EngineData.Item.ItemCache.Item(collectionId: ApplicationSpecificItemCacheCollectionId.cachedWallpapers, id: slugKey))
    |> mapToSignal { entry -> Signal<CachedWallpaper?, NoError> in
        if !update, let entry = entry?.get(CachedWallpaper.self) {
            if let settings = settings {
                return .single(CachedWallpaper(wallpaper: entry.wallpaper.withUpdatedSettings(settings)))
            } else {
                return .single(entry)
            }
        } else {
            return getWallpaper(network: network, slug: slug)
            |> map(Optional.init)
            |> `catch` { _ -> Signal<IosappWallpaper?, NoError> in
                return .single(nil)
            }
            |> mapToSignal { wallpaper -> Signal<CachedWallpaper?, NoError> in
                let slugKey = EngineDataBuffer(length: 8)
                slugKey.setInt64(0, value: Int64(bitPattern: slug.persistentHashValue))
                
                if var wallpaper = wallpaper {
                    switch wallpaper {
                    case let .file(file):
                        wallpaper = .file(IosappWallpaper.File(id: file.id, accessHash: file.accessHash, isCreator: file.isCreator, isDefault: file.isDefault, isPattern: file.isPattern, isDark: file.isDark, slug: file.slug, file: file.file.withUpdatedResource(WallpaperDataResource(slug: slug)), settings: file.settings))
                    default:
                        break
                    }
                    
                    let result: CachedWallpaper
                    if let settings = settings {
                        result = CachedWallpaper(wallpaper: wallpaper.withUpdatedSettings(settings))
                    } else {
                        result = CachedWallpaper(wallpaper: wallpaper)
                    }
                    return engine.itemCache.put(collectionId: ApplicationSpecificItemCacheCollectionId.cachedWallpapers, id: slugKey, item: CachedWallpaper(wallpaper: wallpaper))
                    |> map { _ -> CachedWallpaper? in }
                    |> then(.single(result))
                } else {
                    return engine.itemCache.remove(collectionId: ApplicationSpecificItemCacheCollectionId.cachedWallpapers, id: slugKey)
                    |> map { _ -> CachedWallpaper? in }
                    |> then(.single(nil))
                }
            }
        }
    }
}

public func updateCachedWallpaper(engine: IosappEngine, wallpaper: IosappWallpaper) {
    guard case let .file(file) = wallpaper, file.id != 0 else {
        return
    }
    let key = EngineDataBuffer(length: 8)
    key.setInt64(0, value: Int64(bitPattern: file.slug.persistentHashValue))
    
    let _ = engine.itemCache.put(collectionId: ApplicationSpecificItemCacheCollectionId.cachedWallpapers, id: key, item: CachedWallpaper(wallpaper: wallpaper)).start()
}
