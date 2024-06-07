import SwiftUI

struct ApplyTextParams: ViewModifier {

    var params: ParamsText

    func body(content: Content) -> some View {
        content
            .font(params.font)
            .foregroundStyle(params.foregroundColor)
    }
}
