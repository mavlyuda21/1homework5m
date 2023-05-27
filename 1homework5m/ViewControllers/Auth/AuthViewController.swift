//
//  AuthViewController.swift
//  1homework5m
//
//  Created by mavluda on 28/5/23.
//

import UIKit
import SnapKit

class AuthViewController: UIViewController{
    
    private lazy var usernameTextField: UITextField = {
        let view = UITextField()
        view.backgroundColor = .systemGray6
        view.textColor = .white
        view.layer.cornerRadius = 8
        view.textAlignment = .center
        view.placeholder = "username"
        return view
    }()
    
    private lazy var passwordTextField: UITextField = {
        let view = UITextField()
        view.backgroundColor = .systemGray6
        view.textColor = .white
        view.layer.cornerRadius = 8
        view.textAlignment = .center
        view.placeholder = "password"
        return view
    }()
    
    private lazy var loginButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("login", for: .normal)
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 10
        view.setTitleColor(.white, for: .normal)
        return view
    }()
    
    private lazy var statusText: UILabel = {
        let view = UILabel()
        view.textColor = .red
        return view
    }()
    
    private var viewModel: AuthViewModel? = nil
    
    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel?.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupUI()
    }
    
    private func setupUI(){
        view.addSubview(statusText)
        
        statusText.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-50)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
        usernameTextField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(view.snp.width).multipliedBy(0.1)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.leading.trailing.height.equalTo(usernameTextField)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.height.equalTo(usernameTextField).multipliedBy(1.3)
            make.leading.trailing.equalToSuperview().inset(50)
        }
        
        loginButton.addTarget(nil, action: #selector(loginButtonPressed(view: )), for: .touchUpInside)
    }
    
    @objc func loginButtonPressed(view: UIButton){
        if !(passwordTextField.text?.isEmpty ?? false) && !(usernameTextField.text?.isEmpty ?? false){
            viewModel?.checkUser(username: usernameTextField.text ?? "", password: passwordTextField.text ?? "")
        }else{
            statusText.text = "Input all required data"
        }
    }
}

extension AuthViewController: UserCheckDelegate{
    func userCheck(_ bool: Bool) {
        if bool{
            navigationController?.pushViewController(MainViewController(viewModel: MainViewModel()), animated: true)
        }else{
            usernameTextField.placeholder = "Try again"
            passwordTextField.placeholder = "Try again"
            loginButton.backgroundColor = .red
        }
    }
}
