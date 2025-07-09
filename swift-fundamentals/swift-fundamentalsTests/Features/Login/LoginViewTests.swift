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
        
        let vc = UIViewController()
        vc.view = view
        vc.view.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
        
        let traits = UITraitCollection.current.modifyingTraits {
            $0.userInterfaceStyle = .light
            $0.displayScale = 2.0
        }

        let config = ViewImageConfig(
            size: CGSize(width: 375, height: 667),
            traits: traits
        )

        assertSnapshot(of: vc, as: .image(on: config), record: false)
    }
}
