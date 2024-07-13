import SwiftUI

// MARK: View Modifier

struct ApplyTextParams: ViewModifier {

    var params: ParamsText

    func body(content: Content) -> some View {
        content
            .font(params.font)
            .foregroundStyle(params.foregroundColor)
    }
}

// MARK: Text

extension JtoSView {

    @ViewBuilder
    func textView(for element: Binding<JtoS>) -> some View {
        let params = ParamsText(params: element.wrappedValue.params)

        resolveTextView(varName: params.textFromVar, textValue: params.textValue)
            .modifier(ApplyTextParams(params: params))
            .modifier(ApplyCommonParams(params: ParamsCommon(params: element.wrappedValue.params)))
    }

    private func resolveTextView(varName: String?, textValue: String) -> Text {
        if let varName {
            return Text("\(store.get(for: varName))")
        } else {
            return Text(textValue)
        }
    }
}
