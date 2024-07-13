import Foundation
import Combine

class StateStore: ObservableObject {
    @Published var store: [String: Variable] = [:]
    
    func readVariable(variable: TextVariable?) -> String {
        guard let variableUnwrapped = variable else { return "" }
        let storeVariable = addToStoreIfNeeded(variable: variableUnwrapped)
        return storeVariable.toString
    }
    
    func changeIntegerVariable(
        with id: String,
        to newValue: Int,
        type: IntegerStateChangeType
    ) {
        switch(type) {
        case .absolute:
            store[id] = Variable.integer(newValue)
        case .fromExisting:
            if let value = store[id] {
                switch(value) {
                case .integer(let intValue):
                    store[id] = Variable.integer(intValue + newValue)
                case .boolean(_):
                    fatalError("tried to add integer to boolean variable")
                }
            } else {
                store[id] = Variable.integer(newValue)
            }
        }
    }
    
    private func addToStoreIfNeeded(variable: TextVariable) -> Variable {
        let id = variable.name
        let value = switch variable.type {
        case .boolean(let value):
            Variable.boolean(value.defaultValue)
        case .integer(let value):
            Variable.integer(value.defaultValue)
        }
        if store[id] == nil { store[id] = value }
        return store[id]!
    }
}

enum Variable: Encodable, Equatable {
    case integer(Int)
    case boolean(Bool)
    
    var toString: String {
        switch self {
        case .integer(let value):
            return "\(value)"
        case .boolean(let value):
            return "\(value)"
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let value):
            try container.encode(value)
        case .boolean(let value):
            try container.encode(value)
        }
    }
}
