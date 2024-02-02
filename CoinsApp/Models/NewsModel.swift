//
//  NewsModel.swift
//  CoinsApp
//
//  Created by PASGON TEXTILE on 01.02.24.
//

import Foundation

struct NewsResponse: Decodable {
    let result: [NewArticle]?
}

struct NewArticle: Decodable {
    let source: String?
    let title: String?
    let imageUrl: String?
}
