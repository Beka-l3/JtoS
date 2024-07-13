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
        imageCache.storage[id] = image
    }
    
    static func getImage(for id: String) -> Image {
        return imageCache.storage[id] ?? Image("placeholder")
    }
}
