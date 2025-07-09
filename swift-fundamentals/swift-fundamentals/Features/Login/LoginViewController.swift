//
//  LoginViewController.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 09/07/25.
//

import Foundation
import UIKit

protocol LoginViewControllerInputProtocol: AnyObject {
    
}

protocol LoginViewControllerOutputProtocol: AnyObject {
    func showApiError()
    func loginSuccessful()
}

class LoginViewController: UIViewController {
    
    // MARK: - Initialization
    
    let interactor: LoginInteractorProcol
    let router: LoginRouterProtocol
    
    init(interactor: LoginInteractorProcol, router: LoginRouterProtocol) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
        
//        interactor.loadHomeNews(isFirstPage: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = LoginView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            guard let view = self.view as? LoginView else { return }
            view.delegate = self
        }
   
        guard let router = router as? LoginRouter else { return }
        router.delegate = self
    }
}

// MARK: - Inputs

extension LoginViewController: LoginViewControllerInputProtocol, LoginRouterDelegate, LoginViewDelegate {
    
    func okAction() {
        
    }
    
    func loginButtonTap(email: String, password: String) {
        interactor.makeLogin(email: email, password: password)
    }
}

// MARK: - Outputs

extension LoginViewController: LoginViewControllerOutputProtocol {
    func showApiError() {
        router.showApiError()
        
        DispatchQueue.main.async {
            guard let view = self.view as? LoginView else { return }
            view.isLoading(false)
        }
    }
    
    func loginSuccessful() {
        router.goToHome()
    }
}

