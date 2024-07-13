import Foundation

struct ChangeBooleanStateAction: DecodableAction {
    static var realType = "ChangeBooleanStateAction"
    let variableName: String
}


extension ChangeBooleanStateAction: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(variableName)
    }
}
