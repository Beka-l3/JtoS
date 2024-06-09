import SwiftUI

protocol JtoSStoreable {
    static var `default`: Self { get }
}

extension Int: JtoSStoreable {
    static var `default`: Int { 0 }
}

extension String: JtoSStoreable {
    static var `default`: String { "" }
}

extension Bool: JtoSStoreable {
    static var `default`: Bool { false }
}




struct CounterExampleView: View {

    @State var store: [String: any JtoSStoreable]

    var body: some View {
        ZStack {
            Color.fromHex("222242").ignoresSafeArea()

            HStack {
                if storeGet(for: "button_123") > 0 {
                    Button {
                        storeUpdate(for: "button_123", action: .decrease(value: 1))
                    } label: {
                        Text("-").font(.system(size: 24))
                    }

                    Text("\(storeGet(for: "button_123", printType: true) as Int)") // TODO: get rid of hard-coded casting
                        .padding(.horizontal, 24)
                        .font(.system(size: 24))
                        .foregroundStyle(Color.white)
                }

                Button {
                    storeUpdate(for: "button_123", action: .increase(value: 1))
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
        self.store = ["button_123": 0]
    }
}


private enum StoreAction {

    case increase(value: Int)
    case decrease(value: Int)
    case update(value: any JtoSStoreable)
}


private extension CounterExampleView {

    func storeGet<T: JtoSStoreable>(for id: String, printType: Bool = false) -> T {
        if printType { print(T.self, "default: \(T.default)") }
        return (store[id] as? T) ?? T.default
    }

    func storeUpdate(for id: String, action: StoreAction) {
        switch action {

        case let .increase(value):
            storeSet(for: id, value: (storeGet(for: id) as Int) + value)

        case let .decrease(value):
            storeSet(for: id, value: (storeGet(for: id) as Int) - value)

        case let .update(value):
            storeSet(for: id, value: value)
        }
    }

    func storeSet<T: JtoSStoreable>(for id: String, value: T) {
        store[id] = value
    }
}
