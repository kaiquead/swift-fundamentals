//
//  LoginViewControllerTests.swift
//  swift-fundamentalsTests
//
//  Created by Kaique Alves on 09/07/25.
//

import Foundation
import XCTest
@testable import swift_fundamentals

// MARK: - Spy

extension LoginViewController {
    
    class OutputSpy: LoginViewControllerOutputProtocol {
        var showApiErrorCalled = false
        var loginSuccessfulCalled = false
        
        func showApiError() {
            showApiErrorCalled = true
        }
        
        func loginSuccessful() {
            loginSuccessfulCalled = true
        }
    }
}

