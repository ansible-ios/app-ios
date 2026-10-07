//
//  GiftResalePrice.swift
//  tl2swift
//
//  Generated automatically. Any changes will be lost!
//  Based on TDLib 1.8.64-49b3bcbb-49b3bcbb
//  https://github.com/tdlib/td/tree/49b3bcbb
//

import Foundation


/// Describes price of a resold gift
public indirect enum GiftResalePrice: Codable, Equatable, Hashable {

    /// Describes price of a resold gift in Iosapp Stars
    case giftResalePriceDiamond(GiftResalePriceDiamond)

    /// Describes price of a resold gift in Toncoins
    case giftResalePriceTon(GiftResalePriceTon)

    /// Decoded when the @type is not one of the known cases (forward-compatible).
    case unsupported

    private enum Kind: String, Codable {
        case giftResalePriceDiamond
        case giftResalePriceTon
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DtoCodingKeys.self)
        let typeString = try container.decode(String.self, forKey: .type)
        guard let type = Kind(rawValue: typeString) else {
            self = .unsupported
            return
        }
        switch type {
        case .giftResalePriceDiamond:
            let value = try GiftResalePriceDiamond(from: decoder)
            self = .giftResalePriceDiamond(value)
        case .giftResalePriceTon:
            let value = try GiftResalePriceTon(from: decoder)
            self = .giftResalePriceTon(value)
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: DtoCodingKeys.self)
        switch self {
        case .giftResalePriceDiamond(let value):
            try container.encode(Kind.giftResalePriceDiamond, forKey: .type)
            try value.encode(to: encoder)
        case .giftResalePriceTon(let value):
            try container.encode(Kind.giftResalePriceTon, forKey: .type)
            try value.encode(to: encoder)
        case .unsupported:
            try container.encode("unsupported", forKey: .type)
        }
    }
}

/// Describes price of a resold gift in Iosapp Stars
public struct GiftResalePriceDiamond: Codable, Equatable, Hashable {

    /// The Iosapp Star amount expected to be paid for the gift. Must be in the range getOption("gift_resale_star_count_min")-getOption("gift_resale_star_count_max") for gifts put for resale
    public let diamondCount: Int64


    public init(diamondCount: Int64) {
        self.diamondCount = diamondCount
    }
}

/// Describes price of a resold gift in Toncoins
public struct GiftResalePriceTon: Codable, Equatable, Hashable {

    /// The amount of 1/100 of Toncoin expected to be paid for the gift. Must be in the range getOption("gift_resale_toncoin_cent_count_min")-getOption("gift_resale_toncoin_cent_count_max")
    public let toncoinCentCount: Int64


    public init(toncoinCentCount: Int64) {
        self.toncoinCentCount = toncoinCentCount
    }
}

