import SwiftSignalKit
import Postbox

public extension IosappEngine.EngineData.Item {
    enum Notices {
        public struct Notice: IosappEngineDataItem, PostboxViewDataItem {
            public typealias Result = CodableEntry?
            
            private let entryKey: NoticeEntryKey

            public init(key: NoticeEntryKey) {
                self.entryKey = key
            }

            var key: PostboxViewKey {
                return .notice(key: self.entryKey)
            }

            func extract(view: PostboxView) -> Result {
                guard let view = view as? LocalNoticeEntryView else {
                    preconditionFailure()
                }
                return view.value
            }
        }
    }
}
