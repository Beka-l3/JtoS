import SwiftUI

struct JtoSView: View {

    var model: JtoS

    var body: some View {
        buildView(for: model)
    }
}

extension JtoSView {

    @ViewBuilder
    private func buildView(for element: JtoS) -> some View {
        switch element.jToSType {

            case .text: textView(for: element)
            case .image: imageView(for: element)
            case .color: colorView(for: element)
            case .vStack: vStackView(for: element)
            case .hStack: hStackView(for: element)
            case .zStack: zStackView(for: element)

            default: empty
        }
    }

    @ViewBuilder
    private func textView(for element: JtoS) -> some View {
        let params = ParamsText(params: element.params)
        Text(params.value)
            .apply(params: params)
    }

    @ViewBuilder
    private func imageView(for element: JtoS) -> some View {
        let params = ParamsImage(params: element.params)
        AsyncImage(url: URL(string: element.params.url ?? "")) { result in
            result.image?
                .resizable()
                .aspectRatio(contentMode: params.contentMode)
        }
        .apply(params: params)
    }

    @ViewBuilder
    private func colorView(for element: JtoS) -> some View {
        let params = ParamsColor(params: element.params)
        Color.fromHex(params.colorHex)
            .apply(params: params)
    }

    @ViewBuilder
    private func vStackView(for element: JtoS) -> some View {
        let params = ParamsVStack(params: element.params)
        VStack(alignment: params.alignment, spacing: params.spacing) {
            if let ui = element.ui {
                ForEach(ui, id: \.self) { childElement in
                    JtoSView(model: childElement)
                }
            } else {
                empty
            }
        }
        .apply(params: params)
    }

    @ViewBuilder
    private func hStackView(for element: JtoS) -> some View {
        let params = ParamsHStack(params: element.params)
        HStack(alignment: params.alignment, spacing: params.spacing) {
            if let ui = element.ui {
                ForEach(ui, id: \.self) { childElement in
                    JtoSView(model: childElement)
                }
            } else {
                empty
            }
        }
        .apply(params: params)
    }

    @ViewBuilder
    private func zStackView(for element: JtoS) -> some View {
        let params = ParamsZStack(params: element.params)
        ZStack(alignment: params.alignment) {
            if let ui = element.ui {
                ForEach(ui, id: \.self) { childElement in
                    JtoSView(model: childElement)
                }
            } else {
                empty
            }
        }
        .apply(params: params)
    }
}

extension JtoSView {
    var empty: some View {
        Color(.clear)
    }
}
