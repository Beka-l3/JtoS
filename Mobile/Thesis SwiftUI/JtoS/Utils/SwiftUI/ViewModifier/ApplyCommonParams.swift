import SwiftUI

struct ApplyCommonParams: ViewModifier {

    var params: ParamsCommon

    func body(content: Content) -> some View {
        content.frame(width: params.width, height: params.height)
            .applyIgnoreSafeArea(params.ignoresSafeArea)
            .applyCornerRadius(cornerRadius: params.cornerRadius)
    }
}

private extension View {

    @ViewBuilder
    func applyIgnoreSafeArea(_ shouldIgnore: Bool) -> some View {
        if shouldIgnore { self.ignoresSafeArea() } else { self }
    }

    @ViewBuilder
    func applyCornerRadius(cornerRadius: CGFloat) -> some View {
        if cornerRadius > 0 { self.clipShape(RoundedRectangle(cornerRadius: cornerRadius)) } else { self }
    }
}
