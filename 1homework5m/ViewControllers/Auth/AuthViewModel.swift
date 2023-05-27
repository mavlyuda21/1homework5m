//
//  AuthViewModel.swift
//  1homework5m
//
//  Created by mavluda on 28/5/23.
//

import Foundation

protocol UserCheckDelegate: AnyObject{
    func userCheck(_ bool: Bool)
}

class AuthViewModel{
    
    weak var delegate: UserCheckDelegate? = nil
    
    init(delegate: UserCheckDelegate) {
        self.delegate = delegate
    }
    
    init(){}
    
    func checkUser(username: String, password: String){
        if KeyChainManager.shared.checkAccount(username: username, password: password){
            delegate?.userCheck(true)
        }else{
            KeyChainManager.shared.createAccount(username: username, password: password)
            delegate?.userCheck(true)
        }
    }
    
}
