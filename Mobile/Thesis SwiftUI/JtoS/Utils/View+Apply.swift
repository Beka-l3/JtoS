import SwiftUI

extension View {
    func apply<T: JtoSParams>(params: T) -> some View {

        switch params {

        case let textParams as ParamsText:
            return AnyView(self.modifier(ApplyTextParams(params: textParams)))

        case let imageParams as ParamsImage:
            return AnyView(self.modifier(ApplyImageParams(params: imageParams)))

        case let vStackParams as ParamsVStack:
            return AnyView(self.modifier(ApplyVStackParams(params: vStackParams)))

        case let hStackParams as ParamsHStack:
            return AnyView(self.modifier(ApplyHStackParams(params: hStackParams)))

        default:
            fatalError("Unsupported parameter type")
        }
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
            .frame(
                width: params.common.size.width,
                height: params.common.size.height
            )
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
