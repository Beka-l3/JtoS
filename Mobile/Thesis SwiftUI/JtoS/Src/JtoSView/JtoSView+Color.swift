import SwiftUI

// MARK: View Modifier

struct ApplyColorParams: ViewModifier {

    var params: ParamsColor

    func body(content: Content) -> some View {
        content
    }
}

// MARK: Color

extension JtoSView {

    @ViewBuilder
    func colorView(for element: Binding<JtoS>) -> some View {
        let params = ParamsColor(params: element.wrappedValue.params)
        Color.fromHex(params.colorHex)
            .modifier(ApplyColorParams(params: params))
            .modifier(ApplyCommonParams(params: ParamsCommon(params: element.wrappedValue.params)))
    }
}
