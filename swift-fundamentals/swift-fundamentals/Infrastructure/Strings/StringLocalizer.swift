//
//  StringLocalizer.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 07/07/25.
//

import Foundation

enum StringLocalizer {
    
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
