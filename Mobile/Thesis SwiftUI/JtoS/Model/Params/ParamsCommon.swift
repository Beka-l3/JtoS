import SwiftUI

struct ParamsCommon: JtoSParams {

    let width: CGFloat?
    let height: CGFloat?

    let cornerRadius: CGFloat

    let ignoresSafeArea: Bool

    init(params: Params) {
        if let size = params.size {
            self.width = CGFloat(size.w)
            self.height = CGFloat(size.h)
        } else {
            self.width = nil
            self.height = nil
        }
        self.ignoresSafeArea = params.ignoresSafeArea ?? false
        self.cornerRadius = CGFloat(params.cornerRadius ?? 0)
    }
}
