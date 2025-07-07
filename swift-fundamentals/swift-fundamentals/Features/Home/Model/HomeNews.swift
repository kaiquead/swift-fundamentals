//
//  HomeNews.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 07/07/25.
//

import Foundation

struct HomeNews: Codable {
    let status: String
    let articles: [Article]
}

extension HomeNews {
    
    struct Article: Codable {
        let author: String?
        let title: String?
        let description: String?
        let content: String?
        let urlToImage: URL?
        let publishedAt: String?
    }
}
