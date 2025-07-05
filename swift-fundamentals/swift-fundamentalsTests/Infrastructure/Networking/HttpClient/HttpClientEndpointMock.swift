//
//  HttpClientEndpointMock.swift
//  swift-fundamentalsTests
//
//  Created by Kaique Alves on 04/07/25.
//

import Foundation
@testable import swift_fundamentals

extension HttpClient.Endpoint {
    
    static func mock(
        urlString: String = "https://example.com",
        method: HTTPMethod = .get,
        headers: [String : String]? = nil,
        body: Data? = nil,
        queryItems: [URLQueryItem]? = nil
    ) -> HttpClient.Endpoint {
        .init(
            urlString: urlString,
            method: method,
            headers: headers,
            body: body,
            queryItems: queryItems
        )
    }
}
