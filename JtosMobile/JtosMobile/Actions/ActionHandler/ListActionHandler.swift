import Foundation

class ListActionHandler: AbstractActionHandler {
    
    weak var actionDispatcher: ActionDispatcher?
    
    init(actionDispatcher: ActionDispatcher) {
        self.actionDispatcher = actionDispatcher
    }
    
    func handle(action: Action) {
        switch action {
        case .listAction(let listAction):
            listAction.actions.forEach {
                actionDispatcher?.dispatchAction(action: $0.action)
            }
        default:
            return
        }
    }
}
