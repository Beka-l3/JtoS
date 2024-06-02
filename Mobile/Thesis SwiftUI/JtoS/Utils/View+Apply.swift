import SwiftUI

extension View {
    func apply<T: JtoSParams>(params: T) -> some View {
        switch params {

        case let textParams as ParamsText:
            let view = AnyView(self.modifier(ApplyCommonParams(params: textParams.common)))
            return AnyView(view.modifier(ApplyTextParams(params: textParams)))

        case let imageParams as ParamsImage:
            let view = AnyView(self.modifier(ApplyCommonParams(params: imageParams.common)))
            return AnyView(view.modifier(ApplyImageParams(params: imageParams)))

        case let colorParams as ParamsColor:
            let view = AnyView(self.modifier(ApplyCommonParams(params: colorParams.common)))
            return AnyView(view.modifier(ApplyColorParams(params: colorParams)))

        case let vStackParams as ParamsVStack:
            let view = AnyView(self.modifier(ApplyCommonParams(params: vStackParams.common)))
            return AnyView(view.modifier(ApplyVStackParams(params: vStackParams)))

        case let hStackParams as ParamsHStack:
            let view = AnyView(self.modifier(ApplyCommonParams(params: hStackParams.common)))
            return AnyView(view.modifier(ApplyHStackParams(params: hStackParams)))

        case let zStackParams as ParamsZStack:
            let view = AnyView(self.modifier(ApplyCommonParams(params: zStackParams.common)))
            return AnyView(view.modifier(ApplyZStackParams(params: zStackParams)))

        default:
            fatalError("Unsupported parameter type")
        }
    }
}

struct ApplyCommonParams: ViewModifier {

    var params: ParamsCommon

    func body(content: Content) -> some View {
        content
            .frame(width: params.width, height: params.height)
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
