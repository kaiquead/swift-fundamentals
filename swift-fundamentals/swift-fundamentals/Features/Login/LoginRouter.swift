//
//  LoginRouter.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 09/07/25.
//

import Foundation
import UIKit

protocol LoginRouterDelegate: AnyObject {
    func okAction()
}

protocol LoginRouterProtocol {
    func showApiError()
    func goToHome()
}

class LoginRouter: LoginRouterProtocol {
    
    // MARK: - Delegate
    
    weak var delegate: LoginRouterDelegate?
    
    // MARK: - Initialization
    
    let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    
    func showApiError() {
        let alertErrorView = ErrorAlertController.makeErrorView { [weak self] in
            self?.delegate?.okAction()
        }
        
        DispatchQueue.main.async {
            self.navigationController?.present(alertErrorView, animated: true)
        }
    }
    
    func goToHome() {
        let viewController = HomeFactory.makeHomeViewController(navigationController: navigationController)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
