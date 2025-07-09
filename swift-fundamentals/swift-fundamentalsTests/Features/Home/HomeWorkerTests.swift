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
        let httpClientStub = HttpClient.Stub()
        let newsApiKeyManagerSpy = NewsAPIKeyManagerSpy()
        
        let worker = HomeWorker.mock(httpClient: httpClientStub, newsAPIKeyManagerProtocol: newsApiKeyManagerSpy)
        let page = 1
        
        worker.makeInitialNewsRequest(page: page) { _ in
            XCTAssertTrue(httpClientStub.makeRequestCalled)
            XCTAssertTrue(((httpClientStub.requestConfiguration?.queryItems?.contains(where: { $0 == URLQueryItem(name: "q", value: "noticias")})) ?? false))
            XCTAssertTrue(((httpClientStub.requestConfiguration?.queryItems?.contains(where: { $0 == URLQueryItem(name: "language", value: "pt")})) ?? false))
            XCTAssertTrue(((httpClientStub.requestConfiguration?.queryItems?.contains(where: { $0 == URLQueryItem(name: "page", value: String(page))})) ?? false))
            XCTAssertTrue(((httpClientStub.requestConfiguration?.queryItems?.contains(where: { $0 == URLQueryItem(name: "pageSize", value: "8")})) ?? false))
            XCTAssertTrue(((httpClientStub.requestConfiguration?.queryItems?.contains(where: { $0.name == "apiKey" })) ?? false))
            
            XCTAssertTrue(newsApiKeyManagerSpy.getAPIKeyCalled)
        }
    }
    
    func testMakeInitialNewsRequestWithSuccessInHttpAndFailureInDecode() {
        let genericData = Data()
        let httpClientStubResult: Result<Data, HttpClient.RequestError> = .success(genericData)
        let httpClientStub = HttpClient.Stub(stubResult: httpClientStubResult)
        
        let worker = HomeWorker.mock(httpClient: httpClientStub)
        let page = 1
        
        worker.makeInitialNewsRequest(page: page) { result in
            XCTAssertTrue(httpClientStub.makeRequestCalled)
            
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
        
        let httpClientStubResult: Result<Data, HttpClient.RequestError> = .success(httpClientSuccessData)
        let httpClientStub = HttpClient.Stub(stubResult: httpClientStubResult)
        
        let worker = HomeWorker.mock(httpClient: httpClientStub)
        let page = 1
        
        worker.makeInitialNewsRequest(page: page) { result in
            XCTAssertTrue(httpClientStub.makeRequestCalled)
            
            switch result {
            case .success:
                XCTAssert(true)
            case .failure:
                XCTFail("Should be success")
            }
        }
    }
    
    func testMakeInitialNewsRequestFailInHttp() {
        let httpClientStubResult: Result<Data, HttpClient.RequestError> = .failure(.apiError(statusCode: 404))
        let httpClientStub = HttpClient.Stub(stubResult: httpClientStubResult)
        
        let worker = HomeWorker.mock(httpClient: httpClientStub)
        let page = 1
        
        worker.makeInitialNewsRequest(page: page) { result in
            XCTAssertTrue(httpClientStub.makeRequestCalled)
            
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
        httpClient: HttpClientProtocol = HttpClient.Stub(),
        newsAPIKeyManagerProtocol: NewsAPIKeyManagerProtocol = NewsAPIKeyManagerSpy()
    ) -> HomeWorker {
        HomeWorker(httpClient: httpClient, newsApiKeyManager: newsAPIKeyManagerProtocol)
    }
}

extension HomeWorker {
    
    class Stub: HomeWorkerProtocol {
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
