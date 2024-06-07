import SwiftUI

struct ParamsCommon: JtoSParams {

    // MARK: Nested Types

    struct ParamsFrame {

        // MARK: Nested Types

        enum WidthParamType {

            case none
            case width(value: CGFloat)
            case maxWidth(value: CGFloat)
            case minWidth(value: CGFloat)
        }

        enum HeightParamType {

            case none
            case height(value: CGFloat)
            case maxHeight(value: CGFloat)
            case minHeight(value: CGFloat)
        }

        // MARK: Internal Properties

        let alignment: Alignment
        let width: WidthParamType
        let height: HeightParamType
    }

    // MARK: Internal Properties

    let frame: ParamsFrame
    let cornerRadius: CGFloat
    let ignoresSafeArea: Bool

    // MARK: Init

    init(params: Params) {
        var alignment: Alignment
        if let a = params.alignment {
            alignment = switch a {

            case "leading" : .leading
            case "trailing" : .trailing
            case "top" : .top
            case "bottom" : .bottom

            default : .center

            }
        }
        else { alignment = .center }

        var width: ParamsFrame.WidthParamType
        if let w = params.width { width = .width(value: w.value) }
        else if let w = params.maxWidth { width = .maxWidth(value: w.value) }
        else if let w = params.minWidth { width = .minWidth(value: w.value) }
        else { width = .none }

        var height: ParamsFrame.HeightParamType
        if let h = params.width { height = .height(value: h.value) }
        else if let h = params.maxWidth { height = .maxHeight(value: h.value) }
        else if let h = params.minWidth { height = .minHeight(value: h.value) }
        else { height = .none }

        self.frame = .init(
            alignment: alignment,
            width: width,
            height: height
        )

        self.ignoresSafeArea = params.ignoresSafeArea ?? false
        self.cornerRadius = CGFloat(params.cornerRadius ?? 0)
    }
}
