//
//  LoginPresenter.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 09/07/25.
//

import Foundation

protocol LoginPresenterProtocol {
    var loginViewController: LoginViewControllerOutputProtocol? { get set }
    func showApiError()
    func loginSuccessful()
}

class LoginPresenter: LoginPresenterProtocol {
    
    // MARK: - ViewController reference
    
    weak var loginViewController: LoginViewControllerOutputProtocol?
    
    // MARK: - Methods
    
    func showApiError() {
        loginViewController?.showApiError()
    }
    
    func loginSuccessful() {
        loginViewController?.loginSuccessful()
    }
}

