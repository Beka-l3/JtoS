import SwiftUI

protocol JtoSParams {}

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

struct ParamsImage: JtoSParams {

    let url: String
    let contentMode: ContentMode

    // MARK: Init

    init(params: Params) {
        self.url = params.value ?? ""
        self.contentMode = params.contentMode == "fill" ? .fill : .fit
    }
}

struct ParamsColor: JtoSParams {

    let colorHex: String

    // MARK: Init

    init(params: Params) {
        self.colorHex = params.colorHex ?? ""
    }
}

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

struct ParamsHStack: JtoSParams {

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

struct ParamsZStack: JtoSParams {

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

struct ParamsScrollView: JtoSParams {

    let spacing: CGFloat
    let axes: Axis.Set

    // MARK: Init

    init(params: Params) {
        self.spacing = CGFloat(params.spacing ?? 0)
        self.axes = params.axes == "horizontal" ? .horizontal : .vertical
    }
}
