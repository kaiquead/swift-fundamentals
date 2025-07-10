//
//  HomeRouter.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 07/07/25.
//

import Foundation
import SwiftUI
import UIKit

protocol HomeRouterDelegate: AnyObject {
    func okAction()
}

protocol HomeRouterProtocol {
    func showApiError()
    func goToArticleDetail(article: HomeNews.Article)
}

class HomeRouter: HomeRouterProtocol {
    
    // MARK: - Delegate
    
    weak var delegate: HomeRouterDelegate?
    
    // MARK: - Initialization
    
    let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    
    func showApiError() {
        let alertController = ErrorAlertController.makeErrorView { [weak self] in
            self?.delegate?.okAction()
        }
        
        DispatchQueue.main.async {
            self.navigationController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    func goToArticleDetail(article: HomeNews.Article) {
        var image: UIImage?
        
        if let url = article.urlToImage, let cachedImage = ImageCache.shared.image(for: url) {
            image = cachedImage
        }
        
        let articleDetailModel = ArticleDetailModel(
            title: article.title,
            description: article.description,
            date: FormatDate.format(dateString: article.publishedAt),
            image: image
        )
        
        let swiftUIView = ArticleDetailView(articleDetailModel: articleDetailModel)
        
        let hostingController = UIHostingController(rootView: swiftUIView)
        navigationController?.pushViewController(hostingController, animated: true)
    }
}
