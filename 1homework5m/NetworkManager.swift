//
//  NetworkManager.swift
//  1homework5m
//
//  Created by mavluda on 17/5/23.
//

import Foundation

class NetworkManager{
    
    static let shared = NetworkManager()
    
    private init(){}
    
    func downloadProductsWithCompletion(completed: @escaping([Product]) -> ()) {
        let url = URL(string: "https://dummyjson.com/products")
        
        URLSession.shared.dataTask(with: url!) { (data, urlResponse, error) in
            if error == nil {
                do {
                    let response = try JSONDecoder().decode(Products.self, from: data!)
                    print("SUCCESS")
                    DispatchQueue.main.async {
                        completed(response.products)
                    }
                } catch {
                    print("JSON Error")
                    print(error.localizedDescription)
                }
            }
        }.resume()
        
    }
    
}
