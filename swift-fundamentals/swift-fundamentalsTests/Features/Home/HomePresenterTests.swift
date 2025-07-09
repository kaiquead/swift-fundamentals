//
//  HomePresenterTests.swift
//  swift-fundamentalsTests
//
//  Created by Kaique Alves on 08/07/25.
//

import Foundation
import XCTest
@testable import swift_fundamentals

class HomePresenterTests: XCTestCase {
    
    // MARK: - Methods
    
    func testLoadNewsOnScreen() {
        var presenter = HomePresenter.mock()
        let homeViewControllerStub = HomeViewController.OutputStub()
        presenter.homeViewController = homeViewControllerStub
        let news = HomeNews.mock()
        
        presenter.loadNewsOnScreen(news: news)
        
        XCTAssert(homeViewControllerStub.loadNewsOnScreenCalled)
        XCTAssert(homeViewControllerStub.newsValue == news)
    }
    
    func testShowApiError() {
        var presenter = HomePresenter.mock()
        let homeViewControllerStub = HomeViewController.OutputStub()
        presenter.homeViewController = homeViewControllerStub
        
        presenter.showApiError()
        
        XCTAssert(homeViewControllerStub.showApiErrorCalled)
    }
}

// MARK: - Mock

extension HomePresenterProtocol {
    
    static func mock() -> HomePresenterProtocol {
        HomePresenter()
    }
}

extension HomePresenter {
    
    class Stub: HomePresenterProtocol {
        var homeViewController: (HomeViewControllerOutputProtocol)?
        
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
