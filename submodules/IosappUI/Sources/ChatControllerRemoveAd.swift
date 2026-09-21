import Foundation
import IosappPresentationData
import AccountContext
import IosappCore
import SwiftSignalKit
import Display
import IosappPresentationData
import PresentationDataUtils
import ChatMessageItemView

public extension ChatControllerImpl {
    func removeAd(opaqueId: Data) {
        var foundItemNode: ChatMessageItemView?
        self.chatDisplayNode.historyNode.forEachItemNode { itemNode in
            if let itemNode = itemNode as? ChatMessageItemView, let item = itemNode.item, let adAttribute = item.message.adAttribute, adAttribute.opaqueId == opaqueId {
                foundItemNode = itemNode
            }
        }
        if let foundItemNode, let message = foundItemNode.item?.message {
            self.chatDisplayNode.historyNode.setCurrentDeleteAnimationCorrelationIds(Set([message.stableId]))
        }
        self.chatDisplayNode.adMessagesContext?.remove(opaqueId: opaqueId)
    }
}
