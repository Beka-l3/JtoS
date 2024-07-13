import SwiftUI

struct JtoSView: View {

    @Binding var model: JtoS
    @EnvironmentObject var store: JtoSStore

    var body: some View {
        buildView(for: $model)
            .wrapIntoConditional(
                state: ParamsCommon.convert(state: $model.wrappedValue.params.state),
                store: store
            )
            .wrapIntoTapGesture(
                actionType: ParamsCommon.convert(onTapAction: $model.wrappedValue.params.onTapAction),
                store: store,
                shouldPresent: $store.shouldPresent
            )
    }
}

extension JtoSView {

    @ViewBuilder
    private func buildView(for element: Binding<JtoS>) -> some View {
        switch element.wrappedValue.jToSType {

            case .container: container(for: element)
            case .text: textView(for: element)
            case .image: imageView(for: element)
            case .color: colorView(for: element)
            case .vStack: vStackView(for: element)
            case .hStack: hStackView(for: element)
            case .zStack: zStackView(for: element)
            case .scrollView: scrollView(for: element)
            case .tabbar: tabbarNavigation(for: element)
            case .spacer: Spacer()

            default: empty
        }
    }
}

extension JtoSView {

    var empty: some View {
        ZStack {
            Color(.systemBackground).opacity(0.6)

            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                .scaleEffect(2.0, anchor: .center)
        }
    }
}

private extension View {

    @ViewBuilder
    func wrapIntoConditional(state: ParamsCommon.JtoSState?, store: JtoSStore) -> some View {
        if let state {
            if let conditional = state.conditional {
                switch conditional.condition {
                    case let .equal(value):             if value == store.get(for: conditional.varId) { self }
                    case let .notEqual(value):          if value != store.get(for: conditional.varId) { self }
                    case let .greater(value):           if value > store.get(for: conditional.varId) { self }
                    case let .greaterOrEqual(value):    if value >= store.get(for: conditional.varId) { self }
                    case let .less(value):              if value < store.get(for: conditional.varId) { self }
                    case let .lessOrEqual(value):       if value <= store.get(for: conditional.varId) { self }

                    default: self
                }
            }
            
            /// for other types of State
            /// else if { }

            else { self }
        }

        else { self }
    }

    @ViewBuilder
    func wrapIntoTapGesture(actionType: ParamsCommon.ActionType?, store: JtoSStore, shouldPresent: Binding<Bool>) -> some View {
        switch actionType {

            case let .openBottomSheetUrl(string):
                self.onTapGesture {
                    store.shouldPresent = true
                }
                .sheet(isPresented: shouldPresent) {
                    JtoSRootView(resource: .url(string: string))
                }

            case let .openBottomSheetMock(filename):
                self.onTapGesture {
                    store.shouldPresent = true
                }
                .sheet(isPresented: shouldPresent) {
                    JtoSRootView(resource: .mock(filename: filename))
                }

            case .openNewView(_):
                self

            case .goBack:
                self

            case .update:
                self

            case let .varAction(.set(varId, value)):
                self.onTapGesture {
                    store.update(for: varId, action: .set(value: value))
                }

            case let .varAction(.add(varId, value)):
                self.onTapGesture {
                    store.update(for: varId, action: .add(value: value))
                }

            case let .varAction(.sub(varId, value)):
                self.onTapGesture {
                    store.update(for: varId, action: .sub(value: value))
                }

            case let .varAction(.mult(varId, value)):
                self.onTapGesture {
                    store.update(for: varId, action: .mult(value: value))
                }

            case let .varAction(.div(varId, value)):
                self.onTapGesture {
                    store.update(for: varId, action: .div(value: value))
                }

            default: self
        }

    }
}
