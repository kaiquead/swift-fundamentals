//
//  LoginView.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 09/07/25.
//

import Foundation
import UIKit
import SnapKit

protocol LoginViewDelegate: AnyObject {
    func loginButtonTap(email: String, password: String)
}

class LoginView: UIView {
    
    // MARK: - Lazy properties
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = StringLocalizer.loginTitle
        titleLabel.font = .systemFont(ofSize: 36, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var emailTextField: UITextField = {
        let emailTextField = UITextField()
        emailTextField.placeholder = StringLocalizer.emailPlaceholder
        emailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        emailTextField.leftViewMode = .always
        emailTextField.backgroundColor = .white
        emailTextField.layer.cornerRadius = 8
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        return emailTextField
    }()
    
    lazy var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.placeholder = StringLocalizer.passwordPlaceholder
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        passwordTextField.leftViewMode = .always
        passwordTextField.backgroundColor = .white
        passwordTextField.layer.cornerRadius = 8
        passwordTextField.isSecureTextEntry = true
        return passwordTextField
    }()
    
    lazy var loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.setTitle(StringLocalizer.loginButtonTitle, for: .normal)
        loginButton.backgroundColor = Colors.homeRed
        loginButton.layer.cornerRadius = 12
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        return loginButton
    }()
    
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .white
        spinner.stopAnimating()
        return spinner
    }()
    
    // MARK: - Delegate
    
    weak var delegate: LoginViewDelegate?
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configure()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dismissKeyboard() {
        endEditing(true)
    }
    
    // MARK: - Configuration
    
    private func configure() {
        backgroundColor = Colors.homeBackground
        
        configureStackView()
        configureEmailTextField()
        configurePasswordTextField()
        configureTitleLabel()
        configureLoginButton()
        configureSpinner()
    }
    
    private func configureStackView() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(32)
            make.centerY.equalToSuperview()
        }
    }
    
    private func configureEmailTextField() {
        stackView.addArrangedSubview(emailTextField)
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
    }
    
    private func configurePasswordTextField() {
        stackView.addArrangedSubview(passwordTextField)
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(stackView.snp.top).inset(-16)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configureLoginButton() {
        addSubview(loginButton)
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(16)
            make.height.equalTo(48)
            make.width.equalTo(128)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configureSpinner() {
        addSubview(spinner)
        
        spinner.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(16)
            make.centerX.equalTo(loginButton.snp.centerX)
        }
    }
    
    @objc func loginTapped() {
        delegate?.loginButtonTap(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
        isLoading(true)
    }
    
    // MARK: - Public methods
    
    func isLoading(_ loading: Bool) {
        if loading {
            spinner.startAnimating()
            spinner.isHidden = false
        } else {
            spinner.stopAnimating()
            spinner.isHidden = true
        }
    }
}
