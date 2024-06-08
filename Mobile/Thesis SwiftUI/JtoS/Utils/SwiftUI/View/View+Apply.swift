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
