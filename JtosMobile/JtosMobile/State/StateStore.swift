import Foundation
import Combine

class StateStore: ObservableObject {
    @Published var store: [String: Variable] = [:]
    
    func readVariable(variable: TextVariable?) -> String {
        guard 
            let variableUnwrapped = variable,
            let variable = store[variableUnwrapped.name]
        else { return "" }
        return variable.toString
    }
    
    func readVariable(variable: ImageVariable?) -> Bool {
        guard
            let variableUnwrapped = variable,
            let variable = store[variableUnwrapped.name]
        else { return false }
        switch variable {
        case .boolean(let value):
            return value
        case .integer(_):
            return false
        }
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
    
    func changeBooleanVariable(
        with id: String,
        defaultValue: Bool
    ) {
        if let value = store[id] {
            switch(value) {
            case .integer(_):
                fatalError("tried to change boolean variable to integer")
            case .boolean(let boolValue):
                store[id] = Variable.boolean(!boolValue)
            }
        } else {
            store[id] = Variable.boolean(!defaultValue)
        }
    }
    
    func updateVariable(variable: TextVariable) -> Variable {
        let id = variable.name
        let value = switch variable.type {
        case .boolean(let value):
            Variable.boolean(value.defaultValue)
        case .integer(let value):
            Variable.integer(value.defaultValue)
        }
        if let oldValue = store[id],
           value == oldValue {
            return oldValue
        }
        store[id] = value
        return value
    }
    
    func updateVariable(variable: ImageVariable) -> Variable {
        let id = variable.name
        let value = switch variable.type {
        case .boolean(let value):
            Variable.boolean(value.defaultValue)
        case .integer(let value):
            Variable.integer(value.defaultValue)
        }
        if let oldValue = store[id],
           value == oldValue {
            return oldValue
        }
        store[id] = value
        return value
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
