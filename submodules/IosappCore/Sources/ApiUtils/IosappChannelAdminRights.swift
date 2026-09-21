import Foundation
import Postbox
import IosappApi


extension IosappChatAdminRights {
    init?(apiAdminRights: Api.ChatAdminRights) {
        switch apiAdminRights {
            case let .chatAdminRights(chatAdminRightsData):
                let flags = chatAdminRightsData.flags
                if flags == 0 {
                    return nil
                }
                let filteredFlags = flags & (~(1 << 12))
                self.init(rights: IosappChatAdminRightsFlags(rawValue: filteredFlags))
        }
    }
    
    var apiAdminRights: Api.ChatAdminRights {
        var filteredFlags = self.rights.rawValue
        filteredFlags |= 1 << 12
        return .chatAdminRights(Api.ChatAdminRights.Cons_chatAdminRights(flags: filteredFlags))
    }
}
