import Foundation
import Postbox
import SwiftSignalKit

public func updateNetworkEngineSettings(accountManager: AccountManager<IosappAccountManagerTypes>, _ f: @escaping (NetworkEngineSettings) -> NetworkEngineSettings) -> Signal<Void, NoError> {
    return accountManager.transaction { transaction -> Void in
        transaction.updateSharedData(SharedDataKeys.networkEngineSettings, { current in
            let previous = current?.get(NetworkEngineSettings.self) ?? NetworkEngineSettings.defaultSettings
            return PreferencesEntry(f(previous))
        })
    }
}
