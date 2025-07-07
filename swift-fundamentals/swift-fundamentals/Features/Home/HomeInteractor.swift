//
//  HomeInteractor.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 07/07/25.
//

import Foundation

protocol HomeInteractorProcol {
    
}

class HomeInteractor: HomeInteractorProcol {
    
    // MARK: - Initialization
    
    let presenter: HomePresenterProtocol
    let worker: HomeWorkerProtocol
    
    init(presenter: HomePresenterProtocol, worker: HomeWorkerProtocol) {
        self.presenter = presenter
        self.worker = worker
    }
    
    
}
