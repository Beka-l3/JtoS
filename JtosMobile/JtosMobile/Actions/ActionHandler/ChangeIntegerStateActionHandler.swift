import Foundation

class ChangeIntegerStateActionHandler: AbstractActionHandler {
    
    let stateStore: StateStore
    init(stateStore: StateStore) {
        self.stateStore = stateStore
    }

    func handle(action: Action) {
        switch action {
        case .changeIntegerStateAction(let changeIntegerStateAction):
            stateStore.changeIntegerVariable(
                with: changeIntegerStateAction.variableName,
                to: changeIntegerStateAction.newValue,
                type: changeIntegerStateAction.type
            )
        default:
            return
        }
    }
}
