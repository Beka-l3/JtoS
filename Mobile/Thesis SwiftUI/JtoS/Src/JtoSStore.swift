import SwiftUI

final class JtoSStore: ObservableObject {

    // MARK: Nested Types

    enum UpdateAction {

        case set(value: Int)
        case add(value: Int)
        case sub(value: Int)
        case mult(value: Int)
        case div(value: Int)
    }

    // MARK: Internal Properties

    @Published var shouldPresent = false

    // MARK: Private Properties

    @Published private var variables: [String: Int]

    // MARK: Init

    init(variables: [String: Int] = [:]) {
        self.variables = variables
    }
}


extension JtoSStore {

    // MARK: Get

    func get(for id: String) -> Int {
        variables[id] ?? 0
    }

    func getBool(for id: String) -> Bool {
        get(for: id) > 0
    }

    // MARK: Set

    func set(for id: String, value: Int) {
        variables[id] = value
    }

    // MARK: Update

    func update(for id: String, action: UpdateAction) {
        switch action {
        case let .set(value): set(for: id, value: value)
        case let .add(value): set(for: id, value: get(for: id) + value)
        case let .sub(value): set(for: id, value: get(for: id) - value)
        case let .mult(value): set(for: id, value: get(for: id) * value)
        case let .div(value): set(for: id, value: get(for: id) * value)
        }
    }
}
