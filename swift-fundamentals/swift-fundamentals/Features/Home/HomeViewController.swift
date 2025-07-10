//
//  HomeViewController.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 07/07/25.
//

import Foundation
import UIKit

protocol HomeViewControllerInputProtocol: AnyObject {
    
}

protocol HomeViewControllerOutputProtocol: AnyObject {
    func loadNewsOnScreen(news: HomeNews)
    func showApiError()
}

class HomeViewController: UIViewController {
    
    // MARK: - Initialization
    
    let interactor: HomeInteractorProcol
    let router: HomeRouterProtocol
    
    init(interactor: HomeInteractorProcol, router: HomeRouterProtocol) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
        
        interactor.loadHomeNews(isFirstPage: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = HomeView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            guard let view = self.view as? HomeView else { return }
            view.delegate = self
        }
        
        guard let router = router as? HomeRouter else { return }
        router.delegate = self
    }
}

// MARK: - Inputs

extension HomeViewController: HomeViewControllerInputProtocol, HomeViewDelegate, HomeRouterDelegate {
    
    func loadMoreNewsFromInfinityScroll() {
        interactor.loadHomeNews(isFirstPage: false)
    }
    
    func okAction() {
        DispatchQueue.main.async {
            guard let view = self.view as? HomeView else { return }
            view.setIsLoading(false)
        }
    }
    
    func selectedArticle(article: HomeNews.Article) {
        router.goToArticleDetail(article: article)
    }
}

// MARK: - Outputs

extension HomeViewController: HomeViewControllerOutputProtocol {
    
    func loadNewsOnScreen(news: HomeNews) {
        DispatchQueue.main.async {
            guard let view = self.view as? HomeView else { return }
            view.loadArticles(articles: news.articles, totalArticles: news.totalResults)
        }
    }
    
    func showApiError() {
        router.showApiError()
    }
}
