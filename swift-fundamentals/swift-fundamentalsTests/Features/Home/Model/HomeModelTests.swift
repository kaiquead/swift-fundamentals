//
//  HomeModelTests.swift
//  swift-fundamentalsTests
//
//  Created by Kaique Alves on 07/07/25.
//

import Foundation
@testable import swift_fundamentals

extension HomeNews {
    
    static func mock(status: String = "ok", articles: [Article] = []) -> HomeNews {
        HomeNews(status: "ok", articles: [.mock()])
    }
}

extension HomeNews.Article {
    
    static func mock(
        author: String = "abc",
        title: String = "def",
        description: String = "ghi",
        content: String = "hjk",
        urlToImage: String? = nil,
        publishedAt: String = "12/12/12"
    ) -> HomeNews.Article {
        .init(
            author: author,
            title: title,
            description: description,
            content: content,
            urlToImage: nil,
            publishedAt: publishedAt
        )
    }
}
