import Foundation

// Preserve established Ansible public Swift identifiers without changing the TL schema.
private let ansibleGeneratedNames: [String: String] = [
    "Cons_connectedBotStarRef": "Cons_connectedBotDiamondRef",
    "Cons_connectedStarRefBots": "Cons_connectedDiamondRefBots",
    "Cons_inputSavedStarGiftChat": "Cons_inputSavedDiamondGiftChat",
    "Cons_inputSavedStarGiftSlug": "Cons_inputSavedDiamondGiftSlug",
    "Cons_inputSavedStarGiftUser": "Cons_inputSavedDiamondGiftUser",
    "Cons_inputStarGiftAuction": "Cons_inputDiamondGiftAuction",
    "Cons_inputStarGiftAuctionSlug": "Cons_inputDiamondGiftAuctionSlug",
    "Cons_inputStorePaymentStarsGift": "Cons_inputStorePaymentDiamondsGift",
    "Cons_inputStorePaymentStarsGiveaway": "Cons_inputStorePaymentDiamondsGiveaway",
    "Cons_inputStorePaymentStarsTopup": "Cons_inputStorePaymentDiamondsTopup",
    "Cons_mediaAreaStarGift": "Cons_mediaAreaDiamondGift",
    "Cons_messageActionGiftStars": "Cons_messageActionGiftDiamonds",
    "Cons_messageActionPrizeStars": "Cons_messageActionPrizeDiamonds",
    "Cons_messageActionStarGift": "Cons_messageActionDiamondGift",
    "Cons_messageActionStarGiftPurchaseOffer": "Cons_messageActionDiamondGiftPurchaseOffer",
    "Cons_messageActionStarGiftPurchaseOfferDeclined": "Cons_messageActionDiamondGiftPurchaseOfferDeclined",
    "Cons_messageActionStarGiftUnique": "Cons_messageActionDiamondGiftUnique",
    "Cons_paymentFormStarGift": "Cons_paymentFormDiamondGift",
    "Cons_paymentFormStars": "Cons_paymentFormDiamonds",
    "Cons_paymentReceiptStars": "Cons_paymentReceiptDiamonds",
    "Cons_prepaidStarsGiveaway": "Cons_prepaidDiamondsGiveaway",
    "Cons_resaleStarGifts": "Cons_resaleDiamondGifts",
    "Cons_savedStarGift": "Cons_savedDiamondGift",
    "Cons_savedStarGifts": "Cons_savedDiamondGifts",
    "Cons_suggestedStarRefBots": "Cons_suggestedDiamondRefBots",
    "Cons_updateStarGiftAuctionState": "Cons_updateDiamondGiftAuctionState",
    "Cons_updateStarGiftAuctionUserState": "Cons_updateDiamondGiftAuctionUserState",
    "Cons_updateStarsBalance": "Cons_updateDiamondsBalance",
    "Cons_updateStarsRevenueStatus": "Cons_updateDiamondsRevenueStatus",
    "Cons_webPageAttributeStarGiftAuction": "Cons_webPageAttributeDiamondGiftAuction",
    "Cons_webPageAttributeStarGiftCollection": "Cons_webPageAttributeDiamondGiftCollection",
    "Cons_webPageAttributeUniqueStarGift": "Cons_webPageAttributeUniqueDiamondGift",
    "parse_connectedBotStarRef": "parse_connectedBotDiamondRef",
    "parse_connectedStarRefBots": "parse_connectedDiamondRefBots",
    "parse_inputPrivacyKeyStarGiftsAutoSave": "parse_inputPrivacyKeyDiamondGiftsAutoSave",
    "parse_inputSavedStarGiftChat": "parse_inputSavedDiamondGiftChat",
    "parse_inputSavedStarGiftSlug": "parse_inputSavedDiamondGiftSlug",
    "parse_inputSavedStarGiftUser": "parse_inputSavedDiamondGiftUser",
    "parse_inputStarGiftAuction": "parse_inputDiamondGiftAuction",
    "parse_inputStarGiftAuctionSlug": "parse_inputDiamondGiftAuctionSlug",
    "parse_inputStorePaymentStarsGift": "parse_inputStorePaymentDiamondsGift",
    "parse_inputStorePaymentStarsGiveaway": "parse_inputStorePaymentDiamondsGiveaway",
    "parse_inputStorePaymentStarsTopup": "parse_inputStorePaymentDiamondsTopup",
    "parse_mediaAreaStarGift": "parse_mediaAreaDiamondGift",
    "parse_messageActionGiftStars": "parse_messageActionGiftDiamonds",
    "parse_messageActionPrizeStars": "parse_messageActionPrizeDiamonds",
    "parse_messageActionStarGift": "parse_messageActionDiamondGift",
    "parse_messageActionStarGiftPurchaseOffer": "parse_messageActionDiamondGiftPurchaseOffer",
    "parse_messageActionStarGiftPurchaseOfferDeclined": "parse_messageActionDiamondGiftPurchaseOfferDeclined",
    "parse_messageActionStarGiftUnique": "parse_messageActionDiamondGiftUnique",
    "parse_paymentFormStarGift": "parse_paymentFormDiamondGift",
    "parse_paymentFormStars": "parse_paymentFormDiamonds",
    "parse_paymentReceiptStars": "parse_paymentReceiptDiamonds",
    "parse_prepaidStarsGiveaway": "parse_prepaidDiamondsGiveaway",
    "parse_privacyKeyStarGiftsAutoSave": "parse_privacyKeyDiamondGiftsAutoSave",
    "parse_resaleStarGifts": "parse_resaleDiamondGifts",
    "parse_savedStarGift": "parse_savedDiamondGift",
    "parse_savedStarGifts": "parse_savedDiamondGifts",
    "parse_suggestedStarRefBots": "parse_suggestedDiamondRefBots",
    "parse_updateStarGiftAuctionState": "parse_updateDiamondGiftAuctionState",
    "parse_updateStarGiftAuctionUserState": "parse_updateDiamondGiftAuctionUserState",
    "parse_updateStarGiftCraftFail": "parse_updateDiamondGiftCraftFail",
    "parse_updateStarsBalance": "parse_updateDiamondsBalance",
    "parse_updateStarsRevenueStatus": "parse_updateDiamondsRevenueStatus",
    "parse_webPageAttributeStarGiftAuction": "parse_webPageAttributeDiamondGiftAuction",
    "parse_webPageAttributeStarGiftCollection": "parse_webPageAttributeDiamondGiftCollection",
    "parse_webPageAttributeUniqueStarGift": "parse_webPageAttributeUniqueDiamondGift",
    "telegramApiLog": "ansibleApiLog",
]

func ansibleGeneratedIdentifiers(_ source: String) -> String {
    let pattern = "\\b(" + ansibleGeneratedNames.keys.sorted().map(NSRegularExpression.escapedPattern(for:)).joined(separator: "|") + ")\\b"
    let regex = try! NSRegularExpression(pattern: pattern)
    let result = NSMutableString(string: source)
    for match in regex.matches(in: source, range: NSRange(location: 0, length: result.length)).reversed() {
        let key = result.substring(with: match.range)
        result.replaceCharacters(in: match.range, with: ansibleGeneratedNames[key]!)
    }
    return result as String
}

private let ansibleConstructorDefaults: [String: Set<String>] = [
    "Cons_channel": ["pinnedMsgId"],
    "Cons_channelFull": ["shareTheme"],
    "Cons_inputReplyToMessage": ["quoteRich"],
    "Cons_messageReplyHeader": ["quoteRich"],
    "Cons_nftItem": ["gift"],
    "Cons_urlAuthResultRequest": ["tcClientId", "tcSessionId"],
    "Cons_userFull": ["shareTheme", "walletCard"],
]

func ansibleConstructorDefaultArgument(constructor: String, field: String, type: String) -> String {
    guard ansibleConstructorDefaults["Cons_" + constructor]?.contains(field) == true else { return "" }
    precondition(type.hasSuffix("?"), "Compatibility default must remain optional")
    return " = nil"
}

func ansibleFunctionDefaultArgument(function: String, field: String) -> String {
    return function == "acceptUrlAuth" && field == "tonconnectSession" ? " = nil" : ""
}
