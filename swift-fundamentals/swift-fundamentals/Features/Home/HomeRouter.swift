//
//  HomeRouter.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 07/07/25.
//

import Foundation
import UIKit

protocol HomeRouterProtocol {
    
}

class HomeRouter: HomeRouterProtocol {
    let navigationController: UINavigationControllerProtocol?
    
    init(navigationController: UINavigationControllerProtocol?) {
        self.navigationController = navigationController
    }
}
