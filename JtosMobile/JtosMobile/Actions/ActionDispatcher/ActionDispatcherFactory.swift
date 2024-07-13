import Foundation

class ActionDispatcherFactory {
    static func createActionDispatcher(stateStore: StateStore) -> ActionDispatcher {
        let actionHandlers: [AbstractActionHandler] = [
            PrintActionHandler(),
            ChangeIntegerStateActionHandler(stateStore: stateStore)
        ]
        return ActionDispatcher(actionHandlers: actionHandlers)
    }
}
