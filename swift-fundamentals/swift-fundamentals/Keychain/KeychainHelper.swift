//
//  KeychainHelper.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 05/07/25.
//

import Foundation

protocol KeychainHelperProtocol {
    func save(_ value: String, forKey key: String) -> Bool
    func read(forKey key: String) -> String?
    func delete(forKey key: String) -> Bool
}

final class KeychainHelper: KeychainHelperProtocol {

    private let service = "kaiquedamacena.com.swift-fundamentals.apikey"

    func save(_ value: String, forKey key: String) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }

        let _ = delete(forKey: key)

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlockedThisDeviceOnly
        ]

        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }

    func read(forKey key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        if status == errSecSuccess,
           let data = item as? Data,
           let string = String(data: data, encoding: .utf8) {
            return string
        }

        return nil
    }

    func delete(forKey key: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key
        ]

        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
}
