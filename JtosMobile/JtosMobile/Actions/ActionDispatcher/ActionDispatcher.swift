import Foundation


class ActionDispatcher {
    
    private let handlers: [AbstractActionHandler]
    
    init(actionHandlers: [AbstractActionHandler]) {
        self.handlers = actionHandlers
    }
    
    func dispatchAction(action: Action?) {
        guard let action else { return }
        for handler in handlers {
            handler.handle(action: action)
        }
    }
}
