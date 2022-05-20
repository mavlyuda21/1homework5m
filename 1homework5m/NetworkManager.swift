//
//  NetworkManager.swift
//  1homework5m
//
//  Created by mavluda on 17/5/23.
//

import Foundation

class NetworkManager{
    
    static let shared = NetworkManager()
    
    private let url = URL(string: "https://dummyjson.com/products")
    
    private init(){}
    
    func downloadProductsWithAsyncAwait() async throws -> [Product]{
            let response = try await URLSession.shared.data(from: url!)
            if let result = try JSONDecoder().decode(Products?.self, from: response.0)?.products{
                return result
            }else{
                throw URLError(.zeroByteResource)
            }
        }
    
}
