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
    let router: HomeRouterProtocol
    
    init(interactor: HomeInteractorProcol, router: HomeRouterProtocol) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .red
        DispatchQueue.main.async {
            self.view.backgroundColor = .green
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Inputs

extension HomeViewController: HomeViewControllerInputProtocol, HomeViewDelegate {
    
    func searchButtonTap(text: String) {
        
    }
    
    func loadMoreNewsFromInfinityScroll() {
        
    }
}

// MARK: - Outputs

extension HomeViewController: HomeViewControllerOutputProtocol {
    
}
