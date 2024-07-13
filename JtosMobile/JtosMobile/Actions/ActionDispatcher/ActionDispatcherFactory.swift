import Foundation

class ActionDispatcherFactory {
    static func createActionDispatcher() -> ActionDispatcher {
        let dispatcher = ActionDispatcher()
        return dispatcher
    }
    
    static func updateActionHandlers(
        actionDispatcher: ActionDispatcher,
        stateStore: StateStore,
        viewModel: ScreenEngineViewModel
    ) {
        let actionHandlers: [AbstractActionHandler] = [
            PrintActionHandler(),
            ChangeIntegerStateActionHandler(stateStore: stateStore),
            ListActionHandler(actionDispatcher: actionDispatcher),
            PatchActionHandler(viewModel: viewModel, stateStore: stateStore)
        ]
        actionDispatcher.updateHandlers(handlers: actionHandlers)
    }
}
