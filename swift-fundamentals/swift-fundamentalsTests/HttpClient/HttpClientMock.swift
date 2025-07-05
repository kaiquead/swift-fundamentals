//
//  HttpClientMock.swift
//  swift-fundamentalsTests
//
//  Created by Kaique Alves on 04/07/25.
//

import Foundation
@testable import swift_fundamentals

extension HttpClient {
    
    static func mock(session: URLSession = .shared) -> HttpClient {
        HttpClient(session: session)
    }
}
