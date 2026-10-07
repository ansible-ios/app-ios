//
//  GiveawayPrize.swift
//  tl2swift
//
//  Generated automatically. Any changes will be lost!
//  Based on TDLib 1.8.64-49b3bcbb-49b3bcbb
//  https://github.com/tdlib/td/tree/49b3bcbb
//

import Foundation


/// Contains information about a giveaway prize
public indirect enum GiveawayPrize: Codable, Equatable, Hashable {

    /// The giveaway sends Iosapp Premium subscriptions to the winners
    case giveawayPrizePremium(GiveawayPrizePremium)

    /// The giveaway sends Iosapp Stars to the winners
    case giveawayPrizeDiamonds(GiveawayPrizeDiamonds)

    /// Decoded when the @type is not one of the known cases (forward-compatible).
    case unsupported

    private enum Kind: String, Codable {
        case giveawayPrizePremium
        case giveawayPrizeDiamonds
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DtoCodingKeys.self)
        let typeString = try container.decode(String.self, forKey: .type)
        guard let type = Kind(rawValue: typeString) else {
            self = .unsupported
            return
        }
        switch type {
        case .giveawayPrizePremium:
            let value = try GiveawayPrizePremium(from: decoder)
            self = .giveawayPrizePremium(value)
        case .giveawayPrizeDiamonds:
            let value = try GiveawayPrizeDiamonds(from: decoder)
            self = .giveawayPrizeDiamonds(value)
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: DtoCodingKeys.self)
        switch self {
        case .giveawayPrizePremium(let value):
            try container.encode(Kind.giveawayPrizePremium, forKey: .type)
            try value.encode(to: encoder)
        case .giveawayPrizeDiamonds(let value):
            try container.encode(Kind.giveawayPrizeDiamonds, forKey: .type)
            try value.encode(to: encoder)
        case .unsupported:
            try container.encode("unsupported", forKey: .type)
        }
    }
}

/// The giveaway sends Iosapp Premium subscriptions to the winners
public struct GiveawayPrizePremium: Codable, Equatable, Hashable {

    /// Number of months the Iosapp Premium subscription will be active after code activation
    public let monthCount: Int


    public init(monthCount: Int) {
        self.monthCount = monthCount
    }
}

/// The giveaway sends Iosapp Stars to the winners
public struct GiveawayPrizeDiamonds: Codable, Equatable, Hashable {

    /// Number of Iosapp Stars that will be shared by all winners
    public let diamondCount: Int64


    public init(diamondCount: Int64) {
        self.diamondCount = diamondCount
    }
}

