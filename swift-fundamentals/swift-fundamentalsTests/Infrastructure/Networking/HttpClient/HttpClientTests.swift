//
//  HttpClientTests.swift
//  swift-fundamentalsTests
//
//  Created by Kaique Alves on 04/07/25.
//

import Foundation
import XCTest

@testable import swift_fundamentals

class HttpClientTests: XCTestCase {
    
    // MARK: - Properties
    
    let httpClient = HttpClient.mock()
    
    // MARK: - Tests
    
    func testInvalidURL() {
        let requestConfiguration = HttpClient.RequestConfiguration.mock(urlString: "invalid")
        
        httpClient.makeRequest(requestConfiguration: requestConfiguration) { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .invalidURL)
            default:
                XCTFail("Result must be error because is invalid url")
            }
        }
    }
    
    func testInvalidURLComponents() {
        let requestConfiguration = HttpClient.RequestConfiguration.mock(urlString: "https:")
        
        httpClient.makeRequest(requestConfiguration: requestConfiguration) { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .invalidURLComponents)
            case .success:
                XCTFail("Result must be error because is invalid url components")
            }
        }
    }
    
    func testSuccessRequest() {
        let requestConfiguration = HttpClient.RequestConfiguration.mock(urlString: "https://test.com")
        let expectation = XCTestExpectation(description: "completion called")
        
        // MARK: - URLProtocolMock configuration
        guard let expectedData = "{\"status\":\"ok\"}".data(using: .utf8) else {
            XCTFail("Invalid json mock")
            return
        }
        
        URLProtocolMock.requestHandler = { request in
            guard let url = request.url else {
                XCTFail("Invalid URL")
                throw URLError(.badURL)
            }
            
            let response = HTTPURLResponse(
                url: url,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, expectedData)
        }
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolMock.self]
        let mockSession = URLSession(configuration: configuration)
        
        // MARK: - Fake request
        
        let client = HttpClient.mock(session: mockSession)
        
        client.makeRequest(requestConfiguration: requestConfiguration) { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data, expectedData)
            case .failure(let error):
                XCTFail("Unexpected error: \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testErrorRequest() {
        let requestConfiguration = HttpClient.RequestConfiguration.mock(urlString: "https://jsonplaceholder.typicode.com")
        let expectation = XCTestExpectation(description: "completion called")
        
        URLProtocolMock.requestHandler = { request in
            guard let url = request.url else {
                XCTFail("Invalid URL")
                throw URLError(.badURL)
            }
            
            let response = HTTPURLResponse(
                url: url,
                statusCode: 400,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, nil)
        }
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolMock.self]
        let mockSession = URLSession(configuration: configuration)
        
        // MARK: - Fake request
        
        let client = HttpClient.mock(session: mockSession)
        
        client.makeRequest(requestConfiguration: requestConfiguration) { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, HttpClient.RequestError.apiError(statusCode: 400))
            case .success:
                XCTFail("Request should be error")
            
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}

// MARK: - Mock

extension HttpClient {
    
    // MARK: - This mock exclusively have this structure to don`t be risk to use a real URLSession. Was necessary because I can`t have init() in URLSession subclasses, instead I had to use URLProtocol and inject in configuration to capture a fake call.
    static func mock(session: URLSession? = nil) -> HttpClient {
        guard let session = session else {
            let configuration = URLSessionConfiguration.ephemeral
            configuration.protocolClasses = [URLProtocolMock.self]
            let mockSession = URLSession(configuration: configuration)
            return HttpClient(session: mockSession)
        }
        
        return HttpClient(session: session)
    }
}

// MARK: - Spy

extension HttpClient {
    
    class Spy: HttpClientProtocol {
        var SpyResult: Result<Data, HttpClient.RequestError>
        var makeRequestCalled = false
        var requestConfiguration: HttpClient.RequestConfiguration?
        
        init(SpyResult: Result<Data, HttpClient.RequestError> = .failure(.dataError)) {
            self.SpyResult = SpyResult
        }
        
        func makeRequest(requestConfiguration: HttpClient.RequestConfiguration, completion: @escaping (Result<Data, HttpClient.RequestError>) -> Void) {
            self.makeRequestCalled = true
            self.requestConfiguration = requestConfiguration
            completion(SpyResult)
        }
    }
}
