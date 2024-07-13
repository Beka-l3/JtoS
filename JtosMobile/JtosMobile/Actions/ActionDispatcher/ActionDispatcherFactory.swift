import Foundation

class ActionDispatcherFactory {
    static func createActionDispatcher() -> ActionDispatcher {
        let actionHandlers: [AbstractActionHandler] = [
            PrintActionHandler()
        ]
        return ActionDispatcher(actionHandlers: actionHandlers)
    }
}
