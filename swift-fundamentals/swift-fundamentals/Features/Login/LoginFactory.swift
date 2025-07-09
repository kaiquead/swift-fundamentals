//
//  LoginFactory.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 09/07/25.
//

import Foundation
import UIKit

protocol LoginFactoryProtocol {
    static func makeLoginViewController(navigationController: UINavigationController?) -> LoginViewController
}

enum LoginFactory: LoginFactoryProtocol {
    static func makeLoginViewController(navigationController: UINavigationController?) -> LoginViewController {
        
        let worker = LoginWorker()
        let presenter = LoginPresenter()
        let interactor = LoginInteractor(presenter: presenter, worker: worker)
        let router = LoginRouter(navigationController: navigationController)
        let viewController = LoginViewController(interactor: interactor, router: router)
        presenter.loginViewController = viewController
        
        return viewController
    }
}
