import SwiftUI

protocol JtoSParams {}

struct ParamsCommon: JtoSParams {

    let width: CGFloat?
    let height: CGFloat?

    init(params: Params) {
        if let size = params.size {
            self.width = CGFloat(size.h)
            self.height = CGFloat(size.w)
        } else {
            self.width = nil
            self.height = nil
        }
    }
}

struct ParamsText: JtoSParams {

    let common: ParamsCommon

    let value: String
    let font: Font
    let foregroundColor: Color

    // MARK: Init

    init(params: Params) {
        self.common = ParamsCommon(params: params)
        self.value = params.value ?? ""
        self.font = .system(size: CGFloat(params.fontSize ?? 16))
        self.foregroundColor = Color.fromHex(params.colorHex ?? "")
    }
}

struct ParamsImage: JtoSParams {

    let common: ParamsCommon

    let url: String
    let contentMode: ContentMode

    // MARK: Init

    init(params: Params) {
        self.common = ParamsCommon(params: params)
        self.url = params.value ?? ""
        self.contentMode = params.contentMode == "fill" ? .fill : .fit
    }
}

struct ParamsColor: JtoSParams {

    let common: ParamsCommon

    let colorHex: String

    // MARK: Init

    init(params: Params) {
        self.common = ParamsCommon(params: params)
        self.colorHex = params.colorHex ?? ""
    }
}

struct ParamsVStack: JtoSParams {

    let common: ParamsCommon

    let alignment: HorizontalAlignment
    let spacing: CGFloat

    // MARK: Init

    init(params: Params) {
        self.common = ParamsCommon(params: params)
        self.alignment = switch params.alignment ?? "" {

            case "leading": .leading
            case "trailing": .trailing

            default: .center
        }
        self.spacing = CGFloat(params.spacing ?? 10)
    }
}

struct ParamsHStack: JtoSParams {

    let common: ParamsCommon

    let alignment: VerticalAlignment
    let spacing: CGFloat

    // MARK: Init

    init(params: Params) {
        self.common = ParamsCommon(params: params)
        self.alignment = switch params.alignment ?? "" {

            case "top": .top
            case "bottom": .bottom

            default: .center
        }
        self.spacing = CGFloat(params.spacing ?? 10)
    }
}

struct ParamsZStack: JtoSParams {

    let common: ParamsCommon

    let alignment: Alignment

    // MARK: Init

    init(params: Params) {
        self.common = ParamsCommon(params: params)
        self.alignment = switch params.alignment ?? "" {

            case "leading": .leading
            case "trailing": .trailing
            case "top": .top
            case "bottom": .bottom

            default: .center
        }
    }
}
