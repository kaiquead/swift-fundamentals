//
//  HomeInteractorTests.swift
//  swift-fundamentalsTests
//
//  Created by Kaique Alves on 08/07/25.
//

import Foundation
import XCTest
@testable import swift_fundamentals

class HomeInteractorTests: XCTestCase {
    
    // MARK: - Methods
    
    func testLoadHomeNewsWithSuccessResult() {
        let news = HomeNews.mock()
        let expectedResult: HomeWorker.MakeInitialNewsResult = .success(news)
        let presenter = HomePresenter.Stub()
        let worker = HomeWorker.Stub(expectedResult: expectedResult)
        let interactor = HomeInteractor.mock(presenter: presenter, worker: worker)
        
        interactor.loadHomeNews(isFirstPage: true)
        
        XCTAssert(presenter.loadNewsOnScreenCalled)
        
        guard let newsValue = presenter.newsValue else {
            XCTFail("newsValue should have a value")
            return
        }
        
        XCTAssert(news == newsValue )
    }
    
    func testLoadHomeNewsWithFailureResult() {
        let expectedResult: HomeWorker.MakeInitialNewsResult = .failure(.networkError)
        let presenter = HomePresenter.Stub()
        let worker = HomeWorker.Stub(expectedResult: expectedResult)
        let interactor = HomeInteractor.mock(presenter: presenter, worker: worker)
        
        interactor.loadHomeNews(isFirstPage: true)
        
        XCTAssert(presenter.showApiErrorCalled)
    }
}

// MARK: - Mock

extension HomeInteractor {
    
    static func mock(presenter: HomePresenterProtocol = HomePresenter.Stub(), worker: HomeWorkerProtocol = HomeWorker.Stub(expectedResult: .failure(.networkError))) -> HomeInteractorProcol {
        HomeInteractor(presenter: presenter, worker: worker)
    }
}

// MARK: - Stub

extension HomeInteractor {
    
    class Stub: HomeInteractorProcol {
        var expectedResult: HomeWorker.MakeInitialNewsResult
        var loadHomeNewsCalled = false
        var isFirstPage = false
        
        init(expectedResult: HomeWorker.MakeInitialNewsResult) {
            self.expectedResult = expectedResult
        }
        
        func loadHomeNews(isFirstPage: Bool) {
            self.loadHomeNewsCalled = true
            self.isFirstPage = isFirstPage
        }
    }
}
