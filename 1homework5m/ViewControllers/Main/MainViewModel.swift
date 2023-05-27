//
//  MainViewModel.swift
//  1homework5m
//
//  Created by mavluda on 28/5/23.
//

import Foundation

protocol UpdateUIDelegate: AnyObject{
    func updateUI()
}

class MainViewModel{
    
    weak var delegate: UpdateUIDelegate? = nil
    
    init(delegate: UpdateUIDelegate) {
        self.delegate = delegate
    }
    
    init(){
    }
    
    func loadProductsWithCompletion(){
        NetworkService.shared.downloadProductsWithCompletion { products in
            DataService.shared.loadProducts(products)
            self.delegate?.updateUI()
            //self.openTitle.text = "\(products.count) stores Open"
        }
    }
    
    func loadProductsWithAsyncAwait(){
        Task {
            let result = try await NetworkService.shared.downloadProductsWithAsyncAwait()
            DataService.shared.loadProducts(result)
            delegate?.updateUI()
            //self.openTitle.text = "\(products.count) stores Open"
        }
    }
    
    func updateUI(){
        delegate?.updateUI()
    }
    
    func getProductTitle(_ index: Int) -> String{
        if index == DataService.shared.getProductsCount() - 1{
            updateUI()
        }
        return DataService.shared.getProduct(index).title
    }
    
    func getProductImage(_ index: Int) -> String{
        return DataService.shared.getProduct(index).images.randomElement() ?? "star.fill"
    }
    
    func getProductRating(_ index: Int) -> Double{
        return DataService.shared.getProduct(index).rating
    }
    
    func getProductCategory(_ index: Int) -> String{
        return DataService.shared.getProduct(index).category
    }
    
    func getType(_ index: Int) -> String{
        return DataService.shared.getType(index)
    }
    
    func getCircleTitle(_ index: Int) -> String{
        return DataService.shared.getCircle(index).name
    }
    
    func getCircleImage(_ index: Int) -> String{
        return DataService.shared.getCircle(index).image
    }
    
    func getCircleCount() -> Int{
        return DataService.shared.getCircleCount()
    }
    
    func getProductsCount() -> Int{
        return DataService.shared.getProductsCount()
    }
    
    func getTypesCount() -> Int{
        return DataService.shared.getTypesCount()
    }
    
    
    
}
