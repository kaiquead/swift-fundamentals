//
//  HomePresenter.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 07/07/25.
//

import Foundation

protocol HomePresenterProtocol {
    var homeViewController: HomeViewControllerOutputProtocol? { get set }
    func loadNewsOnScreen(news: HomeNews)
    func showApiError()
}

class HomePresenter: HomePresenterProtocol {
    
    // MARK: - ViewController reference
    
    weak var homeViewController: HomeViewControllerOutputProtocol?
    
    // MARK: - Methods
    
    func loadNewsOnScreen(news: HomeNews) {
        homeViewController?.loadNewsOnScreen(news: news)
    }
    
    func showApiError() {
        homeViewController?.showApiError()
    }
}
