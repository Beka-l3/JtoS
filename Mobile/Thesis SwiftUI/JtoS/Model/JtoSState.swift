import SwiftUI

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

extension JtoSState {

    static func convertStateModel(rawState: Params.State?) -> JtoSState? {
        if let state = rawState {
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
