# swift-fundamentals

An educational iOS project demonstrating key concepts of scalable architecture, modern iOS development practices, and advanced UIKit & SwiftUI techniques.

OBS: The app's goal is to provide a framework for applying important Swift concepts. In other words, the project's visuals weren't a priority.

## 📐 Architecture

This project follows the **VIP (View-Interactor-Presenter)** architecture to ensure clear separation of concerns and testability. It promotes modularity, responsibility isolation, and easy maintenance.

## 🧱 Features

- ✅ Built using **ViewCode**, **Interface Builder**, and **SwiftUI** screens.
- ✅ **Networking Layer** fully testable and abstracted for reuse and mocking.
- ✅ **Dependency Injection** throughout the application for flexibility and testing.
- ✅ **GCD (Grand Central Dispatch)** for asynchronous image loading and caching.
- ✅ **Infinite Scrolling** for seamless user experience with large lists.
- ✅ **Localization support** with `.strings` files for **3 languages**.
- ✅ **Secure storage** using **SwiftKeychain**.
- ✅ **Unit and Snapshot Tests** to ensure UI and logic correctness.

## 🧪 Testing

- Unit testing using **XCTest**
- UI and visual consistency validated using **SnapshotTesting**
- Mocks and spies implemented for isolated component testing

## 🔧 Dependencies

Managed via **Swift Package Manager (SPM)**:

- [**SpriteKit**](https://developer.apple.com/documentation/spritekit) — Apple’s 2D game engine
- [**SnapshotTesting**](https://github.com/pointfreeco/swift-snapshot-testing) — For snapshot-based UI tests
- [**Firebase**](https://firebase.google.com/docs/ios/setup) — For authentication and backend integration

## 🚀 CI/CD

The project includes a GitHub Actions **pipeline** that:

- Runs on every push to `main` and `develop`
- Builds the project
- Runs unit tests
- Runs snapshot tests
- Validates with Swift Package Manager
