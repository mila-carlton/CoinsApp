//
//  MarketModel.swift
//  CoinsApp
//
//  Created by PASGON TEXTILE on 31.01.24.
//

import Foundation

struct MarketList: Decodable {
    let result: [Market]?
}

struct Market: Decodable {
    let exchange: String?
    let pair: String?
    let price: Double?
}
