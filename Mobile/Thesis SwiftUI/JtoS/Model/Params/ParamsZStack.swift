import SwiftUI

struct ParamsZStack {
    
    let alignment: Alignment
    
    // MARK: Init
    
    init(params: Params) {
        self.alignment = switch params.alignment ?? "" {
            
        case "leading": .leading
        case "trailing": .trailing
        case "top": .top
        case "bottom": .bottom
            
        default: .center
        }
    }
}
