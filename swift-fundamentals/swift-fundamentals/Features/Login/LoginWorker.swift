//
//  LoginWorker.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 09/07/25.
//

import FirebaseAuth
import Foundation

protocol LoginWorkerProtocol {
    func makeLoginRequest(email: String, password: String, completion: @escaping (LoginWorker.MakeLoginResult) -> Void)
}

class LoginWorker: LoginWorkerProtocol {
    
    // MARK: - Typealias for result
    
    typealias MakeLoginResult = Result<Bool, Error>
    
    // MARK: - Initialization
    
    var firebaseAuthService: FirebaseAuthServiceProtocol = FirebaseAuthService()
    
    init(firebaseAuthService: FirebaseAuthServiceProtocol = FirebaseAuthService()) {
        self.firebaseAuthService = firebaseAuthService
    }
    
    // MARK: - Requests
    
    func makeLoginRequest(email: String, password: String, completion: @escaping (LoginWorker.MakeLoginResult) -> Void) {
        firebaseAuthService.signIn(email: email, password: password) { result in
            switch result {
            case .success:
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
