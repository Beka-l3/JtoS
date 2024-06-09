import SwiftUI

struct JtoSView: View {

    @Binding var model: JtoS

    var body: some View {
        buildView(for: $model)
            .modifier(ApplyCommonParams(params: ParamsCommon(params: $model.wrappedValue.params)))
    }
}

extension JtoSView {

    @ViewBuilder
    private func buildView(for element: Binding<JtoS>) -> some View {
        switch element.wrappedValue.jToSType {

        case .text: textView(for: element)
        case .image: imageView(for: element)
        case .color: colorView(for: element)
        case .vStack: vStackView(for: element)
        case .hStack: hStackView(for: element)
        case .zStack: zStackView(for: element)
        case .scrollView: scrollViewView(for: element)
        case .spacer: Spacer()

        default: empty
        }
    }
}

extension JtoSView {
    var empty: some View {
        ZStack {
            Color(.systemBackground).opacity(0.6)

            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                .scaleEffect(2.0, anchor: .center)
        }
    }
}

extension JtoSView {

    @ViewBuilder
    private func textView(for element: Binding<JtoS>) -> some View {
        let params = ParamsText(params: element.wrappedValue.params)
        Text(params.textValue)
            .modifier(ApplyTextParams(params: params))
    }

    @ViewBuilder
    private func imageView(for element: Binding<JtoS>) -> some View {
        let params = ParamsImage(params: element.wrappedValue.params)
        AsyncImage(url: URL(string: element.wrappedValue.params.url ?? "")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: params.contentMode)
            } else if phase.error != nil {
                ZStack {
                    Color(UIColor.systemBackground).opacity(0.3)
                    Text("Unable to load image")
                        .foregroundStyle(Color(UIColor.label))
                }
                .modifier(ApplyImageSkeletonParams(params: ParamsImageSkeleton(params: element.wrappedValue.params)))
            } else {
                empty
                    .modifier(ApplyImageSkeletonParams(params: ParamsImageSkeleton(params: element.wrappedValue.params)))
            }
        }
        .modifier(ApplyImageParams(params: params))
    }

    @ViewBuilder
    private func colorView(for element: Binding<JtoS>) -> some View {
        let params = ParamsColor(params: element.wrappedValue.params)
        Color.fromHex(params.colorHex)
            .modifier(ApplyColorParams(params: params))
    }

    @ViewBuilder
    private func vStackView(for element: Binding<JtoS>) -> some View {
        let params = ParamsVStack(params: element.wrappedValue.params)
        VStack(alignment: params.alignment, spacing: params.spacing) {
            if !element.ui.isEmpty {
                ForEach(element.ui, id: \.self) { uiChild in
                    JtoSView(model: uiChild)
                }
            }
        }
        .modifier(ApplyVStackParams(params: params))
    }

    @ViewBuilder
    private func hStackView(for element: Binding<JtoS>) -> some View {
        let params = ParamsHStack(params: element.wrappedValue.params)
        HStack(alignment: params.alignment, spacing: params.spacing) {
            if !element.ui.isEmpty {
                ForEach(element.ui, id: \.self) { uiChild in
                    JtoSView(model: uiChild)
                }
            }
        }
        .modifier(ApplyHStackParams(params: params))
    }

    @ViewBuilder
    private func zStackView(for element: Binding<JtoS>) -> some View {
        let params = ParamsZStack(params: element.wrappedValue.params)
        ZStack(alignment: params.alignment) {
            if !element.ui.isEmpty {
                ForEach(element.ui, id: \.self) { uiChild in
                    JtoSView(model: uiChild)
                }
            }
        }
        .modifier(ApplyZStackParams(params: params))
    }

    @ViewBuilder
    private func scrollViewView(for element: Binding<JtoS>) -> some View {
        let params = ParamsScrollView(params: element.wrappedValue.params)
        ScrollView(params.axes) {
            if !element.ui.isEmpty {
                ForEach(element.ui, id: \.self) { uiChild in
                    JtoSView(model: uiChild)
                }
            }
        }
        .modifier(ApplyScrollViewParams(params: params))
    }

    @ViewBuilder
    private func button(for element: Binding<JtoS>) -> some View {
        let params = ParamsButton(params: element.wrappedValue.params)
        Button(params.textValue) {
            switch params.actionType {
            case .none:
                break

            case .openBottomSheet(_):
                break

            case .openNewView(_):
                break

            case .goBack:
                break

            case .update:
                break

            }
        }
    }
}

