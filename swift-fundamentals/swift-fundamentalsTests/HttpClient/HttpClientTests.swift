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
        let endpoint = HttpClient.Endpoint.mock(urlString: "invalid")
        
        httpClient.makeRequest(endpoint: endpoint) { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .invalidURL)
            default:
                XCTFail("Result must be error because is invalid url")
            }
        }
    }
    
    func testInvalidURLComponents() {
        let endpoint = HttpClient.Endpoint.mock(urlString: "https:")
        
        httpClient.makeRequest(endpoint: endpoint) { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .invalidURLComponents)
            default:
                XCTFail("Result must be error because is invalid url components")
            }
        }
    }
    
    func testSuccessRequest() {
        let endpoint = HttpClient.Endpoint.mock(urlString: "https://test.com")
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
        
        client.makeRequest(endpoint: endpoint) { result in
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
        let endpoint = HttpClient.Endpoint.mock(urlString: "https://jsonplaceholder.typicode.com")
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
        
        client.makeRequest(endpoint: endpoint) { result in
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
