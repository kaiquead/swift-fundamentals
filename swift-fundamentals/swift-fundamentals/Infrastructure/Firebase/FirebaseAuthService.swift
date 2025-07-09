//
//  RemoteConfig.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 05/07/25.
//

import FirebaseAuth

protocol FirebaseAuthServiceProtocol {
    func signIn(email: String, password: String, completion: @escaping (Result<User?, Error>) -> Void)
}

class FirebaseAuthService: FirebaseAuthServiceProtocol {
    func signIn(email: String, password: String, completion: @escaping (Result<User?, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let user = result?.user {
                completion(.success(user))
            }
        }
    }
}
