//
//  WebService.swift
//  CoinsApp
//
//  Created by PASGON TEXTILE on 26.01.24.
//

import Foundation

final class WebService {
    
    static let shared = WebService()
    init() {}
 
    func fetchCoins(completion: @escaping (([Coin]?) -> Void) ) {
        let url = URL(string: "https://openapiv1.coinstats.app/coins")!
        NetworkRequest.shared.requestAPI(type: CoinsList.self, url: url.absoluteString) { result in
            switch result {
            case .success(let coins):
                completion(coins.result ?? [])
            case .failure(let errorrr):
                print(errorrr)
                completion(nil)
            }
        }
        
    }
    
    func fetchExchanges(completion: @escaping ([Exchange]?)-> Void ) {
        let url = URL(string: "https://openapiv1.coinstats.app/tickers/exchanges")!
    
        NetworkRequest.shared.requestAPI(type: [Exchange].self, url: url.absoluteString) { result in
            switch result {
            case .success(let exchanges):
                completion(exchanges)
            case .failure(let errorrr):
                print(errorrr)
                completion(nil)
            }
        }

    }

    func fetchMarkets(completion: @escaping(([Market]?) -> Void)) {
        let url = URL(string: "https://openapiv1.coinstats.app/tickers/markets")!
        NetworkRequest.shared.requestAPI(type: MarketList.self, url: url.absoluteString) { result in
            switch result {
            case .success(let markets):
                completion(markets.result ?? [])
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
    }
    
}
