import Foundation
import SwiftUI

enum DivHorizontalAlignment: String, Decodable {
    case left
    case center
    case right
    
    func toSwiftUI() -> Alignment {
        switch(self) {
        case .left:
            return .leading
        case .center:
            return .center
        case .right:
            return .trailing
        }
    }
    
    func toSwiftUI() -> HorizontalAlignment {
        switch(self) {
        case .left:
            return .leading
        case .center:
            return .center
        case .right:
            return .trailing
        }
    }
}
