//
//  KeychainService.swift
//  1homework5m
//
//  Created by mavluda on 28/5/23.
//

import Foundation
import Locksmith

class KeyChainManager{
    
    static let shared = KeyChainManager()
    
    private init(){}
    
    func createAccount(username: String, password: String){
        do{
            let account = UserAccount(username: username, password: password)
            try account.createInSecureStore()
            UserDefaultsManager.shared.setAuth(true)
        }catch{}
    }
    
    func checkAccount(username: String, password: String) -> Bool{
        let account = UserAccount(username: username, password: password)
        let result = account.readFromSecureStore()
        return result != nil
    }
}
