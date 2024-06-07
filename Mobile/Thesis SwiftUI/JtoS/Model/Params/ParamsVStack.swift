import SwiftUI

struct ParamsVStack: JtoSParams {

    let alignment: HorizontalAlignment
    let spacing: CGFloat

    // MARK: Init

    init(params: Params) {
        self.alignment = switch params.alignment ?? "" {

            case "leading": .leading
            case "trailing": .trailing

            default: .center
        }
        self.spacing = CGFloat(params.spacing ?? 10)
    }
}
