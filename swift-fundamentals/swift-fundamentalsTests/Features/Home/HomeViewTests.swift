//
//  HomeViewTestes.swift
//  swift-fundamentalsTests
//
//  Created by Kaique Alves on 08/07/25.
//

import XCTest
import SnapKit
import SnapshotTesting
@testable import swift_fundamentals

final class HomeViewTests: XCTestCase {

    func testHomeViewSnapshot() {
        let view = HomeView()
        view.loadArticles(articles: [.mock(title: "Teste", description: "Teste", publishedAt: "2025-07-07T18:26:26Z")], totalArticles: 1)
        
        view.snp.makeConstraints { make in
            make.width.equalTo(375)
            make.height.equalTo(667)
        }

        assertSnapshot(of: view, as: .image, record: false)
    }
}
