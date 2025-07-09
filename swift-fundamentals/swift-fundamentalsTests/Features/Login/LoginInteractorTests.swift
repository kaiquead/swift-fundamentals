//
//  LoginInteractorTests.swift
//  swift-fundamentalsTests
//
//  Created by Kaique Alves on 09/07/25.
//

import Foundation
import XCTest
@testable import swift_fundamentals

class LoginInteractorTests: XCTestCase {
    
    // MARK: - Methods
    
    func testMakeLoginWithSuccess() {
        let expectedResult: LoginWorker.MakeLoginResult = .success(true)
        let presenter = LoginPresenter.Stub()
        let worker = LoginWorker.Stub(expectedResult: expectedResult)
        let interactor = LoginInteractor.mock(presenter: presenter, worker: worker)
        
        interactor.makeLogin(email: "email@email.com", password: "123456")
        
        XCTAssert(presenter.loginSuccessfulCalled)
    }
    
    func testMakeLoginWithFailure() {
        let expectedResult: LoginWorker.MakeLoginResult = .failure(HttpClient.RequestError.responseError)
        let presenter = LoginPresenter.Stub()
        let worker = LoginWorker.Stub(expectedResult: expectedResult)
        let interactor = LoginInteractor.mock(presenter: presenter, worker: worker)
        
        interactor.makeLogin(email: "email@email.com", password: "123456")
        
        XCTAssert(presenter.showApiErrorCalled)
    }
}

// MARK: - Mock

extension LoginInteractor {
    
    static func mock(
        presenter: LoginPresenterProtocol = LoginPresenter.Stub(),
        worker: LoginWorkerProtocol = LoginWorker.Stub(expectedResult: .success(true))
    ) -> LoginInteractorProcol {
        LoginInteractor(presenter: presenter, worker: worker)
    }
}

// MARK: - Stub

extension LoginInteractor {
    
    class Stub: LoginInteractorProcol {
        var makeLoginCalled = false
        var emailValue = ""
        var passwordValue = ""
        
        func makeLogin(email: String, password: String) {
            makeLoginCalled = true
            self.emailValue = email
            self.passwordValue = password
        }
    }
}

