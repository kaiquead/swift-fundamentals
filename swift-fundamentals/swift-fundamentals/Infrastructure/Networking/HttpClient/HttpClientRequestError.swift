//
//  HttpClientRequestError.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 04/07/25.
//

import Foundation

extension HttpClient {
    
    enum RequestError: Error, Equatable {
        case invalidURL
        case invalidURLComponents
        case responseError
        case apiError(statusCode: Int)
        case dataError
        case networkError
    }
}
