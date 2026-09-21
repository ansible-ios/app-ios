import Foundation
import IosappCore

struct ChatSearchState: Equatable {
    let query: String
    let location: SearchMessagesLocation
    let loadMoreState: SearchMessagesState?
}
