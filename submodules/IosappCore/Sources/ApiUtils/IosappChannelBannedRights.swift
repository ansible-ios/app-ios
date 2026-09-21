import Foundation
import Postbox
import IosappApi

extension IosappChatBannedRights {
    init(apiBannedRights: Api.ChatBannedRights) {
        switch apiBannedRights {
            case let .chatBannedRights(chatBannedRightsData):
                let (flags, untilDate) = (chatBannedRightsData.flags, chatBannedRightsData.untilDate)
                var effectiveFlags = IosappChatBannedRightsFlags(rawValue: flags)
                effectiveFlags.remove(.banSendMedia)
                effectiveFlags.remove(IosappChatBannedRightsFlags(rawValue: 1 << 1))
                self.init(flags: effectiveFlags, untilDate: untilDate)
        }
    }
    
    var apiBannedRights: Api.ChatBannedRights {
        var effectiveFlags = self.flags
        effectiveFlags.remove(.banSendMedia)
        effectiveFlags.remove(IosappChatBannedRightsFlags(rawValue: 1 << 1))
        
        return .chatBannedRights(.init(flags: effectiveFlags.rawValue, untilDate: self.untilDate))
    }
}
