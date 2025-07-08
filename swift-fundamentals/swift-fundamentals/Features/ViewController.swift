//
//  ViewController.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 04/07/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let teste = HomeView()
        self.view = teste
        
        ImageCache.shared.removeAllObjects()
        
        let worker = HomeWorker()
        worker.makeInitialNewsRequest(page: 1) { result in
        switch result {
            case .success(let news):
                teste.loadArticles(articles: news.articles, totalArticles: news.totalResults)
            case .failure(let error):
                print("Deu erro")
            }
        }
        
//        let navigationController = UINavigationController()
//        
//        let viewController = HomeFactory.makeHomeViewController(navigationController: navigationController)
//        navigationController.pushViewController(viewController, animated: true)
    }
}

