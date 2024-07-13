import Foundation

struct ListAction: DecodableAction {
    static var realType = "ListAction"
    let actions: [ActionWrapper]
}

extension ListAction: Hashable {
    static func == (lhs: ListAction, rhs: ListAction) -> Bool {
        let left = lhs.actions.reduce("") {
            $0 + $1.id
        }
        let right = rhs.actions.reduce("") {
            $0 + $1.id
        }
        return left == right
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(actions.reduce("") {
            $0 + $1.id
        })
    }
}
