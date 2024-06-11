import SwiftUI

struct ParamsButton: JtoSParams {

    // MARK: Nested Types

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
        case openBottomSheet(urlString: String)
        case openNewView(urlString: String)
        case goBack
        case update
        case varAction(VarAction)
    }

    // MARK: Internal Properties

    let textValue: String
    let actionType: ActionType?

    // MARK: Init

    init(params: Params) {
        self.textValue = params.textValue ?? ""

        if let varActionRaw = params.buttonAction?.varAction {
            let varAction: ActionType.VarAction = switch varActionRaw.action {
                case "set": .set(varId: varActionRaw.varId, value: varActionRaw.value)
                case "add": .add(varId: varActionRaw.varId, value: varActionRaw.value)
                case "sub": .sub(varId: varActionRaw.varId, value: varActionRaw.value)
                case "mult": .mult(varId: varActionRaw.varId, value: varActionRaw.value)
                case "div": .div(varId: varActionRaw.varId, value: varActionRaw.value)
                default: .unkown
            }

            self.actionType = .varAction(varAction)
        } else {
            self.actionType = nil
        }
    }
}
