//
//  AppDelegateTests.swift
//  swift-fundamentalsTests
//
//  Created by Kaique Alves on 05/07/25.
//

import XCTest
@testable import swift_fundamentals

final class AppDelegateTests: XCTestCase {
    func testInitializeFromSecretsIsCalledOnLaunch() {
        let mock = NewsAPIKeyManagerSpy()
        let appDelegate = AppDelegate()
        appDelegate.newsAPIKeyManager = mock

        _ = appDelegate.application(
            UIApplication.shared,
            didFinishLaunchingWithOptions: nil
        )

        XCTAssertTrue(mock.initializeFromSecretsIfNeededCalled, "The method must be called")
    }
}
