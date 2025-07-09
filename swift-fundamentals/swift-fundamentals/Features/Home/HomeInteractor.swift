//
//  HomeInteractor.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 07/07/25.
//

import Foundation

protocol HomeInteractorProcol {
    func loadHomeNews(isFirstPage: Bool)
}

class HomeInteractor: HomeInteractorProcol {
    
    // MARK: - Private properties
    
    private var page = 1
    
    // MARK: - Initialization
    
    let presenter: HomePresenterProtocol
    let worker: HomeWorkerProtocol
    
    init(presenter: HomePresenterProtocol, worker: HomeWorkerProtocol) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func loadHomeNews(isFirstPage: Bool) {
        if !isFirstPage {
            page += 1
        }
        
        worker.makeInitialNewsRequest(page: page) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let news):
                self.presenter.loadNewsOnScreen(news: news)
                
            case .failure:
                self.presenter.showApiError()
            }
        }
    }
}
