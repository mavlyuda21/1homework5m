//
//  SplashController.swift
//  1homework5m
//
//  Created by mavluda on 28/5/23.
//

import Foundation

class SplashController: UIViewController{
    
    override func viewDidLoad() {
        if DefaultsManager.shared.checkAuth(){
            let viewModel = MainViewModel()
            navigationController?.pushViewController(MainViewController(viewModel: viewModel), animated: true)
        }else{
            let authViewModel = AuthViewModel()
            navigationController?.pushViewController(AuthViewController(viewModel: authViewModel), animated: true)
        }
    }
    
}
