import Foundation

struct ChangeIntegerStateAction: Decodable {
    static var realType = "ChangeIntegerStateAction"
    let variableName: String
    let newValue: Int
    let type: IntegerStateChangeType
}

enum IntegerStateChangeType: String, Decodable {
    case absolute
    case fromExisting
}

extension ChangeIntegerStateAction: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(variableName)
        hasher.combine(newValue)
        hasher.combine(type)
    }
}
