import SwiftUI

struct ParamsText: JtoSParams {

    let textValue: String
    let font: Font
    let foregroundColor: Color

    // MARK: Init

    init(params: Params) {
        self.textValue = params.textValue ?? ""
        self.font = .system(size: CGFloat(params.fontSize ?? 16))
        self.foregroundColor = Color.fromHex(params.colorHex ?? "")
    }
}
