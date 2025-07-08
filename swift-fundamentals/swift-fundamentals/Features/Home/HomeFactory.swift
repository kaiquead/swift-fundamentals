//
//  HomeFactory.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 07/07/25.
//

import Foundation

protocol HomeFactoryProtocol {
    static func makeHomeViewController(navigationController: UINavigationControllerProtocol?) -> HomeViewController
}

enum HomeFactory: HomeFactoryProtocol {
    static func makeHomeViewController(navigationController: UINavigationControllerProtocol?) -> HomeViewController {
        
        let worker = HomeWorker()
        let presenter = HomePresenter()
        let interactor = HomeInteractor(presenter: presenter, worker: worker)
        let router = HomeRouter(navigationController: navigationController)
        let viewController = HomeViewController(interactor: interactor, router: router)
        viewController.view = HomeView()
        presenter.homeViewController = viewController
        
        return viewController
    }
}
