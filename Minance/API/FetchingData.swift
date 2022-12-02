//
//  FetchingData.swift
//  Minance
//
//  Created by Soyombo Mantaagiin on 29.11.2022.
//

import Foundation


class FetchingData {
    
    static let shared = FetchingData()
    
    init() {}
    
    public func parseData(completion: @escaping (Result<[Coin], Error>) -> Void) {
        
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=50&page=1&sparkline=false&price_change_percentage=1"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error appeared: \(error.localizedDescription)")
                return
            }

            guard let data = data else { return }
            
            do {
                let coins = try JSONDecoder().decode([Coin].self, from: data)
                completion(.success(coins))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}
