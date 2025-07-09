//
//  HomeViewControllerTests.swift
//  swift-fundamentalsTests
//
//  Created by Kaique Alves on 08/07/25.
//

import Foundation
import XCTest
@testable import swift_fundamentals

// MARK: - Spy

extension HomeViewController {
    
    class OutputSpy: HomeViewControllerOutputProtocol {
        var loadNewsOnScreenCalled = false
        var newsValue: HomeNews?
        
        var showApiErrorCalled = false
        
        func loadNewsOnScreen(news: HomeNews) {
            loadNewsOnScreenCalled = true
            newsValue = news
        }
        
        func showApiError() {
            showApiErrorCalled = true
        }
    }
}
