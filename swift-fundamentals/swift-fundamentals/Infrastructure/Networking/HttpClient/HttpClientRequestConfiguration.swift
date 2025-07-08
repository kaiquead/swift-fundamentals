//
//  HttpClientRequestConfiguration.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 04/07/25.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

extension HttpClient {
    
    struct RequestConfiguration {
        let urlString: String
        let method: HTTPMethod
        let headers: [String: String]?
        let body: Data?
        let queryItems: [URLQueryItem]?
        
        init(
            urlString: String,
            method: HTTPMethod = .get,
            headers: [String: String]? = nil,
            body: Data? = nil,
            queryItems: [URLQueryItem]? = nil
        ) {
            self.urlString = urlString
            self.method = method
            self.headers = headers
            self.body = body
            self.queryItems = queryItems
        }
    }
}
