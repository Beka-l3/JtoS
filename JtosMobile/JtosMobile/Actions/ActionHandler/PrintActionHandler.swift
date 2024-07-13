import Foundation

class PrintActionHandler: AbstractActionHandler {
    
    func handle(action: Action) {
        switch action {
        case .printAction(let printAction):
            print("PrintActionHandler - \(printAction.isBold)")
        default:
            return
        }
    }
}
