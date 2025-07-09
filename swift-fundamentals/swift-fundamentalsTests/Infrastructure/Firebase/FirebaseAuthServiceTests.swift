//
//  FirebaseAuthServiceTests.swift
//  swift-fundamentalsTests
//
//  Created by Kaique Alves on 09/07/25.
//

import FirebaseAuth
import Foundation
@testable import swift_fundamentals

extension FirebaseAuthService {
    
    class Stub: FirebaseAuthServiceProtocol {
        var shouldSucceed = true

        func signIn(email: String, password: String, completion: @escaping (Result<User?, Error>) -> Void) {
            if shouldSucceed {
                completion(.success(nil))
            } else {
                let error = NSError(domain: "Auth", code: 0, userInfo: [NSLocalizedDescriptionKey: "Credenciais inválidas"])
                completion(.failure(error))
            }
        }
    }
}

extension User {
    
    static func mock() -> User? {
        return nil
    }
}
