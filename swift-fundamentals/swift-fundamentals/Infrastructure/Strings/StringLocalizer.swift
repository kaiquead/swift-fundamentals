//
//  StringLocalizer.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 07/07/25.
//

import Foundation

enum StringLocalizer {
    
    // MARK: - Login
    
    static var loginTitle: String {
        self.localizeString("loginTitle")
    }
    
    static var emailPlaceholder: String {
        self.localizeString("emailPlaceholder")
    }
    
    static var passwordPlaceholder: String {
        self.localizeString("passwordPlaceholder")
    }
    
    static var loginButtonTitle: String {
        self.localizeString("loginButtonTitle")
    }
    
    // MARK: - Home
    
    static var homeTitle: String {
        self.localizeString("homeTitle")
    }
    
    static var searchTitle: String {
        self.localizeString("searchTitle")
    }
    
    static var newsTitle: String {
        self.localizeString("newsTitle")
    }
    
    static var helloLabel: String {
        self.localizeString("helloLabel")
    }
    
    static var apiErrorTitle: String {
        self.localizeString("apiErrorTitle")
    }
    
    static var apiErrorDescription: String {
        self.localizeString("apiErrorDescription")
    }
    
    static var apiErrorOk: String {
        self.localizeString("apiErrorOk")
    }
    
    // MARK: - Localizer
    
    static func localizeString(_ key: String) -> String {
        return String(format: NSLocalizedString(key, comment: ""))
    }
}
