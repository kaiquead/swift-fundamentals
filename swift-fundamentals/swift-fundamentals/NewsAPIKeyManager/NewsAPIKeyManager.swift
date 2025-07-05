//
//  NewsAPIKeyManager.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 05/07/25.
//

import Foundation

protocol NewsAPIKeyManagerProtocol {
    func initializeFromSecretsIfNeeded()
    func getAPIKey() -> String?
    func reset()
}

final class NewsAPIKeyManager: NewsAPIKeyManagerProtocol {
    static let shared = NewsAPIKeyManager()
    private let keychain = KeychainHelper.shared
    private let keychainKey = "news_api_key"

    private init() {}

    func initializeFromSecretsIfNeeded() {
        guard keychain.read(forKey: keychainKey) == nil else { return }

        guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let value = dict["NewsAPIKey"] as? String else {
            print("Error to load Authentication NewsAPI key")
            return
        }

        let success = keychain.save(value, forKey: keychainKey)
        debugPrint(success ? "NewsAPI: key saved in Keychain with success" : "NewsAPI: error to save NewsAPI key in Keychain")
    }

    func getAPIKey() -> String? {
        return keychain.read(forKey: keychainKey)
    }

    func reset() {
        _ = keychain.delete(forKey: keychainKey)
    }
}
