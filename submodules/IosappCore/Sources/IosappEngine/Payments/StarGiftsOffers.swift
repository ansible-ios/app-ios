import Foundation
import Postbox
import MtProtoKit
import SwiftSignalKit
import IosappApi

public enum ResolveDiamondGiftOfferError {
    case generic
}

func _internal_resolveDiamondGiftOffer(account: Account, messageId: EngineMessage.Id, accept: Bool) -> Signal<Never, ResolveDiamondGiftOfferError> {
    var flags: Int32 = 0
    if !accept {
        flags |= (1 << 0)
    }
    return account.network.request(Api.functions.payments.resolveStarGiftOffer(flags: flags, offerMsgId: messageId.id))
    |> mapError { _ -> ResolveDiamondGiftOfferError in
        return .generic
    }
    |> mapToSignal { updates -> Signal<Never, ResolveDiamondGiftOfferError> in
        account.stateManager.addUpdates(updates)
        return .complete()
    }
    |> ignoreValues
}


public enum SendDiamondGiftOfferError {
    case generic
}

func _internal_sendDiamondGiftOffer(account: Account, peerId: EnginePeer.Id, slug: String, amount: CurrencyAmount, duration: Int32, allowPaidStars: Int64?) -> Signal<Never, SendDiamondGiftOfferError> {
    var flags: Int32 = 0
    if let _ = allowPaidStars {
        flags |= (1 << 0)
    }
    return account.postbox.transaction { transaction in
        return transaction.getPeer(peerId).flatMap(apiInputPeer)
    }
    |> castError(SendDiamondGiftOfferError.self)
    |> mapToSignal { inputPeer -> Signal<Never, SendDiamondGiftOfferError> in
        guard let inputPeer else {
            return .fail(.generic)
        }
        return account.network.request(Api.functions.payments.sendStarGiftOffer(flags: flags, peer: inputPeer, slug: slug, price: amount.apiAmount, duration: duration, randomId: Int64.random(in: .min ..< .max), allowPaidStars: allowPaidStars))
        |> mapError { _ -> SendDiamondGiftOfferError in
            return .generic
        }
        |> mapToSignal { updates -> Signal<Never, SendDiamondGiftOfferError> in
            account.stateManager.addUpdates(updates)
            return .complete()
        }
    }
    |> ignoreValues
}
