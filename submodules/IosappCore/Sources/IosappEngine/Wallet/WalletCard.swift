import Foundation
import Postbox
import SwiftSignalKit
internal import IosappApi

public struct WalletCard: Codable, Equatable, Sendable {
    public struct InputSticker: Codable, Equatable, Sendable {
        public let coordinates: MediaArea.Coordinates
        public let nftAddress: String

        public init(coordinates: MediaArea.Coordinates, nftAddress: String) {
            self.coordinates = coordinates
            self.nftAddress = nftAddress
        }
    }

    public struct Sticker: Codable, Equatable, Sendable {
        public let coordinates: MediaArea.Coordinates
        public let nft: WalletNftItem

        public init(coordinates: MediaArea.Coordinates, nft: WalletNftItem) {
            self.coordinates = coordinates
            self.nft = nft
        }
    }

    public let address: String
    public let balance: Int64
    public let stickers: [Sticker]
    public let backgroundNft: WalletNftItem?

    public init(address: String, balance: Int64, stickers: [Sticker], backgroundNft: WalletNftItem? = nil) {
        self.address = address
        self.balance = balance
        self.stickers = stickers
        self.backgroundNft = backgroundNft
    }

    init(apiCard: Api.wallet.Card) {
        switch apiCard {
        case let .card(data):
            self.init(address: data.address, balance: data.balance, stickers: (data.stickers ?? []).map { sticker in
                switch sticker {
                case let .cardSticker(data):
                    switch data.coordinates {
                    case let .mediaAreaCoordinates(c):
                        return Sticker(coordinates: .init(x: c.x, y: c.y, width: c.w, height: c.h,
                            rotation: c.rotation, cornerRadius: c.radius), nft: WalletNftItem(apiItem: data.nft))
                    }
                }
            }, backgroundNft: data.bgNftItem.map { WalletNftItem(apiItem: $0) })
        }
    }
}

