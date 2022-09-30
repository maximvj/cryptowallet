//
//  ViewController.swift
//  cryptowallet
//
//  Created by Maxim on 29.09.2022.
//

import UIKit
import SnapKit


class LoginViewController: BaseViewController {
    
    // MARK: - Properties
    
    let loginTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    var stackView = UIStackView()

    // MARK: - Ovveride metods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setTextFields()
        setButton()
        setStackView()
        setLayout()
        
    }

    override func listenViewModel() {
        
    }
    
    override func setLayout() {
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(200)
            make.left.equalTo(50)
            make.right.equalTo(-50)
        }
    }
    
    // MARK: - Metods
    
    func setTextFields() {
        loginTextField.borderStyle = .line
        loginTextField.layer.cornerRadius = 10
        
        passwordTextField.borderStyle = .line
        passwordTextField.layer.cornerRadius = 10
    }
    
    func setButton() {
        loginButton.backgroundColor = .systemTeal
        loginButton.layer.cornerRadius = 10
        loginButton.setTitle("Login", for: .normal)
    }
    
    func setStackView() {
        stackView = UIStackView(arrangedSubviews: [loginTextField, passwordTextField, loginButton ])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.setCustomSpacing(20, after: loginTextField)
        stackView.setCustomSpacing(50, after: passwordTextField)
    }
}

