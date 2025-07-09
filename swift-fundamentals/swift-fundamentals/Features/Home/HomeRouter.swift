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
        let okAction = UIAlertAction(title: StringLocalizer.apiErrorOk, style: .default) { [weak self] _ in
            self?.delegate?.okAction()
        }
        
        let alertController = UIAlertController(title: StringLocalizer.apiErrorTitle, message: StringLocalizer.apiErrorDescription, preferredStyle: .alert)
        alertController.addAction(okAction)
        
        DispatchQueue.main.async {
            self.navigationController?.present(alertController, animated: true, completion: nil)
        }
    }
}
