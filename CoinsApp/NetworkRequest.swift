//
//  NetworkRequest.swift
//  CoinsApp
//
//  Created by PASGON TEXTILE on 23.01.24.
//

import Foundation

let apiKey = "gdcdNnFcQyGKjipZlWc6VYQsxhv33QVsyZmWuR9MXp4="

class NetworkRequest {
    
    static let shared = NetworkRequest()
    
    func requestAPI<T: Decodable>(type: T.Type, url: String, method: NetworkMethod = .get, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string: url) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = ["X-API-KEY": apiKey]
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            if let jsonData = data {
                self.parse(value: jsonData, completion: completion)
            }
            
        }.resume()
    }
    
    func parse<T: Decodable>(value: Data, completion: @escaping (Result<T, Error>) -> Void) {
        do {
            let jsonData = try JSONDecoder().decode(T.self, from: value)
            completion(.success(jsonData))
        } catch {
            completion(.failure(error))
        }
    }
}

enum NetworkMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
}
