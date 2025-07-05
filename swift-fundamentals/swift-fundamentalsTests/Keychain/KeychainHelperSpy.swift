//
//  KeychainHelperSpy.swift
//  swift-fundamentalsTests
//
//  Created by Kaique Alves on 05/07/25.
//

import Foundation
@testable import swift_fundamentals

class KeychainHelperSpy: KeychainHelperProtocol {
    var saveCalled = false
    var readCalled = false
    var deleteCalled = false
    private var store: [String: String] = [:]
    
    // MARK: - Methods

    func save(_ value: String, forKey key: String) -> Bool {
        saveCalled = true
        store[key] = value
        return true
    }

    func read(forKey key: String) -> String? {
        readCalled = true
        return store[key]
    }

    func delete(forKey key: String) -> Bool {
        deleteCalled = true
        store.removeValue(forKey: key)
        return true
    }
}
