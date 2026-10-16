import Foundation
import Metal

private final class IosappCallsUIMetalLibraryBundleMarker: NSObject {
}

private let metalLibraryLock = NSLock()
private var metalLibraryValue: (device: MTLDevice, library: MTLLibrary)?

/// The module's shaders (`Resources/*.metal`), compiled at build time into IosappCallsUIBundle's default.metallib.
/// Safe to call from any thread.
func telegramCallsUIMetalLibrary(device: MTLDevice) -> MTLLibrary? {
    metalLibraryLock.lock()
    defer {
        metalLibraryLock.unlock()
    }

    if let metalLibraryValue, metalLibraryValue.device === device {
        return metalLibraryValue.library
    }
    let mainBundle = Bundle(for: IosappCallsUIMetalLibraryBundleMarker.self)
    guard let path = mainBundle.path(forResource: "IosappCallsUIBundle", ofType: "bundle"), let bundle = Bundle(path: path) else {
        return nil
    }
    guard let library = try? device.makeDefaultLibrary(bundle: bundle) else {
        return nil
    }
    metalLibraryValue = (device, library)
    return library
}
