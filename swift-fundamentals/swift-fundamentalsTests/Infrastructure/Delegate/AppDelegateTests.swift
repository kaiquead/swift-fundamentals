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
        let spy = NewsAPIKeyManagerSpy()
        let appDelegate = AppDelegate()
        appDelegate.newsAPIKeyManager = spy

        _ = appDelegate.application(
            UIApplication.shared,
            didFinishLaunchingWithOptions: nil
        )

        XCTAssertTrue(spy.initializeFromSecretsIfNeededCalled, "The method must be called")
    }
}
