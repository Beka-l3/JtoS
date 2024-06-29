import SwiftUI

struct ParamsScrollView {

    let spacing: CGFloat
    let axes: Axis.Set

    // MARK: Init

    init(params: Params) {
        self.spacing = CGFloat(params.spacing ?? 0)
        self.axes = params.axes == "horizontal" ? .horizontal : .vertical
    }
}
