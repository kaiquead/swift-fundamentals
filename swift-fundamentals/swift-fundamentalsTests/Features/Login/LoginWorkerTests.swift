//
//  LoginWorkerTests.swift
//  swift-fundamentalsTests
//
//  Created by Kaique Alves on 09/07/25.
//

import Foundation
import XCTest
@testable import swift_fundamentals

class LoginWorkerTests: XCTestCase {
    
    // MARK: - Methods
    
    func testMakeLoginSuccess() {
        let firebaseAuthServiceStub = FirebaseAuthService.Stub()
        firebaseAuthServiceStub.shouldSucceed = true
        
        let worker = LoginWorker.mock(firebaseAuthService: firebaseAuthServiceStub)
        
        worker.makeLoginRequest(email: "", password: "") { result in
            switch result {
            case .success(let success):
                XCTAssertTrue(success)
            
            case .failure:
                XCTFail("Should be success")
            }
        }
    }
    
    func testMakeLoginFailed() {
        let firebaseAuthServiceStub = FirebaseAuthService.Stub()
        firebaseAuthServiceStub.shouldSucceed = false
        
        let worker = LoginWorker.mock(firebaseAuthService: firebaseAuthServiceStub)
        
        worker.makeLoginRequest(email: "", password: "") { result in
            switch result {
            case .failure:
                XCTAssert(true)
            
            case .success:
                XCTFail("Should be error")
            }
        }
    }
}

// MARK: - Mock

extension LoginWorker {
    
    static func mock(firebaseAuthService: FirebaseAuthServiceProtocol = FirebaseAuthService.Stub()) -> LoginWorker {
        .init(firebaseAuthService: firebaseAuthService)
    }
}

extension LoginWorker {
    
    class Stub: LoginWorkerProtocol {
        let expectedResult: LoginWorker.MakeLoginResult
        var makeLoginRequestCalled = false
        var emailValue = ""
        var passwordValue = ""
        
        init(expectedResult: LoginWorker.MakeLoginResult) {
            self.expectedResult = expectedResult
        }

        func makeLoginRequest(email: String, password: String, completion: @escaping (LoginWorker.MakeLoginResult) -> Void) {
            self.emailValue = email
            self.passwordValue = password
            completion(expectedResult)
        }
    }
}
