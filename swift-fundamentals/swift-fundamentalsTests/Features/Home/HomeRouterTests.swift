//
//  HomeRouterTests.swift
//  swift-fundamentalsTests
//
//  Created by Kaique Alves on 08/07/25.
//

import Foundation
import XCTest
@testable import swift_fundamentals

class HomeRouterTests: XCTestCase {
    
    // MARK: - Methods
    
    func testShowApiError() {
        let navigationControllerSpy = UINavigationControllerSpy()
        let router = HomeRouter.mock(navigationController: navigationControllerSpy)
        
        router.showApiError()
        
        XCTAssertTrue(navigationControllerSpy.presentCalled)
    }
}

extension HomeRouter {
    
    static func mock(navigationController: UINavigationControllerProtocol? = UINavigationControllerSpy()) -> HomeRouterProtocol {
        HomeRouter(navigationController: navigationController)
    }
}
