//
//  ErrorAlertController.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 09/07/25.
//

import UIKit

class ErrorAlertController {
    static func makeErrorView(clickOkAction: @escaping () -> Void) -> UIAlertController {
        let okAction = UIAlertAction(title: StringLocalizer.apiErrorOk, style: .default) { _ in
            clickOkAction()
        }
        
        let alertController = UIAlertController(title: StringLocalizer.apiErrorTitle, message: StringLocalizer.apiErrorDescription, preferredStyle: .alert)
        alertController.addAction(okAction)
        
        return alertController
    }
}
