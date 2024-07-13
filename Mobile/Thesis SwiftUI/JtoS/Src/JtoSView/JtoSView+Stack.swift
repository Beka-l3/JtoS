import SwiftUI

// MARK: View Modifier

struct ApplyVStackParams: ViewModifier {

    var params: ParamsVStack

    func body(content: Content) -> some View {
        content
    }
}

struct ApplyHStackParams: ViewModifier {

    var params: ParamsHStack

    func body(content: Content) -> some View {
        content
    }
}

struct ApplyZStackParams: ViewModifier {

    var params: ParamsZStack

    func body(content: Content) -> some View {
        content
    }
}

// MARK: Stacks

extension JtoSView {

    @ViewBuilder
    func vStackView(for element: Binding<JtoS>) -> some View {
        let params = ParamsVStack(params: element.wrappedValue.params)
        VStack(alignment: params.alignment, spacing: params.spacing) {
            if !element.ui.isEmpty {
                ForEach(element.ui, id: \.self) { uiChild in
                    JtoSView(model: uiChild)
                }
            }
        }
        .modifier(ApplyVStackParams(params: params))
        .modifier(ApplyCommonParams(params: ParamsCommon(params: element.wrappedValue.params)))
    }

    @ViewBuilder
    func hStackView(for element: Binding<JtoS>) -> some View {
        let params = ParamsHStack(params: element.wrappedValue.params)
        HStack(alignment: params.alignment, spacing: params.spacing) {
            if !element.ui.isEmpty {
                ForEach(element.ui, id: \.self) { uiChild in
                    JtoSView(model: uiChild)
                }
            }
        }
        .modifier(ApplyHStackParams(params: params))
        .modifier(ApplyCommonParams(params: ParamsCommon(params: element.wrappedValue.params)))
    }

    @ViewBuilder
    func zStackView(for element: Binding<JtoS>) -> some View {
        let params = ParamsZStack(params: element.wrappedValue.params)
        ZStack(alignment: params.alignment) {
            if !element.ui.isEmpty {
                ForEach(element.ui, id: \.self) { uiChild in
                    JtoSView(model: uiChild)
                }
            }
        }
        .modifier(ApplyZStackParams(params: params))
        .modifier(ApplyCommonParams(params: ParamsCommon(params: element.wrappedValue.params)))
    }
}
