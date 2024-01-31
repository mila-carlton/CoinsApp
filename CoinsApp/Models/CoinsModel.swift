//
//  CoinsModel.swift
//  CoinsApp
//
//  Created by PASGON TEXTILE on 23.01.24.
//

import Foundation

struct CoinsList: Decodable {
    let result: [Coin]?
}

struct Coin: Decodable {
    let icon: String?
    let name: String?
    let symbol: String?
    let price: Double?
    let priceChange1d: Double?
}
