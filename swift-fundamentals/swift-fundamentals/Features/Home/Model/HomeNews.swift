//
//  HomeNews.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 07/07/25.
//

import Foundation

struct HomeNews: Codable, Equatable {
    let status: String
    let totalResults: Int
    let articles: [Article]
    
    static func == (lhs: HomeNews, rhs: HomeNews) -> Bool {
        return lhs.status == rhs.status &&
               lhs.totalResults == rhs.totalResults &&
               lhs.articles == rhs.articles
    }
}

extension HomeNews {
    
    struct Article: Codable, Equatable {
        let author: String?
        let title: String?
        let description: String?
        let content: String?
        let urlToImage: URL?
        let publishedAt: String?
    }
}
