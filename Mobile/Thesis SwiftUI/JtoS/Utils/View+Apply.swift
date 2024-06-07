import SwiftUI

extension View {
    func apply(type: JtoS.JtoSType, params: Params) -> some View {

        let commonParams = ParamsCommon(params: params)
        let view = AnyView(self.modifier(ApplyCommonParams(params: commonParams)))

        switch type {

        case .text:
            return AnyView(view.modifier(ApplyTextParams(params: ParamsText(params: params))))

        case .image:
            return AnyView(view.modifier(ApplyImageParams(params: ParamsImage(params: params))))

        case .button:
            return view

        case .color:
            return AnyView(view.modifier(ApplyColorParams(params: ParamsColor(params: params))))

        case .vStack:
            return AnyView(view.modifier(ApplyVStackParams(params: ParamsVStack(params: params))))

        case .hStack:
            return AnyView(view.modifier(ApplyHStackParams(params: ParamsHStack(params: params))))

        case .zStack:
            return AnyView(view.modifier(ApplyZStackParams(params: ParamsZStack(params: params))))

        case .scrollView:
            return AnyView(view.modifier(ApplyScrollViewParams(params: ParamsScrollView(params: params))))

        default:
            return view
        }
    }
}

struct ApplyCommonParams: ViewModifier {

    var params: ParamsCommon

    func body(content: Content) -> some View {
        applyCornerRadius(cornerRadius: params.cornerRadius) {
            applyIgnoreSafeArea(params.ignoresSafeArea) {
                content.frame(width: params.width, height: params.height)
            }
        }
    }

    // MARK: Private Methods

    @ViewBuilder
    private func applyIgnoreSafeArea(_ shouldIgnore: Bool, content: () -> some View) -> some View {
        if shouldIgnore { content().ignoresSafeArea() } else { content() }
    }

    @ViewBuilder
    private func applyCornerRadius(cornerRadius: CGFloat, content: () -> some View) -> some View {
        if cornerRadius > 0 { content().clipShape(RoundedRectangle(cornerRadius: cornerRadius)) } else { content() }
    }
}

struct ApplyTextParams: ViewModifier {

    var params: ParamsText

    func body(content: Content) -> some View {
        content
            .font(params.font)
            .foregroundStyle(params.foregroundColor)
    }
}

struct ApplyImageParams: ViewModifier {

    var params: ParamsImage

    func body(content: Content) -> some View {
        content
    }
}

struct ApplyColorParams: ViewModifier {

    var params: ParamsColor

    func body(content: Content) -> some View {
        content
    }
}

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

struct ApplyScrollViewParams: ViewModifier {

    var params: ParamsScrollView

    func body(content: Content) -> some View {
        content
    }
}
