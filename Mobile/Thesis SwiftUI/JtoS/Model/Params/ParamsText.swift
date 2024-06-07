import SwiftUI

struct ParamsText: JtoSParams {

    let value: String
    let font: Font
    let foregroundColor: Color

    // MARK: Init

    init(params: Params) {
        self.value = params.value ?? ""
        self.font = .system(size: CGFloat(params.fontSize ?? 16))
        self.foregroundColor = Color.fromHex(params.colorHex ?? "")
    }
}
