//
//  NetworkClient.swift
//  nesine_adilkutanq
//
//  Created by Adil Kutan Çıngısız on 4.09.2023.
//

import Foundation

class Network {
    
    func search(term: String, completion: @escaping ([Software]?) -> Void) {
        if let url = URL(string: "https://itunes.apple.com/search?term=\(term)&media=software") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                    completion(nil)
                    return
                }
                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    print("Server error")
                    completion(nil)
                    return
                }
                guard let data = data else {
                    print("No data received")
                    completion(nil)
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let searchResult = try decoder.decode(SearchResultList.self, from: data)
                    completion(searchResult.results)
                } catch {
                    print("Error decoding JSON: \(error)")
                    completion(nil)
                }
            }
            task.resume()
        } else {
            completion(nil)
        }
    }
    
    
}
