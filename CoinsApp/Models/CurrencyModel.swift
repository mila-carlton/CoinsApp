//
//  CurrencyModel.swift
//  CoinsApp
//
//  Created by PASGON TEXTILE on 01.02.24.
//

import Foundation

struct Currency: Decodable {
    let name: String?
    let rate: Double?
    let symbol: String?
    let imageUrl: String?
}
