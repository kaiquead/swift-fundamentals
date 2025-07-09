//
//  LoginViewTests.swift
//  swift-fundamentalsTests
//
//  Created by Kaique Alves on 09/07/25.
//

import XCTest
import SnapKit
import SnapshotTesting
@testable import swift_fundamentals

final class LoginViewTests: XCTestCase {

    func testLoginViewSnapshot() {
        let view = LoginView()
        
        view.snp.makeConstraints { make in
            make.width.equalTo(393)
            make.height.equalTo(852)
        }

        assertSnapshot(of: view, as: .image, record: false)
    }
}
