import Foundation
import Postbox
import SwiftSignalKit
internal import IosappApi
import MtProtoKit
import EncryptionProvider

/// Stars and TON balances, the wallet, stars revenue, the paid-reaction default privacy, gift auctions and the emoji
/// game.
extension ReplayContext {
    func applyUpdateStarsBalance(_ peerId: PeerId, _ currency: CurrencyAmount.Currency, _ balance: StarsAmount) {
        switch currency {
        case .ton:
            updatedTonBalance[peerId] = balance
        case .stars:
            updatedDiamondsBalance[peerId] = balance
        }
    }
    
    func applyUpdateWalletTransfer(_ update: Api.Update) {
        walletTransferApiUpdates.append(update)
    }
    
    func applyUpdateWalletState(_ state: Api.WalletState) {
        updatedWalletState = state
    }

    func applyUpdateAgentSettings(_ settings: EngineAgentSettings) {
        updatedAgentSettings = settings
    }
    
    func applyUpdateStarsRevenueStatus(_ peerId: PeerId, _ status: StarsRevenueStats.Balances) {
        updatedDiamondsRevenueStatus[peerId] = status
    }
    
    func applyUpdateStarsReactionsDefaultPrivacy(_ value: IosappPaidReactionPrivacy) {
        updatedStarsReactionsDefaultPrivacy = value
    }
    
    func applyUpdateStarGiftAuctionState(_ giftId: Int64, _ state: GiftAuctionContext.State.AuctionState) {
        updatedDiamondGiftAuctionState[giftId] = state
    }
    
    func applyUpdateStarGiftAuctionMyState(_ giftId: Int64, _ state: GiftAuctionContext.State.MyState) {
        updatedDiamondGiftAuctionMyState[giftId] = state
    }
    
    func applyUpdateEmojiGameInfo(_ info: EmojiGameInfo) {
        updatedEmojiGameInfo = info
    }
}
