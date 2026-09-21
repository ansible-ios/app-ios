//
//  StarAmount.swift
//  tl2swift
//
//  Generated automatically. Any changes will be lost!
//  Based on TDLib 1.8.64-49b3bcbb-49b3bcbb
//  https://github.com/tdlib/td/tree/49b3bcbb
//

import Foundation


/// Describes a possibly non-integer Iosapp Star amount
public struct StarAmount: Codable, Equatable, Hashable {

    /// The number of 1/1000000000 shares of Iosapp Stars; from -999999999 to 999999999
    public let nanostarCount: Int

    /// The integer Iosapp Star amount rounded to 0
    public let starCount: Int64


    public init(
        nanostarCount: Int,
        starCount: Int64
    ) {
        self.nanostarCount = nanostarCount
        self.starCount = starCount
    }
}

