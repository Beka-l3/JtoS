import SwiftUI


struct CounterExampleView: View {

    @State private var store: ExampleStore

    var body: some View {
        ZStack {
            Color.fromHex("222242").ignoresSafeArea()

            HStack {
                if store.get(for: "button_123") > 0 {
                    Button {
                        store.update(for: "button_123", action: .sub(value: 1))
                    } label: {
                        Text("-").font(.system(size: 24))
                    }

                    Text("\(store.get(for: "button_123"))")
                        .padding(.horizontal, 24)
                        .font(.system(size: 24))
                        .foregroundStyle(Color.white)
                }

                Button {
                    store.update(for: "button_123", action: .add(value: 1))
                } label: {
                    Text("+").font(.system(size: 24))
                }
            }
            .frame(minWidth: 180, minHeight: 50)
            .background(Color.gray.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }

    init() {
        self.store = .init(variables: ["button_123": 0])
    }
}






private struct ExampleStore {

    enum UpdateAction {

        case set(value: Int)
        case add(value: Int)
        case sub(value: Int)
        case mult(value: Int)
        case div(value: Int)
    }

    var variables: [String: Int]
}


private extension ExampleStore {

    // MARK: Get

    func get(for id: String) -> Int {
        variables[id] ?? 0
    }

    // MARK: Update

    mutating func update(for id: String, action: UpdateAction) {
        switch action {
            case let .set(value): set(for: id, value: value)
            case let .add(value): set(for: id, value: get(for: id) + value)
            case let .sub(value): set(for: id, value: get(for: id) - value)
            case let .mult(value): set(for: id, value: get(for: id) * value)
            case let .div(value): set(for: id, value: get(for: id) * value)
        }
    }

    // MARK: Set

    mutating func set(for id: String, value: Int) {
        variables[id] = value
    }
}
