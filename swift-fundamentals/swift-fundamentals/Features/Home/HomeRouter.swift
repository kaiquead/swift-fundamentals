//
//  HomeRouter.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 07/07/25.
//

import Foundation
import UIKit

protocol HomeRouterDelegate: AnyObject {
    func okAction()
}

protocol HomeRouterProtocol {
    func showApiError()
}

class HomeRouter: HomeRouterProtocol {
    
    // MARK: - Delegate
    
    weak var delegate: HomeRouterDelegate?
    
    // MARK: - Initialization
    
    let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    
    func showApiError() {
        let alertController = ErrorAlertController.makeErrorView { [weak self] in
            self?.delegate?.okAction()
        }
        
        DispatchQueue.main.async {
            self.navigationController?.present(alertController, animated: true, completion: nil)
        }
    }
}
