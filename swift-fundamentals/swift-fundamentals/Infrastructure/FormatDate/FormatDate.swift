//
//  FormatDate.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 08/07/25.
//

import Foundation

class FormatDate {
    
    static func format(dateString: String?) -> String {
        guard let dateString = dateString else { return "" }
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime]

        if let date = isoFormatter.date(from: dateString) {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "pt_BR")
            formatter.dateFormat = "dd/MM/yyyy 'às' HH:mm"

            let formattedString = formatter.string(from: date)
            return formattedString
        } else {
            return ""
        }
    }
}
