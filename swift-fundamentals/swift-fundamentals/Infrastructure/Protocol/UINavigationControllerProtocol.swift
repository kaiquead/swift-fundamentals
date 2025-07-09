//
//  UINavigationControllerProtocol.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 07/07/25.
//

import UIKit

extension UINavigationController: UINavigationControllerProtocol { }
    
protocol UINavigationControllerProtocol {
    func pushViewController(_ viewController: UIViewController, animated: Bool)
    func popViewController(animated: Bool) -> UIViewController?
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
}
