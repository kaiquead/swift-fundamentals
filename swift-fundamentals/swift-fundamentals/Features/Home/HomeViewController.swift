//
//  HomeViewController.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 07/07/25.
//

import Foundation
import UIKit

protocol HomeViewControllerInputProtocol: AnyObject {
    
}

protocol HomeViewControllerOutputProtocol: AnyObject {
    
}

class HomeViewController: UIViewController {
    
    // MARK: - Initialization
    
    let interactor: HomeInteractorProcol
    
    init(interactor: HomeInteractorProcol) {
        self.interactor = interactor
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Inputs

extension HomeViewController: HomeViewControllerInputProtocol {
    
}

// MARK: - Outputs

extension HomeViewController: HomeViewControllerOutputProtocol {
    
}
