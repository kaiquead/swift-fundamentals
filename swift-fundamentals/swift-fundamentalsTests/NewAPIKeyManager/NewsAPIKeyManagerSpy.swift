//
//  NewsAPIKeyManagerSpy.swift
//  swift-fundamentalsTests
//
//  Created by Kaique Alves on 05/07/25.
//

import Foundation
@testable import swift_fundamentals

class NewsAPIKeyManagerSpy: NewsAPIKeyManagerProtocol {
    var initializeFromSecretsIfNeededCalled = false
    var getAPIKeyCalled = false
    var resetCalled = false
    
    // MARK: - Methods
    
    func initializeFromSecretsIfNeeded() {
        initializeFromSecretsIfNeededCalled = true
    }
    
    func getAPIKey() -> String? {
        getAPIKeyCalled = true
        return nil
    }
    
    func reset() {
        resetCalled = true
    }
}
