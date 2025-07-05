//
//  HttpClientEndpoint.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 04/07/25.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

extension HttpClient {
    
    struct Endpoint {
        let urlString: String
        let method: HTTPMethod
        let headers: [String: String]?
        let body: Data?
        let queryItems: [URLQueryItem]?
    }
}
