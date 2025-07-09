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
        let homeViewControllerSpy = HomeViewController.OutputSpy()
        presenter.homeViewController = homeViewControllerSpy
        let news = HomeNews.mock()
        
        presenter.loadNewsOnScreen(news: news)
        
        XCTAssert(homeViewControllerSpy.loadNewsOnScreenCalled)
        XCTAssert(homeViewControllerSpy.newsValue == news)
    }
    
    func testShowApiError() {
        var presenter = HomePresenter.mock()
        let homeViewControllerSpy = HomeViewController.OutputSpy()
        presenter.homeViewController = homeViewControllerSpy
        
        presenter.showApiError()
        
        XCTAssert(homeViewControllerSpy.showApiErrorCalled)
    }
}

// MARK: - Mock

extension HomePresenterProtocol {
    
    static func mock() -> HomePresenterProtocol {
        HomePresenter()
    }
}

extension HomePresenter {
    
    class Spy: HomePresenterProtocol {
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
