import SwiftUI

// MARK: View Modifier

struct ApplyScrollViewParams: ViewModifier {

    var params: ParamsScrollView

    func body(content: Content) -> some View {
        content
    }
}

// MARK: Scroll View

extension JtoSView {

    @ViewBuilder
    func scrollView(for element: Binding<JtoS>) -> some View {
        let params = ParamsScrollView(params: element.wrappedValue.params)
        ScrollView(params.axes) {
            if !element.ui.isEmpty {
                ForEach(element.ui, id: \.self) { uiChild in
                    JtoSView(model: uiChild)
                }
            }
        }
        .modifier(ApplyScrollViewParams(params: params))
        .modifier(ApplyCommonParams(params: ParamsCommon(params: element.wrappedValue.params)))
    }
}
