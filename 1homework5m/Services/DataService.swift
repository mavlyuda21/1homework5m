//
//  DataService.swift
//  1homework5m
//
//  Created by mavluda on 28/5/23.
//

import Foundation

class DataService{
    
    static let shared = DataService()
    
    private init(){}
    
    private lazy var productsArray = { [Product]() }()
    
    private lazy var typesArray = { ["Delivery","Pickup","Catering","Curbside"] }()
    
    private let circles = [
        Circle(name: "Takeaways", image: "1"),
        Circle(name: "Grocery", image: "2"),
        Circle(name: "Convenience", image: "3"),
        Circle(name: "Pharmacy", image: "4")
    ]
    
    func getProduct(_ index: Int) -> Product{
        return productsArray[index]
    }
    
    func getType(_ index: Int) -> String{
        return typesArray[index]
    }
    
    func loadProducts(_ products:[Product]){
        self.productsArray = products
    }
    
    func getCircle(_ index: Int) -> Circle{
        return circles[index]
    }
    
    func getCircleCount() -> Int{
        return circles.count
    }
    
    func getProductsCount() -> Int{
        return productsArray.count
    }
    
    func getTypesCount() -> Int{
        return typesArray.count
    }
}
