//
//  LoginPresenterTests.swift
//  swift-fundamentalsTests
//
//  Created by Kaique Alves on 09/07/25.
//

import Foundation
import XCTest
@testable  import swift_fundamentals

class LoginPresenterTests: XCTestCase {
    
    // MARK: - Methods
    
    func testShowApiError() {
        var presenter = LoginPresenter.mock()
        let loginViewControllerStub = LoginViewController.OutputStub()
        presenter.loginViewController = loginViewControllerStub
        
        presenter.showApiError()
        
        XCTAssert(loginViewControllerStub.showApiErrorCalled)
    }
    
    func testLoginSuccessful() {
        var presenter = LoginPresenter.mock()
        let loginViewControllerStub = LoginViewController.OutputStub()
        presenter.loginViewController = loginViewControllerStub
        
        presenter.loginSuccessful()
        
        XCTAssert(loginViewControllerStub.loginSuccessfulCalled)
    }
}

// MARK: - Mock

extension LoginPresenterProtocol {
    
    static func mock() -> LoginPresenterProtocol {
        LoginPresenter()
    }
}

// MARK: - Stub

extension LoginPresenter {
    
    class Stub: LoginPresenterProtocol {
        var loginViewController: (LoginViewControllerOutputProtocol)?
        
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
