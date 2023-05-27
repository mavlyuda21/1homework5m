//
//  DefaultsManager.swift
//  1homework5m
//
//  Created by mavluda on 28/5/23.
//

import Foundation

class DefaultsManager: UserDefaults{
    
    static let shared = DefaultsManager()
    
    func setAuth(_ value: Bool){
        setValue(value, forKey: "Auth")
    }
    
    func checkAuth() -> Bool{
        return bool(forKey: "Auth")
    }
    
}
