//
//  Extensions.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 07/07/25.
//

import Foundation

extension Encodable {
    var toData: Data? {
        try? JSONEncoder().encode(self)
    }
}
