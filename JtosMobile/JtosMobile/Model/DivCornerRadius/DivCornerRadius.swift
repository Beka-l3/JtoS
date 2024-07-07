import Foundation
import SwiftUI

struct DivCornerRadius: Decodable {
    let topLeading: CGFloat
    let topTrailing: CGFloat
    let bottomLeading: CGFloat
    let bottomTrailing: CGFloat
    
    private enum CodingKeys: String, CodingKey {
        case topLeading
        case topTrailing
        case bottomLeading
        case bottomTrailing
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        topLeading = try container.decodeIfPresent(CGFloat.self, forKey: .topLeading) ?? 0.0
        topTrailing = try container.decodeIfPresent(CGFloat.self, forKey: .topTrailing) ?? 0.0
        bottomLeading = try container.decodeIfPresent(CGFloat.self, forKey: .bottomLeading) ?? 0.0
        bottomTrailing = try container.decodeIfPresent(CGFloat.self, forKey: .bottomTrailing) ?? 0.0

    }
}
