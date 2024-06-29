import SwiftUI

struct ParamsCommon {

    let frame: Frame
    let padding: Padding
    let padding2: Padding

    let cornerRadius: CGFloat
    let ignoresSafeArea: Bool
    let bgColorHex: String?

    let actionType: ActionType?
    let state: JtoSState?

    // MARK: Init

    init(params: Params) {
        self.frame      = Self.convert(frame: params.frame)
        self.padding    = Self.convert(padding: params.padding)
        self.padding2   = Self.convert(padding: params.padding2)

        self.ignoresSafeArea = params.ignoresSafeArea ?? false
        self.cornerRadius = CGFloat(params.cornerRadius ?? 0)
        self.bgColorHex = params.bgColorHex

        self.actionType = Self.convert(onTapAction: params.onTapAction)
        self.state      = Self.convert(state: params.state)
    }
}

// MARK: - Nested Types

extension ParamsCommon {

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
}

extension ParamsCommon {

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
}

extension ParamsCommon {

    enum ActionType {

        enum VarAction {

            case set(varId: String, value: Int)
            case add(varId: String, value: Int)
            case sub(varId: String, value: Int)
            case mult(varId: String, value: Int)
            case div(varId: String, value: Int)

            case unkown
        }

        case none
        case openBottomSheetUrl(string: String)
        case openBottomSheetMock(filename: String)
        case openNewView(urlString: String)
        case goBack
        case update
        case varAction(VarAction)
    }
}

extension ParamsCommon {

    struct State: Decodable, Equatable, Hashable {

        var conditional: String?
        var valueForConditional: Int?

        var varId: String?
    }
}

extension ParamsCommon {

    struct JtoSState {

        // MARK: Nested Types

        struct Conditional {

            // MARK: Nested Types

            enum Condition {

                case equal(Int), notEqual(Int)
                case greater(Int), greaterOrEqual(Int)
                case less(Int), lessOrEqual(Int)

                case unkown
            }

            // MARK: Internal Properties

            let condition: Condition
            let varId: String
        }

        // MARK: Internal Properties

        let conditional: Conditional?
    }
}


// MARK: - Public Type methods

extension ParamsCommon {

    static func convert(onTapAction: Params.OnTapAction?) -> ActionType? {
        if let varActionRaw = onTapAction?.varAction {
            let varAction: ActionType.VarAction = switch varActionRaw.action {
                case "set": .set(varId: varActionRaw.varId, value: varActionRaw.value)
                case "add": .add(varId: varActionRaw.varId, value: varActionRaw.value)
                case "sub": .sub(varId: varActionRaw.varId, value: varActionRaw.value)
                case "mult": .mult(varId: varActionRaw.varId, value: varActionRaw.value)
                case "div": .div(varId: varActionRaw.varId, value: varActionRaw.value)
                default: .unkown
            }

            return .varAction(varAction)

        } else if let bottomSheet = onTapAction?.bottomSheet {

            if bottomSheet.source == "mock" {
                return ActionType.openBottomSheetMock(filename: bottomSheet.string)

            } else {
                return ActionType.openBottomSheetUrl(string: bottomSheet.string)

            }
        }

        return nil
    }

    static func convert(state: Params.State?) -> JtoSState? {
        if let state {
            if
                let conditional = state.conditional,
                let valueForConditional = state.valueForConditional,
                let varId = state.varId
            {
                let condition: JtoSState.Conditional.Condition = switch conditional {
                    case "equal": .equal(valueForConditional)
                    case "notEqaul": .notEqual(valueForConditional)
                    case "greater": .greater(valueForConditional)
                    case "greaterOrEqual": .greaterOrEqual(valueForConditional)
                    case "less": .less(valueForConditional)
                    case "lessOrEqual": .lessOrEqual(valueForConditional)

                    default: .unkown
                }

                return JtoSState(conditional: .init(condition: condition, varId: varId))
            }
        }

        return nil
    }
}

// MARK: - Private Type Converters

extension ParamsCommon {

    private static func convert(frame: Params.FrameSize?) -> Frame {
        var alignment: Alignment = .center
        var width: Frame.WidthParamType
        var height: Frame.HeightParamType

        if let a = frame?.alignment {
            alignment = switch a {

            case "leading" : .leading
            case "trailing" : .trailing
            case "top" : .top
            case "bottom" : .bottom

            default : .center

            }
        }

        if          let w = frame?.width        { width = .width(value: w.value) }
        else if     let w = frame?.maxWidth     { width = .maxWidth(value: w.value) }
        else if     let w = frame?.minWidth     { width = .minWidth(value: w.value) }
        else                                    { width = .none }

        if          let h = frame?.height       { height = .height(value: h.value) }
        else if     let h = frame?.maxHeight    { height = .maxHeight(value: h.value) }
        else if     let h = frame?.minHeight    { height = .minHeight(value: h.value) }
        else                                    { height = .none }

        return .init(alignment: alignment, width: width, height: height)
    }

    private static func convert(padding: Params.Padding?) -> Padding {
        let jToSEdge: Padding.JtoSEdge

        if let es = padding?.edges {
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

        return .init(length: padding?.length ?? 0, edge: jToSEdge)
    }
}
