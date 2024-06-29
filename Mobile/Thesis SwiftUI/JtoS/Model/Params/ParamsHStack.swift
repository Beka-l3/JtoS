import SwiftUI

struct ParamsHStack {

    let alignment: VerticalAlignment
    let spacing: CGFloat

    // MARK: Init

    init(params: Params) {
        self.alignment = switch params.alignment ?? "" {

            case "top": .top
            case "bottom": .bottom

            default: .center
        }
        self.spacing = CGFloat(params.spacing ?? 10)
    }
}
