import Foundation
import Postbox
import MtProtoKit
import SwiftSignalKit
import IosappApi
import FlatBuffers
import FlatSerialization

public struct DiamondsTopUpOption: Equatable, Codable {
    enum CodingKeys: String, CodingKey {
        case count
        case storeProductId
        case currency
        case amount
        case isExtended
    }
    
    public let count: Int64
    public let storeProductId: String?
    public let currency: String
    public let amount: Int64
    public let isExtended: Bool
    
    public init(count: Int64, storeProductId: String?, currency: String, amount: Int64, isExtended: Bool) {
        self.count = count
        self.storeProductId = storeProductId
        self.currency = currency
        self.amount = amount
        self.isExtended = isExtended
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decode(Int64.self, forKey: .count)
        self.storeProductId = try container.decodeIfPresent(String.self, forKey: .storeProductId)
        self.currency = try container.decode(String.self, forKey: .currency)
        self.amount = try container.decode(Int64.self, forKey: .amount)
        self.isExtended = try container.decodeIfPresent(Bool.self, forKey: .isExtended) ?? false
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.count, forKey: .count)
        try container.encodeIfPresent(self.storeProductId, forKey: .storeProductId)
        try container.encode(self.currency, forKey: .currency)
        try container.encode(self.amount, forKey: .amount)
        try container.encode(self.isExtended, forKey: .isExtended)
    }
}

extension DiamondsTopUpOption {
    init(apiDiamondsTopupOption: Api.StarsTopupOption) {
        switch apiDiamondsTopupOption {
        case let .starsTopupOption(diamondsTopupOptionData):
            let (flags, stars, storeProduct, currency, amount) = (diamondsTopupOptionData.flags, diamondsTopupOptionData.stars, diamondsTopupOptionData.storeProduct, diamondsTopupOptionData.currency, diamondsTopupOptionData.amount)
            self.init(count: stars, storeProductId: storeProduct, currency: currency, amount: amount, isExtended: (flags & (1 << 1)) != 0)
        }
    }
}

func _internal_starsTopUpOptions(account: Account) -> Signal<[DiamondsTopUpOption], NoError> {
    return account.network.request(Api.functions.payments.getStarsTopupOptions())
    |> map(Optional.init)
    |> `catch` { _ -> Signal<[Api.StarsTopupOption]?, NoError> in
        return .single(nil)
    }
    |> mapToSignal { results -> Signal<[DiamondsTopUpOption], NoError> in
        if let results = results {
            return .single(results.map { DiamondsTopUpOption(apiDiamondsTopupOption: $0) })
        } else {
            return .single([])
        }
    }
}

public struct StarsGiftOption: Equatable, Codable {
    enum CodingKeys: String, CodingKey {
        case count
        case currency
        case amount
        case storeProductId
        case isExtended
    }
    
    public let count: Int64
    public let currency: String
    public let amount: Int64
    public let storeProductId: String?
    public let isExtended: Bool
    
    public init(count: Int64, storeProductId: String?, currency: String, amount: Int64, isExtended: Bool) {
        self.count = count
        self.currency = currency
        self.amount = amount
        self.storeProductId = storeProductId
        self.isExtended = isExtended
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decode(Int64.self, forKey: .count)
        self.storeProductId = try container.decodeIfPresent(String.self, forKey: .storeProductId)
        self.currency = try container.decode(String.self, forKey: .currency)
        self.amount = try container.decode(Int64.self, forKey: .amount)
        self.isExtended = try container.decodeIfPresent(Bool.self, forKey: .isExtended) ?? false
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.count, forKey: .count)
        try container.encodeIfPresent(self.storeProductId, forKey: .storeProductId)
        try container.encode(self.currency, forKey: .currency)
        try container.encode(self.amount, forKey: .amount)
        try container.encode(self.isExtended, forKey: .isExtended)
    }
}

extension StarsGiftOption {
    init(apiDiamondsGiftOption: Api.StarsGiftOption) {
        switch apiDiamondsGiftOption {
        case let .starsGiftOption(diamondsGiftOptionData):
            let (flags, stars, storeProduct, currency, amount) = (diamondsGiftOptionData.flags, diamondsGiftOptionData.stars, diamondsGiftOptionData.storeProduct, diamondsGiftOptionData.currency, diamondsGiftOptionData.amount)
            self.init(count: stars, storeProductId: storeProduct, currency: currency, amount: amount, isExtended: (flags & (1 << 1)) != 0)
        }
    }
}

func _internal_starsGiftOptions(account: Account, peerId: EnginePeer.Id?) -> Signal<[StarsGiftOption], NoError> {
    return account.postbox.transaction { transaction -> Api.InputUser? in
        return peerId.flatMap { transaction.getPeer($0).flatMap(apiInputUser) }
    }
    |> mapToSignal { inputUser in
        var flags: Int32 = 0
        if let _ = inputUser {
            flags |= (1 << 0)
        }
        return account.network.request(Api.functions.payments.getStarsGiftOptions(flags: flags, userId: inputUser))
        |> map(Optional.init)
        |> `catch` { _ -> Signal<[Api.StarsGiftOption]?, NoError> in
            return .single(nil)
        }
        |> mapToSignal { results -> Signal<[StarsGiftOption], NoError> in
            if let results = results {
                return .single(results.map { StarsGiftOption(apiDiamondsGiftOption: $0) })
            } else {
                return .single([])
            }
        }
    }
}



public struct StarsGiveawayOption: Equatable, Codable {
    enum CodingKeys: String, CodingKey {
        case count
        case currency
        case amount
        case yearlyBoosts
        case storeProductId
        case winners
        case isExtended
        case isDefault
    }
    
    public struct Winners: Equatable, Codable {
        enum CodingKeys: String, CodingKey {
            case users
            case diamondsPerUser
            case isDefault
        }
        
        public let users: Int32
        public let diamondsPerUser: Int64
        public let isDefault: Bool
        
        public init(users: Int32, diamondsPerUser: Int64, isDefault: Bool) {
            self.users = users
            self.diamondsPerUser = diamondsPerUser
            self.isDefault = isDefault
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.users = try container.decode(Int32.self, forKey: .users)
            self.diamondsPerUser = try container.decode(Int64.self, forKey: .diamondsPerUser)
            self.isDefault = try container.decodeIfPresent(Bool.self, forKey: .isDefault) ?? false
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(self.users, forKey: .users)
            try container.encode(self.diamondsPerUser, forKey: .diamondsPerUser)
            try container.encode(self.isDefault, forKey: .isDefault)
        }
    }
    
    public let count: Int64
    public let yearlyBoosts: Int32
    public let currency: String
    public let amount: Int64
    public let storeProductId: String?
    public let winners: [Winners]
    public let isExtended: Bool
    public let isDefault: Bool
    
    public init(count: Int64, yearlyBoosts: Int32, storeProductId: String?, currency: String, amount: Int64, winners: [Winners], isExtended: Bool, isDefault: Bool) {
        self.count = count
        self.yearlyBoosts = yearlyBoosts
        self.currency = currency
        self.amount = amount
        self.storeProductId = storeProductId?.replacingOccurrences(of: "telegram_stars.topup", with: "org.telegram.telegramStars.topup")
        self.winners = winners
        self.isExtended = isExtended
        self.isDefault = isDefault
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decode(Int64.self, forKey: .count)
        self.yearlyBoosts = try container.decode(Int32.self, forKey: .yearlyBoosts)
        self.storeProductId = try container.decodeIfPresent(String.self, forKey: .storeProductId)
        self.currency = try container.decode(String.self, forKey: .currency)
        self.amount = try container.decode(Int64.self, forKey: .amount)
        self.winners = try container.decode([StarsGiveawayOption.Winners].self, forKey: .winners)
        self.isExtended = try container.decodeIfPresent(Bool.self, forKey: .isExtended) ?? false
        self.isDefault = try container.decodeIfPresent(Bool.self, forKey: .isDefault) ?? false
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.count, forKey: .count)
        try container.encode(self.yearlyBoosts, forKey: .yearlyBoosts)
        try container.encodeIfPresent(self.storeProductId, forKey: .storeProductId)
        try container.encode(self.currency, forKey: .currency)
        try container.encode(self.amount, forKey: .amount)
        try container.encode(self.winners, forKey: .winners)
        try container.encode(self.isExtended, forKey: .isExtended)
        try container.encode(self.isDefault, forKey: .isDefault)
    }
}

extension StarsGiveawayOption.Winners {
    init(apiDiamondsGiveawayWinnersOption: Api.StarsGiveawayWinnersOption) {
        switch apiDiamondsGiveawayWinnersOption {
        case let .starsGiveawayWinnersOption(diamondsGiveawayWinnersOptionData):
            let (flags, users, diamondsPerUser) = (diamondsGiveawayWinnersOptionData.flags, diamondsGiveawayWinnersOptionData.users, diamondsGiveawayWinnersOptionData.perUserStars)
            self.init(users: users, diamondsPerUser: diamondsPerUser, isDefault: (flags & (1 << 0)) != 0)
        }
    }
}

extension StarsGiveawayOption {
    init(apiDiamondsGiveawayOption: Api.StarsGiveawayOption) {
        switch apiDiamondsGiveawayOption {
        case let .starsGiveawayOption(diamondsGiveawayOptionData):
            let (flags, stars, yearlyBoosts, storeProduct, currency, amount, winners) = (diamondsGiveawayOptionData.flags, diamondsGiveawayOptionData.stars, diamondsGiveawayOptionData.yearlyBoosts, diamondsGiveawayOptionData.storeProduct, diamondsGiveawayOptionData.currency, diamondsGiveawayOptionData.amount, diamondsGiveawayOptionData.winners)
            self.init(count: stars, yearlyBoosts: yearlyBoosts, storeProductId: storeProduct, currency: currency, amount: amount, winners: winners.map { StarsGiveawayOption.Winners(apiDiamondsGiveawayWinnersOption: $0) }, isExtended: (flags & (1 << 0)) != 0, isDefault: (flags & (1 << 1)) != 0)
        }
    }
}

func _internal_starsGiveawayOptions(account: Account) -> Signal<[StarsGiveawayOption], NoError> {
    return account.network.request(Api.functions.payments.getStarsGiveawayOptions())
    |> map(Optional.init)
    |> `catch` { _ -> Signal<[Api.StarsGiveawayOption]?, NoError> in
        return .single(nil)
    }
    |> mapToSignal { results -> Signal<[StarsGiveawayOption], NoError> in
        if let results = results {
            return .single(results.map { StarsGiveawayOption(apiDiamondsGiveawayOption: $0) })
        } else {
            return .single([])
        }
    }
}

public struct StarsAmount: Equatable, Comparable, Hashable, Codable, CustomStringConvertible {
    public static let zero: StarsAmount = StarsAmount(value: 0, nanos: 0)
    
    public var value: Int64
    public var nanos: Int32
    
    public init(value: Int64, nanos: Int32) {
        self.value = value
        self.nanos = nanos
    }
    
    public init(flatBuffersObject: IosappCore_StarsAmount) throws {
        self.value = flatBuffersObject.value
        self.nanos = flatBuffersObject.nanos
    }
    
    public func encodeToFlatBuffers(builder: inout FlatBufferBuilder) -> Offset {
        let start = IosappCore_StarsAmount.startStarsAmount(&builder)
        IosappCore_StarsAmount.add(value: self.value, &builder)
        IosappCore_StarsAmount.add(nanos: self.nanos, &builder)
        return IosappCore_StarsAmount.endStarsAmount(&builder, start: start)
    }
    
    public var stringValue: String {
        return totalValue.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", totalValue) :  String(format: "%.02f", totalValue)
    }
    
    public var totalValue: Double {
        if self.nanos == 0 {
            return Double(self.value)
        } else {
            let totalValue = (Double(self.value) * 1e9 + Double(self.nanos)) / 1e9
            return totalValue
        }
    }
    
    public var description: String {
        return self.stringValue
    }
    
    public static func <(lhs: StarsAmount, rhs: StarsAmount) -> Bool {
        if lhs.value == rhs.value {
            return lhs.nanos < rhs.nanos
        } else {
            return lhs.value < rhs.value
        }
    }
    
    public static func +(lhs: StarsAmount, rhs: StarsAmount) -> StarsAmount {
        if rhs.value < 0 || rhs.nanos < 0 {
            return lhs - StarsAmount(value: abs(rhs.value), nanos: abs(rhs.nanos))
        }
        
        let totalNanos = Int64(lhs.nanos) + Int64(rhs.nanos)
        let overflow = totalNanos / 1_000_000_000
        let remainingNanos = totalNanos % 1_000_000_000
        return StarsAmount(value: lhs.value + rhs.value + overflow, nanos: Int32(remainingNanos))
    }
    
    public static func -(lhs: StarsAmount, rhs: StarsAmount) -> StarsAmount {
        var totalNanos = Int64(lhs.nanos) - Int64(rhs.nanos)
        var totalValue = lhs.value - rhs.value

        if totalNanos < 0 {
            totalValue -= 1
            totalNanos += 1_000_000_000
        }

        return StarsAmount(value: totalValue, nanos: Int32(totalNanos))
    }
}

extension StarsAmount {
    init(apiAmount: Api.StarsAmount) {
        switch apiAmount {
        case let .starsAmount(diamondsAmountData):
            let (amount, nanos) = (diamondsAmountData.amount, diamondsAmountData.nanos)
            self.init(value: amount, nanos: nanos)
        case let .starsTonAmount(diamondsTonAmountData):
            let amount = diamondsTonAmountData.amount
            self.init(value: amount, nanos: 0)
        }
    }
}

public struct CurrencyAmount: Equatable, Hashable, Codable {
    private enum CodingKeys: String, CodingKey {
        case amount = "a"
        case currency = "c"
    }
    
    public enum Currency: Int32 {
        case stars = 0
        case ton = 1
    }
    
    public var amount: StarsAmount
    public var currency: Currency
    
    public init(amount: StarsAmount, currency: Currency) {
        self.amount = amount
        self.currency = currency
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.amount = try container.decode(StarsAmount.self, forKey: .amount)
        self.currency = Currency(rawValue: try container.decode(Int32.self, forKey: .currency)) ?? .stars
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.amount, forKey: .amount)
        try container.encode(Int32(self.currency.rawValue), forKey: .currency)
    }
}

extension CurrencyAmount {
    init(apiAmount: Api.StarsAmount) {
        switch apiAmount {
        case let .starsAmount(diamondsAmountData):
            let (amount, nanos) = (diamondsAmountData.amount, diamondsAmountData.nanos)
            self.init(amount: StarsAmount(value: amount, nanos: nanos), currency: .stars)
        case let .starsTonAmount(diamondsTonAmountData):
            let amount = diamondsTonAmountData.amount
            self.init(amount: StarsAmount(value: amount, nanos: 0), currency: .ton)
        }
    }
    
    var apiAmount: Api.StarsAmount {
        switch self.currency {
        case .stars:
            return .starsAmount(.init(amount: self.amount.value, nanos: self.amount.nanos))
        case .ton:
            assert(self.amount.nanos == 0)
            return .starsTonAmount(.init(amount: self.amount.value))
        }
    }
}

struct InternalDiamondsStatus {
    let balance: StarsAmount
    let subscriptionsMissingBalance: StarsAmount?
    let subscriptions: [DiamondsContext.State.Subscription]
    let nextSubscriptionsOffset: String?
    let transactions: [DiamondsContext.State.Transaction]
    let nextTransactionsOffset: String?
}

private enum RequestDiamondsStateError {
    case generic
}

private func _internal_requestDiamondsState(account: Account, peerId: EnginePeer.Id, ton: Bool, mode: DiamondsTransactionsContext.Mode, subscriptionId: String?, offset: String?, limit: Int32) -> Signal<InternalDiamondsStatus, RequestDiamondsStateError> {
    return account.postbox.transaction { transaction -> Peer? in
        return transaction.getPeer(peerId)
    } 
    |> castError(RequestDiamondsStateError.self)
    |> mapToSignal { peer -> Signal<InternalDiamondsStatus, RequestDiamondsStateError> in
        guard let peer, let inputPeer = apiInputPeer(peer) else {
            return .fail(.generic)
        }
                
        let signal: Signal<Api.payments.StarsStatus, MTRpcError>
        if let offset {
            var flags: Int32 = 0
            switch mode {
            case .incoming:
                flags = 1 << 0
            case .outgoing:
                flags = 1 << 1
            default:
                break
            }
            if let _ = subscriptionId {
                flags |= 1 << 3
            }
            if ton {
                flags |= 1 << 4
            }
            signal = account.network.request(Api.functions.payments.getStarsTransactions(flags: flags, subscriptionId: subscriptionId, peer: inputPeer, offset: offset, limit: limit))
        } else {
            var flags: Int32 = 0
            if ton {
                flags = 1 << 0
            }
            signal = account.network.request(Api.functions.payments.getStarsStatus(flags: flags, peer: inputPeer))
        }
        
        return signal
        |> retryRequest
        |> castError(RequestDiamondsStateError.self)
        |> mapToSignal { result -> Signal<InternalDiamondsStatus, RequestDiamondsStateError> in
            return account.postbox.transaction { transaction -> InternalDiamondsStatus in
                switch result {
                case let .starsStatus(diamondsStatusData):
                    let (_, balance, _, _, subscriptionsMissingBalance, transactions, nextTransactionsOffset, chats, users) = (diamondsStatusData.flags, diamondsStatusData.balance, diamondsStatusData.subscriptions, diamondsStatusData.subscriptionsNextOffset, diamondsStatusData.subscriptionsMissingBalance, diamondsStatusData.history, diamondsStatusData.nextOffset, diamondsStatusData.chats, diamondsStatusData.users)
                    let peers = AccumulatedPeers(chats: chats, users: users)
                    updatePeers(transaction: transaction, accountPeerId: account.peerId, peers: peers)
                
                    var parsedTransactions: [DiamondsContext.State.Transaction] = []
                    if let transactions {
                        for entry in transactions {
                            if let parsedTransaction = DiamondsContext.State.Transaction(apiTransaction: entry, peerId: peerId != account.peerId ? peerId : nil, transaction: transaction) {
                                parsedTransactions.append(parsedTransaction)
                            }
                        }
                    }
                    return InternalDiamondsStatus(
                        balance: StarsAmount(apiAmount: balance),
                        subscriptionsMissingBalance: subscriptionsMissingBalance.flatMap { StarsAmount(value: $0, nanos: 0) },
                        subscriptions: [],
                        nextSubscriptionsOffset: nil,
                        transactions: parsedTransactions,
                        nextTransactionsOffset: nextTransactionsOffset
                    )
                }
            }
            |> castError(RequestDiamondsStateError.self)
        }
    }
}

private enum RequestDiamondsSubscriptionsError {
    case generic
}

private func _internal_requestDiamondsSubscriptions(account: Account, peerId: EnginePeer.Id, offset: String, missingBalance: Bool) -> Signal<InternalDiamondsStatus, RequestDiamondsSubscriptionsError> {
    return account.postbox.transaction { transaction -> Peer? in
        return transaction.getPeer(peerId)
    }
    |> castError(RequestDiamondsSubscriptionsError.self)
    |> mapToSignal { peer -> Signal<InternalDiamondsStatus, RequestDiamondsSubscriptionsError> in
        guard let peer, let inputPeer = apiInputPeerOrSelf(peer, accountPeerId: peerId) else {
            return .fail(.generic)
        }
        var flags: Int32 = 0
        if missingBalance {
            flags |= (1 << 0)
        }
        return account.network.request(Api.functions.payments.getStarsSubscriptions(flags: flags, peer: inputPeer, offset: offset))
        |> retryRequestIfNotFrozen
        |> castError(RequestDiamondsSubscriptionsError.self)
        |> mapToSignal { result -> Signal<InternalDiamondsStatus, RequestDiamondsSubscriptionsError> in
            guard let result else {
                return .single(InternalDiamondsStatus(balance: .zero, subscriptionsMissingBalance: nil, subscriptions: [], nextSubscriptionsOffset: nil, transactions: [], nextTransactionsOffset: nil))
            }
            return account.postbox.transaction { transaction -> InternalDiamondsStatus in
                switch result {
                case let .starsStatus(diamondsStatusData):
                    let (_, balance, subscriptions, subscriptionsNextOffset, subscriptionsMissingBalance, _, _, chats, users) = (diamondsStatusData.flags, diamondsStatusData.balance, diamondsStatusData.subscriptions, diamondsStatusData.subscriptionsNextOffset, diamondsStatusData.subscriptionsMissingBalance, diamondsStatusData.history, diamondsStatusData.nextOffset, diamondsStatusData.chats, diamondsStatusData.users)
                    let peers = AccumulatedPeers(chats: chats, users: users)
                    updatePeers(transaction: transaction, accountPeerId: account.peerId, peers: peers)

                    var parsedSubscriptions: [DiamondsContext.State.Subscription] = []
                    if let subscriptions {
                        for entry in subscriptions {
                            if let parsedSubscription = DiamondsContext.State.Subscription(apiSubscription: entry, transaction: transaction) {
                                if !missingBalance || parsedSubscription.flags.contains(.missingBalance) {
                                    parsedSubscriptions.append(parsedSubscription)
                                }
                            }
                        }
                    }
                    return InternalDiamondsStatus(
                        balance: StarsAmount(apiAmount: balance),
                        subscriptionsMissingBalance: subscriptionsMissingBalance.flatMap { StarsAmount(value: $0, nanos: 0) },
                        subscriptions: parsedSubscriptions,
                        nextSubscriptionsOffset: subscriptionsNextOffset,
                        transactions: [],
                        nextTransactionsOffset: nil
                    )
                }
            }
            |> castError(RequestDiamondsSubscriptionsError.self)
        }
    }
}

private final class DiamondsContextImpl {
    private let account: Account
    fileprivate let peerId: EnginePeer.Id
    fileprivate let ton: Bool
    
    fileprivate var _state: DiamondsContext.State?
    private let _statePromise = Promise<DiamondsContext.State?>()
    var state: Signal<DiamondsContext.State?, NoError> {
        return self._statePromise.get()
    }
    
    private let disposable = MetaDisposable()
    private var updateDisposable: Disposable?
    
    init(account: Account, ton: Bool) {
        assert(Queue.mainQueue().isCurrent())
        
        self.account = account
        self.peerId = account.peerId
        self.ton = ton
        
        self._state = nil
        self._statePromise.set(.single(nil))
        
        self.load(force: true)
        
        self.updateDisposable = ((ton ? account.stateManager.updatedTonBalance() : account.stateManager.updatedDiamondsBalance())
        |> deliverOnMainQueue).startStrict(next: { [weak self] balances in
            guard let self, let state = self._state, let balance = balances[self.peerId] else {
                return
            }
            self.updateState(DiamondsContext.State(flags: [], balance: balance, subscriptions: state.subscriptions, canLoadMoreSubscriptions: state.canLoadMoreSubscriptions, transactions: state.transactions, canLoadMoreTransactions: state.canLoadMoreTransactions, isLoading: false))
            self.load(force: true)
        })
    }
    
    deinit {
        assert(Queue.mainQueue().isCurrent())
        self.disposable.dispose()
        self.updateDisposable?.dispose()
    }
    
    private var previousLoadTimestamp: Double?
    func load(force: Bool) {
        assert(Queue.mainQueue().isCurrent())
        
        let currentTimestamp = CFAbsoluteTimeGetCurrent()
        if let previousLoadTimestamp = self.previousLoadTimestamp, currentTimestamp - previousLoadTimestamp < 60 && !force {
            return
        }
        self.previousLoadTimestamp = currentTimestamp
        
        self.disposable.set((_internal_requestDiamondsState(account: self.account, peerId: self.peerId, ton: self.ton, mode: .all, subscriptionId: nil, offset: nil, limit: 5)
        |> deliverOnMainQueue).start(next: { [weak self] status in
            guard let self else {
                return
            }
            self.updateState(DiamondsContext.State(flags: [], balance: status.balance, subscriptions: status.subscriptions, canLoadMoreSubscriptions: status.nextSubscriptionsOffset != nil, transactions: status.transactions, canLoadMoreTransactions: status.nextTransactionsOffset != nil, isLoading: false))
        }, error: { [weak self] _ in
            guard let self else {
                return
            }
            Queue.mainQueue().after(2.5, {
                self.load(force: true)
            })
        }))
    }
    
    func add(balance: StarsAmount, addTransaction: Bool) {
        guard let state = self._state else {
            return
        }
        var transactions = state.transactions
        if addTransaction {
            let count =  CurrencyAmount(amount: balance, currency: self.ton ? .ton : .stars)
            transactions.insert(.init(flags: [.isLocal], id: "\(arc4random())", count: count, date: Int32(Date().timeIntervalSince1970), peer: .appStore, title: nil, description: nil, photo: nil, transactionDate: nil, transactionUrl: nil, paidMessageId: nil, giveawayMessageId: nil, media: [], subscriptionPeriod: nil, starGift: nil, floodskipNumber: nil, starrefCommissionPermille: nil, starrefPeerId: nil, starrefAmount: nil, paidMessageCount: nil, premiumGiftMonths: nil, adsProceedsFromDate: nil, adsProceedsToDate: nil), at: 0)
        }
        self.updateState(DiamondsContext.State(flags: [.isPendingBalance], balance: max(StarsAmount(value: 0, nanos: 0), state.balance + balance), subscriptions: state.subscriptions, canLoadMoreSubscriptions: state.canLoadMoreSubscriptions, transactions: transactions, canLoadMoreTransactions: state.canLoadMoreTransactions, isLoading: state.isLoading))
    }
    
    fileprivate func updateBalance(_ balance: StarsAmount, transactions: [DiamondsContext.State.Transaction]?) {
        guard let state = self._state else {
            return
        }
        self.updateState(DiamondsContext.State(flags: [], balance: balance, subscriptions: state.subscriptions, canLoadMoreSubscriptions: state.canLoadMoreSubscriptions, transactions: transactions ?? state.transactions, canLoadMoreTransactions: state.canLoadMoreTransactions, isLoading: state.isLoading))
    }
    
    private func updateState(_ state: DiamondsContext.State) {
        self._state = state
        self._statePromise.set(.single(state))
    }
    
    var onUpdate: Signal<Void, NoError> {
        return self._statePromise.get()
        |> take(until: { value in
            if let value {
                if !value.flags.contains(.isPendingBalance) {
                    return SignalTakeAction(passthrough: true, complete: true)
                }
            }
            return SignalTakeAction(passthrough: false, complete: false)
        })
        |> map { _ in
            return Void()
        }
    }
}

private extension DiamondsContext.State.Transaction {
    init?(apiTransaction: Api.StarsTransaction, peerId: EnginePeer.Id?, transaction: Transaction) {
        switch apiTransaction {
        case let .starsTransaction(diamondsTransactionData):
            let (apiFlags, id, stars, date, transactionPeer, title, description, photo, transactionDate, transactionUrl, _, messageId, extendedMedia, subscriptionPeriod, giveawayPostId, starGift, floodskipNumber, starrefCommissionPermille, starrefPeer, starrefAmount, paidMessageCount, premiumGiftMonths, adsProceedsFromDate, adsProceedsToDate) = (diamondsTransactionData.flags, diamondsTransactionData.id, diamondsTransactionData.amount, diamondsTransactionData.date, diamondsTransactionData.peer, diamondsTransactionData.title, diamondsTransactionData.description, diamondsTransactionData.photo, diamondsTransactionData.transactionDate, diamondsTransactionData.transactionUrl, diamondsTransactionData.botPayload, diamondsTransactionData.msgId, diamondsTransactionData.extendedMedia, diamondsTransactionData.subscriptionPeriod, diamondsTransactionData.giveawayPostId, diamondsTransactionData.stargift, diamondsTransactionData.floodskipNumber, diamondsTransactionData.starrefCommissionPermille, diamondsTransactionData.starrefPeer, diamondsTransactionData.starrefAmount, diamondsTransactionData.paidMessages, diamondsTransactionData.premiumGiftMonths, diamondsTransactionData.adsProceedsFromDate, diamondsTransactionData.adsProceedsToDate)
            let parsedPeer: DiamondsContext.State.Transaction.Peer
            var paidMessageId: MessageId?
            var giveawayMessageId: MessageId?

            switch transactionPeer {
            case .starsTransactionPeerAppStore:
                parsedPeer = .appStore
            case .starsTransactionPeerPlayMarket:
                parsedPeer = .playMarket
            case .starsTransactionPeerFragment:
                parsedPeer = .fragment
            case .starsTransactionPeerPremiumBot:
                parsedPeer = .premiumBot
            case .starsTransactionPeerAds:
                parsedPeer = .ads
            case .starsTransactionPeerAPI:
                parsedPeer = .apiLimitExtension
            case .starsTransactionPeerUnsupported:
                parsedPeer = .unsupported
            case let .starsTransactionPeer(diamondsTransactionPeerData):
                let apiPeer = diamondsTransactionPeerData.peer
                guard let peer = transaction.getPeer(apiPeer.peerId) else {
                    return nil
                }
                parsedPeer = .peer(EnginePeer(peer))
                if let messageId {
                    if let peerId {
                        paidMessageId = MessageId(peerId: peerId, namespace: Namespaces.Message.Cloud, id: messageId)
                    } else {
                        paidMessageId = MessageId(peerId: peer.id, namespace: Namespaces.Message.Cloud, id: messageId)
                    }
                }
                if let giveawayPostId {
                    giveawayMessageId = MessageId(peerId: peer.id, namespace: Namespaces.Message.Cloud, id: giveawayPostId)
                }
            }
            
            var flags: Flags = []
            if (apiFlags & (1 << 3)) != 0 {
                flags.insert(.isRefund)
            }
            if (apiFlags & (1 << 4)) != 0 {
                flags.insert(.isPending)
            }
            if (apiFlags & (1 << 6)) != 0 {
                flags.insert(.isFailed)
            }
            if (apiFlags & (1 << 10)) != 0 {
                flags.insert(.isGift)
            }
            if (apiFlags & (1 << 11)) != 0 {
                flags.insert(.isReaction)
            }
            if (apiFlags & (1 << 18)) != 0 {
                flags.insert(.isDiamondGiftUpgrade)
            }
            if (apiFlags & (1 << 19)) != 0 {
                flags.insert(.isPaidMessage)
            }
            if (apiFlags & (1 << 21)) != 0 {
                flags.insert(.isBusinessTransfer)
            }
            if (apiFlags & (1 << 22)) != 0 {
                flags.insert(.isDiamondGiftResale)
            }
            if (apiFlags & (1 << 24)) != 0 {
                flags.insert(.isPostsSearch)
            }
            if (apiFlags & (1 << 25)) != 0 {
                flags.insert(.isDiamondGiftPrepaidUpgrade)
            }
            if (apiFlags & (1 << 26)) != 0 {
                flags.insert(.isDiamondGiftDropOriginalDetails)
            }
            if (apiFlags & (1 << 27)) != 0 {
                flags.insert(.isLiveStreamPaidMessage)
            }
            if (apiFlags & (1 << 28)) != 0 {
                flags.insert(.isDiamondGiftAuctionBid)
            }
            if (apiFlags & (1 << 29)) != 0 {
                flags.insert(.isDiamondGiftOffer)
            }
            
            let media = extendedMedia.flatMap({ $0.compactMap { textMediaAndExpirationTimerFromApiMedia($0, PeerId(0)).media } }) ?? []
                        
            self.init(flags: flags, id: id, count: CurrencyAmount(apiAmount: stars), date: date, peer: parsedPeer, title: title, description: description, photo: photo.flatMap(IosappMediaWebFile.init), transactionDate: transactionDate, transactionUrl: transactionUrl, paidMessageId: paidMessageId, giveawayMessageId: giveawayMessageId, media: media, subscriptionPeriod: subscriptionPeriod, starGift: starGift.flatMap { StarGift(apiDiamondGift: $0) }, floodskipNumber: floodskipNumber, starrefCommissionPermille: starrefCommissionPermille, starrefPeerId: starrefPeer?.peerId, starrefAmount: starrefAmount.flatMap(StarsAmount.init(apiAmount:)), paidMessageCount: paidMessageCount, premiumGiftMonths: premiumGiftMonths, adsProceedsFromDate: adsProceedsFromDate, adsProceedsToDate: adsProceedsToDate)
        }
    }
}

private extension DiamondsContext.State.Subscription {
    init?(apiSubscription: Api.StarsSubscription, transaction: Transaction) {
        switch apiSubscription {
        case let .starsSubscription(diamondsSubscriptionData):
            let (apiFlags, id, apiPeer, untilDate, pricing, inviteHash, title, photo, invoiceSlug) = (diamondsSubscriptionData.flags, diamondsSubscriptionData.id, diamondsSubscriptionData.peer, diamondsSubscriptionData.untilDate, diamondsSubscriptionData.pricing, diamondsSubscriptionData.chatInviteHash, diamondsSubscriptionData.title, diamondsSubscriptionData.photo, diamondsSubscriptionData.invoiceSlug)
            guard let peer = transaction.getPeer(apiPeer.peerId) else {
                return nil
            }
            var flags: Flags = []
            if (apiFlags & (1 << 0)) != 0 {
                flags.insert(.isCancelled)
            }
            if (apiFlags & (1 << 1)) != 0 {
                flags.insert(.canRefulfill)
            }
            if (apiFlags & (1 << 2)) != 0 {
                flags.insert(.missingBalance)
            }
            if (apiFlags & (1 << 7)) != 0 {
                flags.insert(.isCancelledByBot)
            }
            self.init(flags: flags, id: id, peer: EnginePeer(peer), untilDate: untilDate, pricing: StarsSubscriptionPricing(apiDiamondsSubscriptionPricing: pricing), inviteHash: inviteHash, title: title, photo: photo.flatMap(IosappMediaWebFile.init), invoiceSlug: invoiceSlug)
        }
    }
}

public final class DiamondsContext {
    public struct State: Equatable {
        public struct Transaction: Equatable {
            public struct Flags: OptionSet {
                public var rawValue: Int32
                
                public init(rawValue: Int32) {
                    self.rawValue = rawValue
                }
                
                public static let isRefund = Flags(rawValue: 1 << 0)
                public static let isLocal = Flags(rawValue: 1 << 1)
                public static let isPending = Flags(rawValue: 1 << 2)
                public static let isFailed = Flags(rawValue: 1 << 3)
                public static let isGift = Flags(rawValue: 1 << 4)
                public static let isReaction = Flags(rawValue: 1 << 5)
                public static let isDiamondGiftUpgrade = Flags(rawValue: 1 << 6)
                public static let isPaidMessage = Flags(rawValue: 1 << 7)
                public static let isBusinessTransfer = Flags(rawValue: 1 << 8)
                public static let isDiamondGiftResale = Flags(rawValue: 1 << 9)
                public static let isPostsSearch = Flags(rawValue: 1 << 10)
                public static let isDiamondGiftPrepaidUpgrade = Flags(rawValue: 1 << 11)
                public static let isDiamondGiftDropOriginalDetails = Flags(rawValue: 1 << 12)
                public static let isDiamondGiftAuctionBid = Flags(rawValue: 1 << 13)
                public static let isLiveStreamPaidMessage = Flags(rawValue: 1 << 14)
                public static let isDiamondGiftOffer = Flags(rawValue: 1 << 15)
            }
            
            public enum Peer: Equatable {
                case appStore
                case playMarket
                case fragment
                case premiumBot
                case ads
                case apiLimitExtension
                case unsupported
                case peer(EnginePeer)
            }
            
            public let flags: Flags
            public let id: String
            public let count: CurrencyAmount
            public let date: Int32
            public let peer: Peer
            public let title: String?
            public let description: String?
            public let photo: IosappMediaWebFile?
            public let transactionDate: Int32?
            public let transactionUrl: String?
            public let paidMessageId: MessageId?
            public let giveawayMessageId: MessageId?
            public let media: [Media]
            public let subscriptionPeriod: Int32?
            public let starGift: StarGift?
            public let floodskipNumber: Int32?
            public let starrefCommissionPermille: Int32?
            public let starrefPeerId: PeerId?
            public let starrefAmount: StarsAmount?
            public let paidMessageCount: Int32?
            public let premiumGiftMonths: Int32?
            public let adsProceedsFromDate: Int32?
            public let adsProceedsToDate: Int32?
            
            public init(
                flags: Flags,
                id: String,
                count: CurrencyAmount,
                date: Int32,
                peer: Peer,
                title: String?,
                description: String?,
                photo: IosappMediaWebFile?,
                transactionDate: Int32?,
                transactionUrl: String?,
                paidMessageId: MessageId?,
                giveawayMessageId: MessageId?,
                media: [Media],
                subscriptionPeriod: Int32?,
                starGift: StarGift?,
                floodskipNumber: Int32?,
                starrefCommissionPermille: Int32?,
                starrefPeerId: PeerId?,
                starrefAmount: StarsAmount?,
                paidMessageCount: Int32?,
                premiumGiftMonths: Int32?,
                adsProceedsFromDate: Int32?,
                adsProceedsToDate: Int32?
            ) {
                self.flags = flags
                self.id = id
                self.count = count
                self.date = date
                self.peer = peer
                self.title = title
                self.description = description
                self.photo = photo
                self.transactionDate = transactionDate
                self.transactionUrl = transactionUrl
                self.paidMessageId = paidMessageId
                self.giveawayMessageId = giveawayMessageId
                self.media = media
                self.subscriptionPeriod = subscriptionPeriod
                self.starGift = starGift
                self.floodskipNumber = floodskipNumber
                self.starrefCommissionPermille = starrefCommissionPermille
                self.starrefPeerId = starrefPeerId
                self.starrefAmount = starrefAmount
                self.paidMessageCount = paidMessageCount
                self.premiumGiftMonths = premiumGiftMonths
                self.adsProceedsFromDate = adsProceedsFromDate
                self.adsProceedsToDate = adsProceedsToDate
            }
            
            public static func == (lhs: Transaction, rhs: Transaction) -> Bool {
                if lhs.flags != rhs.flags {
                    return false
                }
                if lhs.id != rhs.id {
                    return false
                }
                if lhs.count != rhs.count {
                    return false
                }
                if lhs.date != rhs.date {
                    return false
                }
                if lhs.peer != rhs.peer {
                    return false
                }
                if lhs.title != rhs.title {
                    return false
                }
                if lhs.description != rhs.description {
                    return false
                }
                if lhs.photo != rhs.photo {
                    return false
                }
                if lhs.transactionDate != rhs.transactionDate {
                    return false
                }
                if lhs.transactionUrl != rhs.transactionUrl {
                    return false
                }
                if lhs.paidMessageId != rhs.paidMessageId {
                    return false
                }
                if lhs.giveawayMessageId != rhs.giveawayMessageId {
                    return false
                }
                if !areMediaArraysEqual(lhs.media, rhs.media) {
                    return false
                }
                if lhs.subscriptionPeriod != rhs.subscriptionPeriod {
                    return false
                }
                if lhs.starGift != rhs.starGift {
                    return false
                }
                if lhs.floodskipNumber != rhs.floodskipNumber {
                    return false
                }
                if lhs.starrefCommissionPermille != rhs.starrefCommissionPermille {
                    return false
                }
                if lhs.starrefPeerId != rhs.starrefPeerId {
                    return false
                }
                if lhs.starrefAmount != rhs.starrefAmount {
                    return false
                }
                if lhs.paidMessageCount != rhs.paidMessageCount {
                    return false
                }
                if lhs.premiumGiftMonths != rhs.premiumGiftMonths {
                    return false
                }
                if lhs.adsProceedsFromDate != rhs.adsProceedsFromDate {
                    return false
                }
                if lhs.adsProceedsToDate != rhs.adsProceedsToDate {
                    return false
                }
                return true
            }
        }
        
        public struct Subscription: Equatable {
            public struct Flags: OptionSet {
                public var rawValue: Int32
                
                public init(rawValue: Int32) {
                    self.rawValue = rawValue
                }
                
                public static let isCancelled = Flags(rawValue: 1 << 0)
                public static let canRefulfill = Flags(rawValue: 1 << 1)
                public static let missingBalance = Flags(rawValue: 1 << 2)
                public static let isCancelledByBot = Flags(rawValue: 1 << 3)
            }
            
            public let flags: Flags
            public let id: String
            public let peer: EnginePeer
            public let untilDate: Int32
            public let pricing: StarsSubscriptionPricing
            public let inviteHash: String?
            public let title: String?
            public let photo: IosappMediaWebFile?
            public let invoiceSlug: String?
            
            public init(
                flags: Flags,
                id: String,
                peer: EnginePeer,
                untilDate: Int32,
                pricing: StarsSubscriptionPricing,
                inviteHash: String?,
                title: String?,
                photo: IosappMediaWebFile?,
                invoiceSlug: String?
            ) {
                self.flags = flags
                self.id = id
                self.peer = peer
                self.untilDate = untilDate
                self.pricing = pricing
                self.inviteHash = inviteHash
                self.title = title
                self.photo = photo
                self.invoiceSlug = invoiceSlug
            }
            
            public static func == (lhs: Subscription, rhs: Subscription) -> Bool {
                if lhs.flags != rhs.flags {
                    return false
                }
                if lhs.id != rhs.id {
                    return false
                }
                if lhs.peer != rhs.peer {
                    return false
                }
                if lhs.untilDate != rhs.untilDate {
                    return false
                }
                if lhs.pricing != rhs.pricing {
                    return false
                }
                if lhs.inviteHash != rhs.inviteHash {
                    return false
                }
                if lhs.title != rhs.title {
                    return false
                }
                if lhs.photo != rhs.photo {
                    return false
                }
                if lhs.invoiceSlug != rhs.invoiceSlug {
                    return false
                }
                return true
            }
        }
        
        public struct Flags: OptionSet {
            public var rawValue: Int32
            
            public init(rawValue: Int32) {
                self.rawValue = rawValue
            }
            
            public static let isPendingBalance = Flags(rawValue: 1 << 0)
        }
        
        public var flags: Flags
        public var balance: StarsAmount
        public var subscriptions: [Subscription]
        public var canLoadMoreSubscriptions: Bool
        public var transactions: [Transaction]
        public var canLoadMoreTransactions: Bool
        public var isLoading: Bool
        
        init(flags: Flags, balance: StarsAmount, subscriptions: [Subscription], canLoadMoreSubscriptions: Bool, transactions: [Transaction], canLoadMoreTransactions: Bool, isLoading: Bool) {
            self.flags = flags
            self.balance = balance
            self.subscriptions = subscriptions
            self.canLoadMoreSubscriptions = canLoadMoreSubscriptions
            self.transactions = transactions
            self.canLoadMoreTransactions = canLoadMoreTransactions
            self.isLoading = isLoading
        }
        
        public static func == (lhs: State, rhs: State) -> Bool {
            if lhs.flags != rhs.flags {
                return true
            }
            if lhs.balance != rhs.balance {
                return false
            }
            if lhs.transactions != rhs.transactions {
                return false
            }
            if lhs.subscriptions != rhs.subscriptions {
                return false
            }
            if lhs.canLoadMoreTransactions != rhs.canLoadMoreTransactions {
                return false
            }
            if lhs.isLoading != rhs.isLoading {
                return false
            }
            return true
        }
    }
    
    private let impl: QueueLocalObject<DiamondsContextImpl>
    
    public var state: Signal<DiamondsContext.State?, NoError> {
        return Signal { subscriber in
            let disposable = MetaDisposable()
            self.impl.with { impl in
                disposable.set(impl.state.start(next: { value in
                    subscriber.putNext(value)
                }))
            }
            return disposable
        }
    }
    
    var peerId: EnginePeer.Id {
        var peerId: EnginePeer.Id?
        self.impl.syncWith { impl in
            peerId = impl.peerId
        }
        return peerId!
    }
    
    public let ton: Bool
    
    public var currentState: DiamondsContext.State? {
        var state: DiamondsContext.State?
        self.impl.syncWith { impl in
            state = impl._state
        }
        return state
    }
    
    public func add(balance: StarsAmount, addTransaction: Bool = true) {
        self.impl.with {
            $0.add(balance: balance, addTransaction: addTransaction)
        }
    }
    
    fileprivate func updateBalance(_ balance: StarsAmount, transactions: [DiamondsContext.State.Transaction]?) {
        self.impl.with {
            $0.updateBalance(balance, transactions: transactions)
        }
    }
    
    
    public func load(force: Bool) {
        self.impl.with {
            $0.load(force: force)
        }
    }
    
    public var onUpdate: Signal<Void, NoError> {
        return Signal { subscriber in
            let disposable = MetaDisposable()
            self.impl.with { impl in
                disposable.set(impl.onUpdate.start(next: { value in
                    subscriber.putNext(value)
                }))
            }
            return disposable
        }
    }
    
    init(account: Account, ton: Bool) {
        self.ton = ton
        self.impl = QueueLocalObject(queue: Queue.mainQueue(), generate: {
            return DiamondsContextImpl(account: account, ton: ton)
        })
    }
}

private final class DiamondsTransactionsContextImpl {
    private let account: Account
    private weak var diamondsContext: DiamondsContext?
    fileprivate let peerId: EnginePeer.Id
    fileprivate let ton: Bool
    private let mode: DiamondsTransactionsContext.Mode
    
    fileprivate var _state: DiamondsTransactionsContext.State
    private let _statePromise = Promise<DiamondsTransactionsContext.State>()
    var state: Signal<DiamondsTransactionsContext.State, NoError> {
        return self._statePromise.get()
    }
    private var nextOffset: String? = ""
    
    private let disposable = MetaDisposable()
    private var stateDisposable: Disposable?
    
    init(account: Account, subject: DiamondsTransactionsContext.Subject, mode: DiamondsTransactionsContext.Mode) {
        assert(Queue.mainQueue().isCurrent())
        
        let currentTransactions: [DiamondsContext.State.Transaction]
        
        self.account = account
        switch subject {
        case let .diamondsTransactionsContext(transactionsContext):
            self.peerId = transactionsContext.peerId
            self.ton = transactionsContext.ton
            currentTransactions = transactionsContext.currentState?.transactions ?? []
        case let .diamondsContext(diamondsContext):
            self.diamondsContext = diamondsContext
            self.peerId = diamondsContext.peerId
            self.ton = diamondsContext.ton
            currentTransactions = diamondsContext.currentState?.transactions ?? []
        case let .peer(peerId, ton):
            self.peerId = peerId
            self.ton = ton
            currentTransactions = []
        }
        self.mode = mode
        
        let initialTransactions: [DiamondsContext.State.Transaction]
        switch mode {
        case .all:
            initialTransactions = currentTransactions
        case .incoming:
            initialTransactions = currentTransactions.filter { $0.count.amount > StarsAmount.zero }
        case .outgoing:
            initialTransactions = currentTransactions.filter { $0.count.amount < StarsAmount.zero }
        }
        
        self._state = DiamondsTransactionsContext.State(transactions: initialTransactions, canLoadMore: true, isLoading: false)
        self._statePromise.set(.single(self._state))
        
        if case let .diamondsTransactionsContext(transactionsContext) = subject {
            self.stateDisposable = (transactionsContext.state
            |> deliverOnMainQueue).start(next: { [weak self] state in
                guard let self else {
                    return
                }
                let currentTransactions = state.transactions
                let filteredTransactions: [DiamondsContext.State.Transaction]
                switch mode {
                case .all:
                    filteredTransactions = currentTransactions
                case .incoming:
                    filteredTransactions = currentTransactions.filter { $0.count.amount > StarsAmount.zero }
                case .outgoing:
                    filteredTransactions = currentTransactions.filter { $0.count.amount < StarsAmount.zero }
                }
                
                if !filteredTransactions.isEmpty && self._state.transactions.isEmpty  && filteredTransactions != initialTransactions {
                    var updatedState = self._state
                    updatedState.transactions.removeAll(where: { $0.flags.contains(.isLocal) })
                    for transaction in filteredTransactions.reversed() {
                        updatedState.transactions.insert(transaction, at: 0)
                    }
                    self.updateState(updatedState)
                }
            })
        } else if case let .diamondsContext(diamondsContext) = subject {
            self.stateDisposable = (diamondsContext.state
            |> deliverOnMainQueue).start(next: { [weak self] state in
                guard let self, let state else {
                    return
                }
                
                let currentTransactions = state.transactions
                let filteredTransactions: [DiamondsContext.State.Transaction]
                switch mode {
                case .all:
                    filteredTransactions = currentTransactions
                case .incoming:
                    filteredTransactions = currentTransactions.filter { $0.count.amount > StarsAmount.zero }
                case .outgoing:
                    filteredTransactions = currentTransactions.filter { $0.count.amount < StarsAmount.zero }
                }
                
                if filteredTransactions != initialTransactions {
                    var existingIds = Set<String>()
                    for transaction in self._state.transactions {
                        if !transaction.flags.contains(.isLocal) {
                            existingIds.insert(transaction.id)
                        }
                    }
                    
                    var updatedState = self._state
                    updatedState.transactions.removeAll(where: { $0.flags.contains(.isLocal) })
                    for transaction in filteredTransactions.reversed() {
                        if !existingIds.contains(transaction.id) {
                            updatedState.transactions.insert(transaction, at: 0)
                        }
                    }
                    self.updateState(updatedState)
                }
            })
        }
    }
    
    deinit {
        assert(Queue.mainQueue().isCurrent())
        self.disposable.dispose()
        self.stateDisposable?.dispose()
    }
    
    func loadMore(reload: Bool = false) {
        assert(Queue.mainQueue().isCurrent())
        
        if reload {
            self.nextOffset = ""
        }
        
        guard !self._state.isLoading, let nextOffset = self.nextOffset else {
            return
        }
        
        var updatedState = self._state
        updatedState.isLoading = true
        self.updateState(updatedState)
                
        self.disposable.set((_internal_requestDiamondsState(account: self.account, peerId: self.peerId, ton: self.ton, mode: self.mode, subscriptionId: nil, offset: nextOffset, limit: self.nextOffset == "" ? 25 : 50)
        |> deliverOnMainQueue).start(next: { [weak self] status in
            guard let self else {
                return
            }
            self.nextOffset = status.nextTransactionsOffset
            
            var updatedState = self._state
            updatedState.transactions = nextOffset.isEmpty ? status.transactions : updatedState.transactions + status.transactions
            updatedState.isLoading = false
            updatedState.canLoadMore = self.nextOffset != nil
            self.updateState(updatedState)
            
            if case .all = self.mode, nextOffset.isEmpty {
                self.diamondsContext?.updateBalance(status.balance, transactions: status.transactions)
            } else {
                self.diamondsContext?.updateBalance(status.balance, transactions: nil)
            }
        }))
    }
    
    private func updateState(_ state: DiamondsTransactionsContext.State) {
        self._state = state
        self._statePromise.set(.single(state))
    }
}
    
public final class DiamondsTransactionsContext {
    public struct State: Equatable {
        public var transactions: [DiamondsContext.State.Transaction]
        public var canLoadMore: Bool
        public var isLoading: Bool
        
        init(transactions: [DiamondsContext.State.Transaction], canLoadMore: Bool, isLoading: Bool) {
            self.transactions = transactions
            self.canLoadMore = canLoadMore
            self.isLoading = isLoading
        }
    }
    
    fileprivate let impl: QueueLocalObject<DiamondsTransactionsContextImpl>
    
    public enum Subject {
        case diamondsTransactionsContext(DiamondsTransactionsContext)
        case diamondsContext(DiamondsContext)
        case peer(peerId: EnginePeer.Id, ton: Bool)
    }
    
    public enum Mode {
        case all
        case incoming
        case outgoing
    }
    
    public var state: Signal<DiamondsTransactionsContext.State, NoError> {
        return Signal { subscriber in
            let disposable = MetaDisposable()
            self.impl.with { impl in
                disposable.set(impl.state.start(next: { value in
                    subscriber.putNext(value)
                }))
            }
            return disposable
        }
    }
    
    public var currentState: DiamondsTransactionsContext.State? {
        var state: DiamondsTransactionsContext.State?
        self.impl.syncWith { impl in
            state = impl._state
        }
        return state
    }
    
    public func reload() {
        self.impl.with {
            $0.loadMore(reload: true)
        }
    }
    
    public func loadMore() {
        self.impl.with {
            $0.loadMore()
        }
    }
    
    init(account: Account, subject: Subject, mode: Mode) {
        self.impl = QueueLocalObject(queue: Queue.mainQueue(), generate: {
            return DiamondsTransactionsContextImpl(account: account, subject: subject, mode: mode)
        })
    }
    
    var peerId: EnginePeer.Id {
        var peerId: EnginePeer.Id?
        self.impl.syncWith { impl in
            peerId = impl.peerId
        }
        return peerId!
    }
    
    var ton: Bool {
        var ton = false
        self.impl.syncWith { impl in
            ton = impl.ton
        }
        return ton
    }
}

private final class DiamondsSubscriptionsContextImpl {
    private let account: Account
    private let missingBalance: Bool
    
    private var _state: DiamondsSubscriptionsContext.State
    private let _statePromise = Promise<DiamondsSubscriptionsContext.State>()
    var state: Signal<DiamondsSubscriptionsContext.State, NoError> {
        return self._statePromise.get()
    }
    private var nextOffset: String? = ""
    
    private let disposable = MetaDisposable()
    private var stateDisposable: Disposable?
    private let updateDisposable = MetaDisposable()
    
    init(account: Account, diamondsContext: DiamondsContext?, missingBalance: Bool) {
        assert(Queue.mainQueue().isCurrent())
        
        self.account = account
        self.missingBalance = missingBalance
        
        let currentSubscriptions = diamondsContext?.currentState?.subscriptions ?? []
        let canLoadMore = diamondsContext?.currentState?.canLoadMoreSubscriptions ?? true
        
        self._state = DiamondsSubscriptionsContext.State(balance: StarsAmount.zero, subscriptions: currentSubscriptions, canLoadMore: canLoadMore, isLoading: false)
        self._statePromise.set(.single(self._state))
        
        self.loadMore()
    }
    
    deinit {
        assert(Queue.mainQueue().isCurrent())
        self.disposable.dispose()
        self.stateDisposable?.dispose()
        self.updateDisposable.dispose()
    }
    
    func loadMore() {
        assert(Queue.mainQueue().isCurrent())
        
        guard !self._state.isLoading, let nextOffset = self.nextOffset else {
            return
        }
        
        var updatedState = self._state
        updatedState.isLoading = true
        self.updateState(updatedState)
                
        self.disposable.set((_internal_requestDiamondsSubscriptions(account: self.account, peerId: self.account.peerId, offset: nextOffset, missingBalance: self.missingBalance)
        |> deliverOnMainQueue).start(next: { [weak self] status in
            guard let self else {
                return
            }

            self.nextOffset = status.nextSubscriptionsOffset
            
            var updatedState = self._state
            updatedState.balance = status.subscriptionsMissingBalance ?? StarsAmount.zero
            updatedState.subscriptions = nextOffset.isEmpty ? status.subscriptions : updatedState.subscriptions + status.subscriptions
            updatedState.isLoading = false
            updatedState.canLoadMore = self.nextOffset != nil
            self.updateState(updatedState)
        }))
    }
    
    private func updateState(_ state: DiamondsSubscriptionsContext.State) {
        self._state = state
        self._statePromise.set(.single(state))
    }
    
    func updateSubscription(id: String, cancel: Bool) {
        var updatedState = self._state
        if let index = updatedState.subscriptions.firstIndex(where: { $0.id == id }) {
            let subscription = updatedState.subscriptions[index]
            var updatedFlags = subscription.flags
            if cancel {
                updatedFlags.insert(.isCancelled)
            } else {
                updatedFlags.remove(.isCancelled)
            }
            let updatedSubscription = DiamondsContext.State.Subscription(flags: updatedFlags, id: subscription.id, peer: subscription.peer, untilDate: subscription.untilDate, pricing: subscription.pricing, inviteHash: subscription.inviteHash, title: subscription.title, photo: subscription.photo, invoiceSlug: subscription.invoiceSlug)
            updatedState.subscriptions[index] = updatedSubscription
        }
        self.updateState(updatedState)
        self.updateDisposable.set(_internal_updateDiamondsSubscription(account: self.account, peerId: self.account.peerId, subscriptionId: id, cancel: cancel).startStrict())
    }
    
    private var previousLoadTimestamp: Double?
    func load(force: Bool) {
        assert(Queue.mainQueue().isCurrent())
        
        guard !self._state.isLoading else {
            return
        }
        
        let currentTimestamp = CFAbsoluteTimeGetCurrent()
        if let previousLoadTimestamp = self.previousLoadTimestamp, currentTimestamp - previousLoadTimestamp < 60 && !force {
            return
        }
        self.previousLoadTimestamp = currentTimestamp
        self._state.isLoading = true
        
        self.disposable.set((_internal_requestDiamondsSubscriptions(account: self.account, peerId: self.account.peerId, offset: "", missingBalance: self.missingBalance)
        |> deliverOnMainQueue).start(next: { [weak self] status in
            guard let self else {
                return
            }
            self.nextOffset = status.nextSubscriptionsOffset
            
            var updatedState = self._state
            updatedState.subscriptions = status.subscriptions
            updatedState.isLoading = false
            updatedState.canLoadMore = self.nextOffset != nil
            self.updateState(updatedState)
        }))
    }
}
    
public final class DiamondsSubscriptionsContext {
    public struct State: Equatable {
        public var balance: StarsAmount
        public var subscriptions: [DiamondsContext.State.Subscription]
        public var canLoadMore: Bool
        public var isLoading: Bool
        
        init(balance: StarsAmount, subscriptions: [DiamondsContext.State.Subscription], canLoadMore: Bool, isLoading: Bool) {
            self.balance = balance
            self.subscriptions = subscriptions
            self.canLoadMore = canLoadMore
            self.isLoading = isLoading
        }
    }
    
    fileprivate let impl: QueueLocalObject<DiamondsSubscriptionsContextImpl>
        
    public var state: Signal<DiamondsSubscriptionsContext.State, NoError> {
        return Signal { subscriber in
            let disposable = MetaDisposable()
            self.impl.with { impl in
                disposable.set(impl.state.start(next: { value in
                    subscriber.putNext(value)
                }))
            }
            return disposable
        }
    }
    
    public func loadMore() {
        self.impl.with {
            $0.loadMore()
        }
    }
    
    init(account: Account, diamondsContext: DiamondsContext?, missingBalance: Bool) {
        self.impl = QueueLocalObject(queue: Queue.mainQueue(), generate: {
            return DiamondsSubscriptionsContextImpl(account: account, diamondsContext: diamondsContext, missingBalance: missingBalance)
        })
    }
    
    public func updateSubscription(id: String, cancel: Bool) {
        self.impl.with {
            $0.updateSubscription(id: id, cancel: cancel)
        }
    }
    
    public func load(force: Bool) {
        self.impl.with {
            $0.load(force: force)
        }
    }
}


func _internal_sendDiamondsPaymentForm(account: Account, formId: Int64, source: BotPaymentInvoiceSource) -> Signal<SendBotPaymentResult, SendBotPaymentFormError> {
    return account.postbox.transaction { transaction -> Api.InputInvoice? in
        return _internal_parseInputInvoice(transaction: transaction, source: source)
    }
    |> castError(SendBotPaymentFormError.self)
    |> mapToSignal { invoice -> Signal<SendBotPaymentResult, SendBotPaymentFormError> in
        guard let invoice = invoice else {
            return .fail(.generic)
        }
        return account.network.request(Api.functions.payments.sendStarsForm(formId: formId, invoice: invoice))
        |> map { result -> SendBotPaymentResult in
            switch result {
                case let .paymentResult(paymentResultData):
                    let updates = paymentResultData.updates
                    account.stateManager.addUpdates(updates)
                
                    switch source {
                    case .diamondsChatSubscription:
                        let chats = updates.chats.compactMap { parseIosappGroupOrChannel(chat: $0) }
                        if let first = chats.first {
                            return .done(receiptMessageId: nil, subscriptionPeerId: first.id, uniqueStarGift: nil)
                        }
                    default:
                        break
                    }
                    var receiptMessageId: MessageId?
                    var resultGift: ProfileGiftsContext.State.StarGift?
                    for apiMessage in updates.messages {
                        if let message = StoreMessage(apiMessage: apiMessage, accountPeerId: account.peerId, peerIsForum: false) {
                            for media in message.media {
                                if let action = media as? IosappMediaAction {
                                    if case .paymentSent = action.action {
                                        switch source {
                                        case let .slug(slug):
                                            for media in message.media {
                                                if let action = media as? IosappMediaAction, case let .paymentSent(_, _, invoiceSlug?, _, _) = action.action, invoiceSlug == slug {
                                                    if case let .Id(id) = message.id {
                                                        receiptMessageId = id
                                                    }
                                                }
                                            }
                                        case let .message(messageId):
                                            for attribute in message.attributes {
                                                if let reply = attribute as? ReplyMessageAttribute {
                                                    if reply.messageId == messageId {
                                                        if case let .Id(id) = message.id {
                                                            receiptMessageId = id
                                                        }
                                                    }
                                                }
                                            }
                                        case let .premiumGiveaway(_, _, _, _, _, _, randomId, _, _, _, _):
                                            if message.globallyUniqueId == randomId {
                                                if case let .Id(id) = message.id {
                                                    receiptMessageId = id
                                                }
                                            }
                                        case let .diamondsGiveaway(_, _, _, _, _, _, _, randomId, _, _, _, _):
                                            if message.globallyUniqueId == randomId {
                                                if case let .Id(id) = message.id {
                                                    receiptMessageId = id
                                                }
                                            }
                                        case .giftCode, .stars, .diamondsGift, .diamondsChatSubscription, .starGift, .diamondGiftUpgrade, .diamondGiftTransfer, .premiumGift, .diamondGiftResale, .diamondGiftPrepaidUpgrade, .diamondGiftDropOriginalDetails, .diamondGiftAuctionBid:
                                            receiptMessageId = nil
                                        }
                                    } else if case let .starGiftUnique(gift, _, _, savedToProfile, canExportDate, transferStars, isRefunded, _, peerId, _, savedId, _, canTransferDate, canResaleDate, dropOriginalDetailsStars, _, _, canCraftAt, _) = action.action, case let .Id(messageId) = message.id {
                                        let reference: DiamondGiftReference
                                        if let peerId, let savedId {
                                            reference = .peer(peerId: peerId, id: savedId)
                                        } else {
                                            reference = .message(messageId: messageId)
                                        }
                                        resultGift = ProfileGiftsContext.State.StarGift(
                                            gift: gift,
                                            reference: reference,
                                            fromPeer: nil,
                                            date: message.timestamp,
                                            text: nil,
                                            entities: nil,
                                            nameHidden: false,
                                            savedToProfile: savedToProfile,
                                            pinnedToTop: false,
                                            convertStars: nil,
                                            canUpgrade: false,
                                            canExportDate: canExportDate,
                                            upgradeStars: nil,
                                            transferStars: transferStars,
                                            canTransferDate: canTransferDate,
                                            canResaleDate: canResaleDate,
                                            collectionIds: nil,
                                            prepaidUpgradeHash: nil,
                                            upgradeSeparate: false,
                                            dropOriginalDetailsStars: dropOriginalDetailsStars,
                                            number: nil,
                                            isRefunded: isRefunded,
                                            canCraftAt: canCraftAt
                                        )
                                    }
                                }
                            }
                        }
                    }
                    return .done(receiptMessageId: receiptMessageId, subscriptionPeerId: nil, uniqueStarGift: resultGift)
                case let .paymentVerificationNeeded(paymentVerificationNeededData):
                    let url = paymentVerificationNeededData.url
                    return .externalVerificationRequired(url: url)
            }
        }
        |> `catch` { error -> Signal<SendBotPaymentResult, SendBotPaymentFormError> in
            if error.errorCode == 406 {
                return .fail(.serverProvided(error.errorDescription))
            } else if error.errorDescription == "BOT_PRECHECKOUT_FAILED" {
                return .fail(.precheckoutFailed)
            } else if error.errorDescription == "PAYMENT_FAILED" {
                return .fail(.paymentFailed)
            } else if error.errorDescription == "INVOICE_ALREADY_PAID" {
                return .fail(.alreadyPaid)
            } else if error.errorDescription == "MEDIA_ALREADY_PAID" {
                return .fail(.alreadyPaid)
            } else if error.errorDescription == "STARGIFT_USAGE_LIMITED" {
                return .fail(.diamondGiftOutOfStock)
            } else if error.errorDescription == "STARGIFT_USER_USAGE_LIMITED" {
                return .fail(.diamondGiftUserLimit)
            }
            return .fail(.generic)
        }
    }
}

public struct DiamondsTransactionReference: PostboxCoding, Hashable, Equatable {
    public let peerId: EnginePeer.Id
    public let ton: Bool
    public let id: String
    public let isRefund: Bool
    
    public init(peerId: EnginePeer.Id, ton: Bool, id: String, isRefund: Bool) {
        self.peerId = peerId
        self.ton = ton
        self.id = id
        self.isRefund = isRefund
    }
    
    public init(decoder: PostboxDecoder) {
        self.peerId = EnginePeer.Id(decoder.decodeInt64ForKey("peerId", orElse: 0))
        self.ton = decoder.decodeBoolForKey("ton", orElse: false)
        self.id = decoder.decodeStringForKey("id", orElse: "")
        self.isRefund = decoder.decodeBoolForKey("refund", orElse: false)
    }
    
    public func encode(_ encoder: PostboxEncoder) {
        encoder.encodeInt64(self.peerId.toInt64(), forKey: "peerId")
        encoder.encodeBool(self.ton, forKey: "ton")
        encoder.encodeString(self.id, forKey: "id")
        encoder.encodeBool(self.isRefund, forKey: "refund")
    }
}

func _internal_getDiamondsTransaction(accountPeerId: PeerId, postbox: Postbox, network: Network, transactionReference: DiamondsTransactionReference) -> Signal<DiamondsContext.State.Transaction?, NoError> {
    return postbox.transaction { transaction -> Api.InputPeer? in
        return transaction.getPeer(transactionReference.peerId).flatMap(apiInputPeer)
    }
    |> mapToSignal { inputPeer -> Signal<DiamondsContext.State.Transaction?, NoError> in
        guard let inputPeer else {
            return .single(nil)
        }
        return network.request(
            Api.functions.payments.getStarsTransactionsByID(
                flags: transactionReference.ton ? 1 << 0 : 0,
                peer: inputPeer,
                id: [.inputStarsTransaction(.init(flags: transactionReference.isRefund ? (1 << 0) : 0, id: transactionReference.id))]
            )
        )
        |> map(Optional.init)
        |> `catch` { _ -> Signal<Api.payments.StarsStatus?, NoError> in
            return .single(nil)
        }
        |> mapToSignal { result -> Signal<DiamondsContext.State.Transaction?, NoError> in
            return postbox.transaction { transaction -> DiamondsContext.State.Transaction? in
                guard let result, case let .starsStatus(diamondsStatusData) = result, let matchingTransaction = diamondsStatusData.history?.first else {
                    return nil
                }
                let (_, _, _, _, _, transactions, _, chats, users) = (diamondsStatusData.flags, diamondsStatusData.balance, diamondsStatusData.subscriptions, diamondsStatusData.subscriptionsNextOffset, diamondsStatusData.subscriptionsMissingBalance, diamondsStatusData.history, diamondsStatusData.nextOffset, diamondsStatusData.chats, diamondsStatusData.users)
                let _ = transactions
                let peers = AccumulatedPeers(chats: chats, users: users)
                updatePeers(transaction: transaction, accountPeerId: accountPeerId, peers: peers)
                
                return DiamondsContext.State.Transaction(apiTransaction: matchingTransaction, peerId: transactionReference.peerId, transaction: transaction)
            }
        }
    }
}

public struct StarsSubscriptionPricing: Codable, Equatable {
    private enum CodingKeys: String, CodingKey {
        case period
        case amount
        case starsAmount
    }
    
    public let period: Int32
    public let amount: StarsAmount
    
    public init(period: Int32, amount: StarsAmount) {
        self.period = period
        self.amount = amount
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.period = try container.decode(Int32.self, forKey: .period)
        
        if let legacyAmount = try container.decodeIfPresent(Int64.self, forKey: .amount) {
            self.amount = StarsAmount(value: legacyAmount, nanos: 0)
        } else {
            self.amount = try container.decode(StarsAmount.self, forKey: .starsAmount)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.period, forKey: .period)
        try container.encode(self.amount, forKey: .starsAmount)
    }
    
    public static let monthPeriod: Int32 = 2592000
    public static let testPeriod: Int32 = 300
}

extension StarsSubscriptionPricing {
    init(apiDiamondsSubscriptionPricing: Api.StarsSubscriptionPricing) {
        switch apiDiamondsSubscriptionPricing {
        case let .starsSubscriptionPricing(diamondsSubscriptionPricingData):
            let (period, amount) = (diamondsSubscriptionPricingData.period, diamondsSubscriptionPricingData.amount)
            self = .init(period: period, amount: StarsAmount(value: amount, nanos: 0))
        }
    }

    var apiDiamondsSubscriptionPricing: Api.StarsSubscriptionPricing {
        return .starsSubscriptionPricing(.init(period: self.period, amount: self.amount.value))
    }
}

public enum UpdateDiamondsSubsciptionError {
    case generic
}

func _internal_updateDiamondsSubscription(account: Account, peerId: EnginePeer.Id, subscriptionId: String, cancel: Bool) -> Signal<Never, UpdateDiamondsSubsciptionError> {
    return account.postbox.transaction { transaction -> Api.InputPeer? in
        return transaction.getPeer(peerId).flatMap(apiInputPeer)
    }
    |> castError(UpdateDiamondsSubsciptionError.self)
    |> mapToSignal { inputPeer -> Signal<Never, UpdateDiamondsSubsciptionError> in
        guard let inputPeer else {
            return .complete()
        }
        let flags: Int32 = (1 << 0)
        return account.network.request(Api.functions.payments.changeStarsSubscription(flags: flags, peer: inputPeer, subscriptionId: subscriptionId, canceled: cancel ? .boolTrue : .boolFalse))
        |> mapError { _ -> UpdateDiamondsSubsciptionError in
            return .generic
        }
        |> ignoreValues
    }
}

public enum FulfillDiamondsSubsciptionError {
    case generic
}

func _internal_fulfillDiamondsSubscription(account: Account, peerId: EnginePeer.Id, subscriptionId: String) -> Signal<Never, FulfillDiamondsSubsciptionError> {
    return account.postbox.transaction { transaction -> Api.InputPeer? in
        return transaction.getPeer(peerId).flatMap(apiInputPeer)
    }
    |> castError(FulfillDiamondsSubsciptionError.self)
    |> mapToSignal { inputPeer -> Signal<Never, FulfillDiamondsSubsciptionError> in
        guard let inputPeer else {
            return .complete()
        }
        return account.network.request(Api.functions.payments.fulfillStarsSubscription(peer: inputPeer, subscriptionId: subscriptionId))
        |> mapError { _ -> FulfillDiamondsSubsciptionError in
            return .generic
        }
        |> ignoreValues
    }
}
