import Foundation


class ActionDispatcher {
    
    private let handlers: [AbstractActionHandler]
    
    init(actionHandlers: [AbstractActionHandler]) {
        self.handlers = actionHandlers
    }
    
    func dispatchAction(action: Action?) {
        guard let action else { return }
        switch action {
        case .printAction(let action):
            PrintActionHandler().handle(action: .printAction(action))
        }
    }
}
