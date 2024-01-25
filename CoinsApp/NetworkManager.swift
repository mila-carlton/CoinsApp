//
//  NetworkManager.swift
//  CoinsApp
//
//  Created by PASGON TEXTILE on 23.01.24.
//

import Foundation

let url = URL(string: "https://openapiv1.coinstats.app/coins")!
let urlExch = URL(string: "https://openapiv1.coinstats.app/tickers/exchanges")!

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchCoins(url: String, completion: @escaping([Coin]) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _ , error in
            guard let data = data else { return }
            
            do {
                let coin = try JSONDecoder().decode(CoinsList.self, from: data)
                DispatchQueue.main.async {
                    completion(coin.result)
                }
            } catch {
                print(error.localizedDescription)
            }
        } .resume()
    }
    
    func fetchImage(from url: String, completion: @escaping(Data) -> Void) {
        guard let url = URL(string: url) else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                completion(imageData)
            }
        }
    }
}

extension NetworkManager {
    
    func fetchExchange(url: String, completion: @escaping([Exchange]) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { print("No data")
                return }
            do {
                let exch = try JSONDecoder().decode([Exchange].self, from: data)
                DispatchQueue.main.async {
                    completion(exch)
                }
            } catch {
                print(error.localizedDescription)
                if let decodingEr = error as? DecodingError {
                    print(decodingEr)
                }
            }
        } .resume()
    }
}
