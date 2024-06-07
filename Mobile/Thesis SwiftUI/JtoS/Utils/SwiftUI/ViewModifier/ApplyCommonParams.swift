import SwiftUI

struct ApplyCommonParams: ViewModifier {

    var params: ParamsCommon

    func body(content: Content) -> some View {
        content
            .applyFrame(params.frame)
            .applyIgnoreSafeArea(params.ignoresSafeArea)
            .applyCornerRadius(cornerRadius: params.cornerRadius)

    }
}

private extension View {

    @ViewBuilder
    func applyFrame(_ frameParams: ParamsCommon.ParamsFrame) -> some View {
        self
            .applyWidth(frameParams.width)
            .applyHeight(frameParams.height)
            .frame(alignment: frameParams.alignment)
    }

    @ViewBuilder
    func applyWidth(_ width: ParamsCommon.ParamsFrame.WidthParamType) -> some View {
        switch width {
        case let .width(value) : self.frame(width: value)
        case let .maxWidth(value): self.frame(maxWidth: value)
        case let .minWidth(value): self.frame(minWidth: value)
        default: self
        }
    }

    @ViewBuilder
    func applyHeight(_ height: ParamsCommon.ParamsFrame.HeightParamType) -> some View {
        switch height {
        case let .height(value) : self.frame(height: value)
        case let .maxHeight(value): self.frame(maxHeight: value)
        case let .minHeight(value): self.frame(minHeight: value)
        default: self
        }
    }

    @ViewBuilder
    func applyIgnoreSafeArea(_ shouldIgnore: Bool) -> some View {
        if shouldIgnore { self.ignoresSafeArea() } else { self }
    }

    @ViewBuilder
    func applyCornerRadius(cornerRadius: CGFloat) -> some View {
        if cornerRadius > 0 { self.clipShape(RoundedRectangle(cornerRadius: cornerRadius)) } else { self }
    }
}
