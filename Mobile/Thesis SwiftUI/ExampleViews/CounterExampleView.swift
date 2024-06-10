import SwiftUI


struct CounterExampleView: View {

    @State private var store: ExampleStore

    var body: some View {
        ZStack {
            Color.fromHex("222242").ignoresSafeArea()

            HStack {
                if store.get(for: "button_123") > 0 {
                    Button {
                        store.update(for: "button_123", action: .decrease(value: 1))
                    } label: {
                        Text("-").font(.system(size: 24))
                    }

                    Text("\(store.get(for: "button_123", printType: true) as Int)") // TODO: get rid of hard-coded casting
                        .padding(.horizontal, 24)
                        .font(.system(size: 24))
                        .foregroundStyle(Color.white)
                }

                Button {
                    store.update(for: "button_123", action: .increase(value: 1))
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
        self.store = .init(store: ["button_123": 0])
    }
}








private protocol ExampleStoreable {
    static var defaultValue: Self { get }
}

extension Int: ExampleStoreable {
    static var defaultValue: Int { 0 }
}

extension String: ExampleStoreable {
    static var defaultValue: String { "" }
}

extension Bool: ExampleStoreable {
    static var defaultValue: Bool { false }
}

private struct ExampleStore {

    var store: [String: any ExampleStoreable]
}

private extension ExampleStore {

    enum StoreAction {

        case increase(value: Int)
        case decrease(value: Int)
        case update(value: any ExampleStoreable)
    }

    func get<T: ExampleStoreable>(for id: String, printType: Bool = false) -> T {
        if printType { print(T.self, "default: \(T.defaultValue)") }


//        if let value = store[id] {
//            switch T.self {
//            case let integer as Int: return integer
//            case let string as String: return string
//            case let bool as Bool: return bool
//
//            default: return .defaultValue
//            }
//        }

        return store[id] as? T ?? T.defaultValue
    }

    mutating func update(for id: String, action: StoreAction) {
        switch action {

        case let .increase(value):
            set(for: id, value: (get(for: id) as Int) + value)

        case let .decrease(value):
            set(for: id, value: (get(for: id) as Int) - value)

        case let .update(value):
            set(for: id, value: value)
        }
    }

    mutating func set<T: ExampleStoreable>(for id: String, value: T) {
        store[id] = value
    }
}
