//
//  HomeFactory.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 07/07/25.
//

import Foundation
import UIKit

protocol HomeFactoryProtocol {
    static func makeHomeViewController(navigationController: UINavigationController?) -> HomeViewController
}

enum HomeFactory: HomeFactoryProtocol {
    static func makeHomeViewController(navigationController: UINavigationController?) -> HomeViewController {
        
        let worker = HomeWorker()
        let presenter = HomePresenter()
        let interactor = HomeInteractor(presenter: presenter, worker: worker)
        let router = HomeRouter(navigationController: navigationController)
        let viewController = HomeViewController(interactor: interactor, router: router)
        presenter.homeViewController = viewController
        
        return viewController
    }
}
