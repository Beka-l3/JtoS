import SwiftUI

struct ParamsCommon: JtoSParams {

    // MARK: Nested Types

    struct Frame {

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

    struct Padding {

        // MARK: Nested Types

        enum JtoSEdge {

            case none
            case set(Edge.Set)
        }

        // MARK: Internal Properties

        let length: CGFloat
        let edge: JtoSEdge
    }

    // MARK: Internal Properties

    let frame: Frame
    let padding: Padding
    let padding2: Padding

    let cornerRadius: CGFloat
    let ignoresSafeArea: Bool

    let bgColorHex: String?

    // MARK: Init

    init(params: Params) {
        var alignment: Alignment
        if let a = params.frame?.alignment {
            alignment = switch a {

            case "leading" : .leading
            case "trailing" : .trailing
            case "top" : .top
            case "bottom" : .bottom

            default : .center

            }
        }
        else { alignment = .center }

        var width: Frame.WidthParamType
        if let w = params.frame?.width { width = .width(value: w.value) }
        else if let w = params.frame?.maxWidth { width = .maxWidth(value: w.value) }
        else if let w = params.frame?.minWidth { width = .minWidth(value: w.value) }
        else { width = .none }

        var height: Frame.HeightParamType
        if let h = params.frame?.height { height = .height(value: h.value) }
        else if let h = params.frame?.maxHeight { height = .maxHeight(value: h.value) }
        else if let h = params.frame?.minHeight { height = .minHeight(value: h.value) }
        else { height = .none }

        self.frame = .init(
            alignment: alignment,
            width: width,
            height: height
        )

        let jToSEdge: Padding.JtoSEdge
        if let es = params.padding?.edges {
            var edgesSet: Edge.Set = []

            for e in es {

                let edge: Edge.Set = switch e {

                case "leading": .leading
                case "trailing": .trailing
                case "horizontal": .horizontal
                case "vertical": .vertical
                case "top": .top
                case "bottom": .bottom

                default: .all

                }

                edgesSet.insert(edge)
            }

            jToSEdge = .set(edgesSet)
        } else {
            jToSEdge = .none
        }

        self.padding = .init(
            length: params.padding?.length ?? 0,
            edge: jToSEdge
        )

        let jToSEdge2: Padding.JtoSEdge
        if let es = params.padding2?.edges {
            var edgesSet: Edge.Set = []

            for e in es {

                let edge: Edge.Set = switch e {

                case "leading": .leading
                case "trailing": .trailing
                case "horizontal": .horizontal
                case "vertical": .vertical
                case "top": .top
                case "bottom": .bottom

                default: .all

                }

                edgesSet.insert(edge)
            }

            jToSEdge2 = .set(edgesSet)
        } else {
            jToSEdge2 = .none
        }

        self.padding2 = .init(
            length: params.padding2?.length ?? 0,
            edge: jToSEdge2
        )

        self.ignoresSafeArea = params.ignoresSafeArea ?? false
        self.cornerRadius = CGFloat(params.cornerRadius ?? 0)
        self.bgColorHex = params.bgColorHex
    }
}
