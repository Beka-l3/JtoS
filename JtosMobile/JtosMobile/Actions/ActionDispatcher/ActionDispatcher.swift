import Foundation


class ActionDispatcher {
    
    private var handlers: [AbstractActionHandler] = []
    
    func dispatchAction(action: Action?) {
        guard let action else { return }
        for handler in handlers {
            handler.handle(action: action)
        }
    }
    
    func updateHandlers(handlers: [AbstractActionHandler]) {
        self.handlers = handlers
    }
}
