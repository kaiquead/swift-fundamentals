//
//  HomeWorkerTests.swift
//  swift-fundamentalsTests
//
//  Created by Kaique Alves on 07/07/25.
//

import Foundation
import XCTest
@testable import swift_fundamentals

class HomeWorkerTests: XCTestCase {
    
    // MARK: - Methods
    
    func testPageAndQueryItemsInRequest() {
        let httpClientSpy = HttpClient.Spy()
        let newsApiKeyManagerSpy = NewsAPIKeyManagerSpy()
        
        let worker = HomeWorker.mock(httpClient: httpClientSpy, newsAPIKeyManagerProtocol: newsApiKeyManagerSpy)
        let page = 1
        
        worker.makeInitialNewsRequest(page: page) { _ in
            XCTAssertTrue(httpClientSpy.makeRequestCalled)
            XCTAssertTrue(((httpClientSpy.requestConfiguration?.queryItems?.contains(where: { $0 == URLQueryItem(name: "q", value: "noticias")})) ?? false))
            XCTAssertTrue(((httpClientSpy.requestConfiguration?.queryItems?.contains(where: { $0 == URLQueryItem(name: "language", value: "pt")})) ?? false))
            XCTAssertTrue(((httpClientSpy.requestConfiguration?.queryItems?.contains(where: { $0 == URLQueryItem(name: "page", value: String(page))})) ?? false))
            XCTAssertTrue(((httpClientSpy.requestConfiguration?.queryItems?.contains(where: { $0 == URLQueryItem(name: "pageSize", value: "30")})) ?? false))
            XCTAssertTrue(((httpClientSpy.requestConfiguration?.queryItems?.contains(where: { $0.name == "apiKey" })) ?? false))
            
            XCTAssertTrue(newsApiKeyManagerSpy.getAPIKeyCalled)
        }
    }
    
    func testMakeInitialNewsRequestWithSuccessInHttpAndFailureInDecode() {
        let genericData = Data()
        let httpClientSpyResult: Result<Data, HttpClient.RequestError> = .success(genericData)
        let httpClientSpy = HttpClient.Spy(spyResult: httpClientSpyResult)
        
        let worker = HomeWorker.mock(httpClient: httpClientSpy)
        let page = 1
        
        worker.makeInitialNewsRequest(page: page) { result in
            XCTAssertTrue(httpClientSpy.makeRequestCalled)
            
            switch result {
            case .failure(let error):
                XCTAssertTrue(error == .decodeError)
            case .success:
                XCTFail("Result must be error")
            }
        }
    }
    
    func testMakeInitialNewsRequestSuccessInHttpAndSuccessInDecode() {
        guard let httpClientSuccessData = HomeNews.mock().toData else {
            XCTFail("Should have Data")
            return
        }
        
        let httpClientSpyResult: Result<Data, HttpClient.RequestError> = .success(httpClientSuccessData)
        let httpClientSpy = HttpClient.Spy(spyResult: httpClientSpyResult)
        
        let worker = HomeWorker.mock(httpClient: httpClientSpy)
        let page = 1
        
        worker.makeInitialNewsRequest(page: page) { result in
            XCTAssertTrue(httpClientSpy.makeRequestCalled)
            
            switch result {
            case .success:
                XCTAssert(true)
            case .failure:
                XCTFail("Should be success")
            }
        }
    }
    
    func testMakeInitialNewsRequestFailInHttp() {
        let httpClientSpyResult: Result<Data, HttpClient.RequestError> = .failure(.apiError(statusCode: 404))
        let httpClientSpy = HttpClient.Spy(spyResult: httpClientSpyResult)
        
        let worker = HomeWorker.mock(httpClient: httpClientSpy)
        let page = 1
        
        worker.makeInitialNewsRequest(page: page) { result in
            XCTAssertTrue(httpClientSpy.makeRequestCalled)
            
            switch result {
            case .failure(let error):
                XCTAssertTrue(error == .apiError(statusCode: 404))
            case .success:
                XCTFail("Should be error")
            }
        }
    }
}

extension HomeWorker {
    
    static func mock(
        httpClient: HttpClientProtocol = HttpClient.Spy(),
        newsAPIKeyManagerProtocol: NewsAPIKeyManagerProtocol = NewsAPIKeyManagerSpy()
    ) -> HomeWorker {
        HomeWorker(httpClient: httpClient, newsApiKeyManager: newsAPIKeyManagerProtocol)
    }
}

extension HomeWorker {
    
    class Spy: HomeWorkerProtocol {
        let expectedResult: HomeWorker.MakeInitialNewsResult
        var page = -1
        var makeInitialNewsRequestCalled = false
        
        init(expectedResult: HomeWorker.MakeInitialNewsResult) {
            self.expectedResult = expectedResult
        }
        
        func makeInitialNewsRequest(page: Int, completion: @escaping (HomeWorker.MakeInitialNewsResult) -> Void) {
            self.page = page
            self.makeInitialNewsRequestCalled = true
            completion(expectedResult)
        }
    }
}
