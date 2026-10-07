import Foundation
import SwiftSignalKit
import Postbox

public extension IosappEngine {
    final class Payments {
        private let account: Account
        
        init(account: Account) {
            self.account = account
        }
        
        public func getBankCardInfo(cardNumber: String) -> Signal<BankCardInfo?, NoError> {
            return _internal_getBankCardInfo(account: self.account, cardNumber: cardNumber)
        }
        
        public func fetchBotPaymentInvoice(source: BotPaymentInvoiceSource) -> Signal<IosappMediaInvoice, BotPaymentFormRequestError> {
            return _internal_fetchBotPaymentInvoice(postbox: self.account.postbox, network: self.account.network, source: source)
        }
        
        public func fetchBotPaymentForm(source: BotPaymentInvoiceSource, themeParams: [String: Any]?) -> Signal<BotPaymentForm, BotPaymentFormRequestError> {
            return _internal_fetchBotPaymentForm(accountPeerId: self.account.peerId, postbox: self.account.postbox, network: self.account.network, source: source, themeParams: themeParams)
        }
        
        public func validateBotPaymentForm(saveInfo: Bool, source: BotPaymentInvoiceSource, formInfo: BotPaymentRequestedInfo) -> Signal<BotPaymentValidatedFormInfo, ValidateBotPaymentFormError> {
            return _internal_validateBotPaymentForm(account: self.account, saveInfo: saveInfo, source: source, formInfo: formInfo)
        }
        
        public func sendBotPaymentForm(source: BotPaymentInvoiceSource, formId: Int64, validatedInfoId: String?, shippingOptionId: String?, tipAmount: Int64?, credentials: BotPaymentCredentials) -> Signal<SendBotPaymentResult, SendBotPaymentFormError> {
            return _internal_sendBotPaymentForm(account: self.account, formId: formId, source: source, validatedInfoId: validatedInfoId, shippingOptionId: shippingOptionId, tipAmount: tipAmount, credentials: credentials)
        }
        
        public func requestBotPaymentReceipt(messageId: MessageId) -> Signal<BotPaymentReceipt, RequestBotPaymentReceiptError> {
            return _internal_requestBotPaymentReceipt(account: self.account, messageId: messageId)
        }
        
        public func clearBotPaymentInfo(info: BotPaymentInfo) -> Signal<Void, NoError> {
            return _internal_clearBotPaymentInfo(network: self.account.network, info: info)
        }
        
        public func sendAppStoreReceipt(receipt: Data, purpose: AppStoreTransactionPurpose) -> Signal<Never, AssignAppStoreTransactionError> {
            return _internal_sendAppStoreReceipt(postbox: self.account.postbox, network: self.account.network, stateManager: self.account.stateManager, receipt: receipt, purpose: purpose)
        }
        
        public func canPurchasePremium(purpose: AppStoreTransactionPurpose) -> Signal<Bool, NoError> {
            return _internal_canPurchasePremium(postbox: self.account.postbox, network: self.account.network, purpose: purpose)
        }
        
        public func checkPremiumGiftCode(slug: String) -> Signal<PremiumGiftCodeInfo?, NoError> {
            return _internal_checkPremiumGiftCode(account: self.account, slug: slug)
        }
        
        public func applyPremiumGiftCode(slug: String) -> Signal<Never, ApplyPremiumGiftCodeError> {
            return _internal_applyPremiumGiftCode(account: self.account, slug: slug)
        }
        
        public func premiumGiftCodeOptions(peerId: EnginePeer.Id?, onlyCached: Bool = false) -> Signal<[PremiumGiftCodeOption], NoError> {
            return _internal_premiumGiftCodeOptions(account: self.account, peerId: peerId, onlyCached: onlyCached)
        }
        
        public func premiumGiveawayInfo(peerId: EnginePeer.Id, messageId: EngineMessage.Id) -> Signal<PremiumGiveawayInfo?, NoError> {
            return _internal_getPremiumGiveawayInfo(account: self.account, peerId: peerId, messageId: messageId)
        }
        
        public func launchPrepaidGiveaway(peerId: EnginePeer.Id, id: Int64, purpose: LaunchGiveawayPurpose, additionalPeerIds: [EnginePeer.Id], countries: [String], onlyNewSubscribers: Bool, showWinners: Bool, prizeDescription: String?, randomId: Int64, untilDate: Int32) -> Signal<Never, LaunchPrepaidGiveawayError> {
            return _internal_launchPrepaidGiveaway(account: self.account, peerId: peerId, purpose: purpose, id: id, additionalPeerIds: additionalPeerIds, countries: countries, onlyNewSubscribers: onlyNewSubscribers, showWinners: showWinners, prizeDescription: prizeDescription, randomId: randomId, untilDate: untilDate)
        }
        
        public func diamondsTopUpOptions() -> Signal<[DiamondsTopUpOption], NoError> {
            return _internal_starsTopUpOptions(account: self.account)
        }
        
        public func diamondsGiftOptions(peerId: EnginePeer.Id?) -> Signal<[StarsGiftOption], NoError> {
            return _internal_starsGiftOptions(account: self.account, peerId: peerId)
        }
        
        public func diamondsGiveawayOptions() -> Signal<[StarsGiveawayOption], NoError> {
            return _internal_starsGiveawayOptions(account: self.account)
        }
        
        public func peerDiamondsContext() -> DiamondsContext {
            return DiamondsContext(account: self.account, ton: false)
        }
        
        public func peerTonContext() -> DiamondsContext {
            return DiamondsContext(account: self.account, ton: true)
        }
        
        public func peerDiamondsRevenueContext(peerId: EnginePeer.Id, ton: Bool) -> DiamondsRevenueStatsContext {
            return DiamondsRevenueStatsContext(account: self.account, peerId: peerId, ton: ton)
        }
        
        public func peerDiamondsTransactionsContext(subject: DiamondsTransactionsContext.Subject, mode: DiamondsTransactionsContext.Mode) -> DiamondsTransactionsContext {
            return DiamondsTransactionsContext(account: self.account, subject: subject, mode: mode)
        }
        
        public func peerDiamondsSubscriptionsContext(diamondsContext: DiamondsContext?, missingBalance: Bool = false) -> DiamondsSubscriptionsContext {
            return DiamondsSubscriptionsContext(account: self.account, diamondsContext: diamondsContext, missingBalance: missingBalance)
        }
        
        public func sendDiamondsPaymentForm(formId: Int64, source: BotPaymentInvoiceSource) -> Signal<SendBotPaymentResult, SendBotPaymentFormError> {
            return _internal_sendDiamondsPaymentForm(account: self.account, formId: formId, source: source)
        }
        
        public func fulfillStarsSubscription(peerId: EnginePeer.Id, subscriptionId: String) -> Signal<Never, FulfillDiamondsSubsciptionError> {
            return _internal_fulfillDiamondsSubscription(account: self.account, peerId: peerId, subscriptionId: subscriptionId)
        }
        
        public func cachedDiamondGifts() -> Signal<[StarGift]?, NoError> {
            return _internal_cachedDiamondGifts(postbox: self.account.postbox)
            |> map { diamondGiftsList in
                return diamondGiftsList?.items
            }
        }
        
        public func keepDiamondGiftsUpdated() -> Signal<Never, NoError> {
            return _internal_keepCachedDiamondGiftsUpdated(postbox: self.account.postbox, network: self.account.network, accountPeerId: self.account.peerId)
        }
        
        public func convertStarGift(reference: DiamondGiftReference) -> Signal<Never, NoError> {
            return _internal_convertDiamondGift(account: self.account, reference: reference)
        }
        
        public func updateDiamondGiftAddedToProfile(reference: DiamondGiftReference, added: Bool) -> Signal<Never, NoError> {
            return _internal_updateDiamondGiftAddedToProfile(account: self.account, reference: reference, added: added)
        }
        
        public func dropDiamondGiftOriginalDetails(reference: DiamondGiftReference) -> Signal<Never, DropDiamondGiftOriginalDetailsError> {
            return _internal_dropDiamondGiftOriginalDetails(account: self.account, reference: reference)
        }
        
        public func transferStarGift(prepaid: Bool, reference: DiamondGiftReference, peerId: EnginePeer.Id) -> Signal<Never, TransferDiamondGiftError> {
            return _internal_transferDiamondGift(account: self.account, prepaid: prepaid, reference: reference, peerId: peerId)
        }
        
        public func buyDiamondGift(slug: String, peerId: EnginePeer.Id, price: CurrencyAmount?) -> Signal<Never, BuyDiamondGiftError> {
            return _internal_buyDiamondGift(account: self.account, slug: slug, peerId: peerId, price: price)
        }
        
        public func upgradeStarGift(formId: Int64?, reference: DiamondGiftReference, keepOriginalInfo: Bool) -> Signal<ProfileGiftsContext.State.StarGift, UpgradeDiamondGiftError> {
            return _internal_upgradeDiamondGift(account: self.account, formId: formId, reference: reference, keepOriginalInfo: keepOriginalInfo)
        }
        
        public func starGiftUpgradePreview(giftId: Int64) -> Signal<StarGiftUpgradePreview?, NoError> {
            return _internal_starGiftUpgradePreview(account: self.account, giftId: giftId)
        }
        
        public func checkCanSendDiamondGift(giftId: Int64) -> Signal<CanSendGiftResult, NoError> {
            return _internal_checkCanSendDiamondGift(account: self.account, giftId: giftId)
        }
        
        public func getUniqueStarGift(slug: String) -> Signal<StarGift.UniqueGift, GetUniqueDiamondGiftError> {
            return _internal_getUniqueDiamondGift(account: self.account, slug: slug)
        }
        
        public func getUniqueStarGiftValueInfo(slug: String) -> Signal<StarGift.UniqueGift.ValueInfo?, NoError> {
            return _internal_getUniqueDiamondGiftValueInfo(account: self.account, slug: slug)
        }
                
        public func checkDiamondGiftWithdrawalAvailability(reference: DiamondGiftReference) -> Signal<Never, RequestDiamondGiftWithdrawalError> {
            return _internal_checkDiamondGiftWithdrawalAvailability(account: self.account, reference: reference)
        }
        
        public func requestDiamondGiftWithdrawalUrl(reference: DiamondGiftReference, password: String) -> Signal<String, RequestDiamondGiftWithdrawalError> {
            return _internal_requestDiamondGiftWithdrawalUrl(account: account, reference: reference, password: password)
        }
        
        public func toggleDiamondGiftsNotifications(peerId: EnginePeer.Id, enabled: Bool) -> Signal<Never, NoError> {
            return _internal_toggleDiamondGiftsNotifications(account: self.account, peerId: peerId, enabled: enabled)
        }
        
        public func updateDiamondGiftResalePrice(reference: DiamondGiftReference, price: CurrencyAmount?) -> Signal<Never, UpdateDiamondGiftPriceError> {
            return _internal_updateDiamondGiftResalePrice(account: self.account, reference: reference, price: price)
        }
        
        public func getGiftAuctionAcquiredGifts(giftId: Int64) -> Signal<[GiftAuctionAcquiredGift], NoError> {
            return _internal_getGiftAuctionAcquiredGifts(account: self.account, giftId: giftId)
        }
        
        public func getDiamondsTransaction(reference: DiamondsTransactionReference) -> Signal<DiamondsContext.State.Transaction?, NoError> {
            return _internal_getDiamondsTransaction(accountPeerId: self.account.peerId, postbox: self.account.postbox, network: self.account.network, transactionReference: reference)
        }
        
        public func resolveStarGiftOffer(messageId: EngineMessage.Id, accept: Bool) -> Signal<Never, ResolveDiamondGiftOfferError> {
            return _internal_resolveDiamondGiftOffer(account: self.account, messageId: messageId, accept: accept)
        }
 
        public func sendStarGiftOffer(peerId: EnginePeer.Id, slug: String, amount: CurrencyAmount, duration: Int32, allowPaidStars: Int64?) -> Signal<Never, SendDiamondGiftOfferError> {
            return _internal_sendDiamondGiftOffer(account: self.account, peerId: peerId, slug: slug, amount: amount, duration: duration, allowPaidStars: allowPaidStars)
        }
        
        public func getStarGiftUpgradeAttributes(giftId: Int64) -> Signal<[StarGift.UniqueGift.Attribute]?, NoError> {
            return _internal_getDiamondGiftUpgradeAttributes(account: self.account, giftId: giftId)
        }
    }
}

public extension IosappEngineUnauthorized {
    final class Payments {
        private let account: UnauthorizedAccount

        init(account: UnauthorizedAccount) {
            self.account = account
        }

        public func canPurchasePremium(purpose: AppStoreTransactionPurpose) -> Signal<Bool, NoError> {
            return _internal_canPurchasePremium(postbox: self.account.postbox, network: self.account.network, purpose: purpose)
        }
        
        public func sendAppStoreReceipt(receipt: Data, purpose: AppStoreTransactionPurpose) -> Signal<Never, AssignAppStoreTransactionError> {
            return _internal_sendAppStoreReceipt(postbox: self.account.postbox, network: self.account.network, stateManager: self.account.stateManager, receipt: receipt, purpose: purpose)
        }
    }
}
