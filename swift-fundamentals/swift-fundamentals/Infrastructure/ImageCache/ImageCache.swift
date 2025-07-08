//
//  ImageCache.swift
//  swift-fundamentals
//
//  Created by Kaique Alves on 08/07/25.
//

import Foundation
import UIKit

class ImageCache {
    static let shared = ImageCache()

    private let cache = NSCache<NSURL, UIImage>()

    private init() {}

    func image(for url: URL) -> UIImage? {
        return cache.object(forKey: url as NSURL)
    }

    func setImage(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url as NSURL)
    }
    
    func removeAllObjects() {
        cache.removeAllObjects()
    }
}
