//
//  LoginInteractor.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 09/07/25.
//

import Foundation

protocol LoginInteractorProcol {
    func makeLogin(email: String, password: String)
}

class LoginInteractor: LoginInteractorProcol {
    
    // MARK: - Initialization
    
    let presenter: LoginPresenterProtocol
    let worker: LoginWorkerProtocol
    
    init(presenter: LoginPresenterProtocol, worker: LoginWorkerProtocol) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func makeLogin(email: String, password: String) {
        worker.makeLoginRequest(email: email, password: password) { [weak self ]result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                self.presenter.loginSuccessful()
            case .failure(let error):
                self.presenter.showApiError()
            }
        }
    }
}
