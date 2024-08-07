import SwiftUI

extension JtoSView {

    @ViewBuilder
    func container(for element: Binding<JtoS>) -> some View {
        ZStack {
            Color.clear.opacity(0)

            if !element.ui.isEmpty {
                ForEach(element.ui, id: \.self) { uiChild in
                    JtoSView(model: uiChild)
                }
            }
        }
        .modifier(ApplyCommonParams(params: ParamsCommon(params: element.wrappedValue.params)))
    }
}

// MARK: View Modifier : Common

struct ApplyCommonParams: ViewModifier {

    var params: ParamsCommon

    func body(content: Content) -> some View {
        content
            .applyFrame(params.frame)
            .applyBgColor(params.bgColorHex)
            .applyCornerRadius(cornerRadius: params.cornerRadius)
            .applyPadding(params.padding)
            .applyPadding(params.padding2)
            .applyIgnoreSafeArea(params.ignoresSafeArea)
            .applyBlur(radius: params.blurRadius)
    }
}

private extension View {

    @ViewBuilder
    func applyBgColor(_ colorHex: String?) -> some View {
        if let colorHex { self.background(Color.fromHex(colorHex)) } 
        else { self }
    }

    @ViewBuilder
    func applyFrame(_ frameParams: ParamsCommon.Frame) -> some View {
        switch (frameParams.width, frameParams.height) {

            case let (.width(w), .height(h)): self.frame(width: w, height: h, alignment: frameParams.alignment)
            case let (.width(w), .none): self.frame(width: w, alignment: frameParams.alignment)
            case let (.none, .height(h)): self.frame(height: h, alignment: frameParams.alignment)

            case let (.maxWidth(w), .none): self.frame(maxWidth: w, alignment: frameParams.alignment)
            case let (.maxWidth(w), .maxHeight(h)): self.frame(maxWidth: w, maxHeight: h, alignment: frameParams.alignment)
            case let (.maxWidth(w), .minHeight(h)): self.frame(maxWidth: w, minHeight: h, alignment: frameParams.alignment)

            case let (.minWidth(w), .none): self.frame(minWidth: w, alignment: frameParams.alignment)
            case let (.minWidth(w), .maxHeight(h)): self.frame(minWidth: w, maxHeight: h, alignment: frameParams.alignment)
            case let (.minWidth(w), .minHeight(h)): self.frame(minWidth: w, minHeight: h, alignment: frameParams.alignment)

            case let (.none, .maxHeight(h)): self.frame(maxHeight: h, alignment: frameParams.alignment)
            case let (.none, .minHeight(h)): self.frame(minHeight: h, alignment: frameParams.alignment)

            default: self.frame(alignment: frameParams.alignment)
        }
    }

    @ViewBuilder
    func applyPadding(_ padding: ParamsCommon.Padding) -> some View {
        switch padding.edge {
            case let .set(edgeSet): self.padding(edgeSet, padding.length)
            case .none: self
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

    @ViewBuilder
    func applyBlur(radius: CGFloat) -> some View {
        if radius != 0 { self.background(Blur(radius: radius)) }
        else { self }
    }
}
