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
        let loginViewControllerSpy = LoginViewController.OutputSpy()
        presenter.loginViewController = loginViewControllerSpy
        
        presenter.showApiError()
        
        XCTAssert(loginViewControllerSpy.showApiErrorCalled)
    }
    
    func testLoginSuccessful() {
        var presenter = LoginPresenter.mock()
        let loginViewControllerSpy = LoginViewController.OutputSpy()
        presenter.loginViewController = loginViewControllerSpy
        
        presenter.loginSuccessful()
        
        XCTAssert(loginViewControllerSpy.loginSuccessfulCalled)
    }
}

// MARK: - Mock

extension LoginPresenterProtocol {
    
    static func mock() -> LoginPresenterProtocol {
        LoginPresenter()
    }
}

// MARK: - Spy

extension LoginPresenter {
    
    class Spy: LoginPresenterProtocol {
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
