import Foundation
import SwiftUI

enum DivVerticalAlignment: String, Decodable {
    case top
    case center
    case bottom
    
    func toSwiftUI() -> Alignment {
        switch(self) {
        case .top:
            return .top
        case .center:
            return .center
        case .bottom:
            return .bottom
        }
    }
}
