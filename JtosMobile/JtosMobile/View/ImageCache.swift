import Foundation
import SwiftUI

class ImageCache {
    
    private static var imageCache = ImageCache()
    
    var storage: [String: Image] = [:]
    
    private init() {}
    
    static func shared() -> ImageCache {
        return imageCache
    }
    
    static func setImageForId(id: String, image: Image) {
        if imageCache.storage.keys.count > 100 {
            imageCache.storage = [:]
        }
        imageCache.storage[id] = image
    }
    
    static func getImage(for id: String) -> Image? {
        return imageCache.storage[id]
    }
    
    static func getImage(for id: String) -> Image {
        return imageCache.storage[id] ?? Image("placeholder")
    }
}
