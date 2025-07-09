//
//  UINavigationControllerSpy.swift
//  swift-fundamentalsTests
//
//  Created by Kaique Alves on 08/07/25.
//

import Foundation
import UIKit
@testable import swift_fundamentals

class UINavigationControllerSpy: UINavigationControllerProtocol {
    var presentCalled = false
    var presentViewControllerToPresent: UIViewController?
    var presentAnimated = false
    
    var pushViewControllerCalled = false
    var pushViewControllerViewController: UIViewController?
    var pushViewControllerAnimated = false
    
    var popViewControllerCalled = false
    var popViewControllerAnimated = false
    
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        presentCalled = true
        presentViewControllerToPresent = viewControllerToPresent
        presentAnimated = flag
    }
    
    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerCalled = true
        pushViewControllerViewController = viewController
        pushViewControllerAnimated = animated
    }
    
    func popViewController(animated: Bool) -> UIViewController? {
        popViewControllerCalled = true
        popViewControllerAnimated = animated
        return nil
    }
}
