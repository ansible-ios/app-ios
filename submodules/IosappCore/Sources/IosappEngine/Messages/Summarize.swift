import Foundation
import Postbox
import SwiftSignalKit
internal import IosappApi
import MtProtoKit

public enum SummarizeError {
    case generic
    case invalidMessageId
    case limitExceeded
    case invalidLanguage
    case limitExceededPremium
}

func _internal_summarizeMessage(account: Account, messageId: EngineMessage.Id, translateToLang: String?) -> Signal<Never, SummarizeError> {
    return .fail(.generic)
}
