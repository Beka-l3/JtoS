import Foundation

class ChangeBooleanStateActionHandler: AbstractActionHandler {
    
    let stateStore: StateStore
    init(stateStore: StateStore) {
        self.stateStore = stateStore
    }

    func handle(action: Action) {
        switch action {
        case .changeBooleanStateAction(let changeBooleanStateAction):
            stateStore.changeBooleanVariable(
                with: changeBooleanStateAction.variableName,
                defaultValue: false
            )
        default:
            return
        }
    }
}
