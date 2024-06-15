import SwiftUI

struct JtoSView: View {

    @Binding var model: JtoS
    @EnvironmentObject var store: JtoSStore
    @State var navigationPath: NavigationPath = .init()

    var body: some View {
        buildView(for: $model)
            .wrapIntoConditional(
                state: .convertStateModel(rawState: $model.wrappedValue.params.state),
                store: store
            )
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
            case .button: button(for: element)
            case .tabbar: tabbarNavigation(for: element)
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

    // MARK: Text

    @ViewBuilder
    private func textView(for element: Binding<JtoS>) -> some View {
        let params = ParamsText(params: element.wrappedValue.params)
        
        if let varName = params.textFromVar {
            Text("\(store.get(for: varName))")
                .modifier(ApplyTextParams(params: params))
                .modifier(ApplyCommonParams(params: ParamsCommon(params: element.wrappedValue.params)))
        } else {
            Text(params.textValue)
                .modifier(ApplyTextParams(params: params))
                .modifier(ApplyCommonParams(params: ParamsCommon(params: element.wrappedValue.params)))
        }
    }

    // MARK: Image

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
        .modifier(ApplyCommonParams(params: ParamsCommon(params: element.wrappedValue.params)))
    }

    // MARK: Color

    @ViewBuilder
    private func colorView(for element: Binding<JtoS>) -> some View {
        let params = ParamsColor(params: element.wrappedValue.params)
        Color.fromHex(params.colorHex)
            .modifier(ApplyColorParams(params: params))
            .modifier(ApplyCommonParams(params: ParamsCommon(params: element.wrappedValue.params)))
    }

    // MARK: Stacks

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
        .modifier(ApplyCommonParams(params: ParamsCommon(params: element.wrappedValue.params)))
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
        .modifier(ApplyCommonParams(params: ParamsCommon(params: element.wrappedValue.params)))
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
        .modifier(ApplyCommonParams(params: ParamsCommon(params: element.wrappedValue.params)))
    }

    // MARK: ScrollView

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
        .modifier(ApplyCommonParams(params: ParamsCommon(params: element.wrappedValue.params)))
    }

    // MARK: Button

    @ViewBuilder
    private func button(for element: Binding<JtoS>) -> some View {
        let buttonParams = ParamsButton(params: element.wrappedValue.params)
        let textParams = ParamsText(params: element.wrappedValue.params)

        Button {
            switch buttonParams.actionType {

                case .openBottomSheet(_):
                    break

                case .openNewView(_):
                    break

                case .goBack:
                    break

                case .update:
                    break

                case let .varAction(.set(varId, value)):
                    store.update(for: varId, action: .set(value: value))

                case let .varAction(.add(varId, value)):
                    store.update(for: varId, action: .add(value: value))

                case let .varAction(.sub(varId, value)):
                    store.update(for: varId, action: .sub(value: value))

                case let .varAction(.mult(varId, value)):
                    store.update(for: varId, action: .mult(value: value))

                case let .varAction(.div(varId, value)):
                    store.update(for: varId, action: .div(value: value))

                default: break
            }

        } label: {
            Text(buttonParams.textValue)
                .modifier(ApplyTextParams(params: textParams))
        }
        .modifier(ApplyCommonParams(params: ParamsCommon(params: element.wrappedValue.params)))
    }

    // MARK: Tabbar

    @ViewBuilder
    private func tabbarNavigation(for element: Binding<JtoS>) -> some View {
        let tabbarParams = ParamsTabbar(params: element.wrappedValue.params)

        ZStack {
            rootViewForTabbar(tabbarParams)

            VStack {
                Spacer()
                
                tabbarView(element.wrappedValue.params, tabbarParams: tabbarParams)
            }
        }
        .ignoresSafeArea()
    }

    @ViewBuilder
    private func tabbarView(_ params: Params, tabbarParams: ParamsTabbar) -> some View {
        ZStack {
            Color.fromHex(params.colorHex ?? "")
                .background(Blur(radius: 3))

            HStack {
                Spacer()

                ForEach(tabbarParams.tabbars, id: \.tag) { tabbar in
                    tabbarButton(for: tabbarParams.tabbarVarId, tabbar)

                    Spacer()
                }
            }
        }
        .modifier(ApplyCommonParams(params: ParamsCommon(params: params)))
    }

    @ViewBuilder
    private func tabbarButton(for varId: String, _ params: ParamsTabbar.Tabbar) -> some View {
        let isSelected = store.get(for: varId) == params.tag
        let colors = (tint: params.tintColor, faded: Color.fromHex("88aaaaaa"))

        Button {
            store.update(for: varId, action: .set(value: params.tag))
        } label: {
            tabbarButtonLabel(params)
                .foregroundStyle(isSelected ? colors.tint : colors.faded)
                .shadow(
                    color: isSelected ? colors.tint : colors.faded,
                    radius: isSelected ? 10 : 0
                )
        }
    }

    @ViewBuilder
    private func tabbarButtonLabel(_ params: ParamsTabbar.Tabbar) -> some View {
        VStack {
            switch params.iconType {
                case let .systemImage(systemName): Image(systemName: systemName)
                case let .url(url): AsyncImage(url: url)
            }

            if !params.title.isEmpty {
                Text(params.title)
                    .font(.system(size: 12))
            }
        }
        .frame(width: 44, height: 44)
    }

    @ViewBuilder
    private func rootViewForTabbar(_ tabbarParams: ParamsTabbar) -> some View {
        ForEach(tabbarParams.tabbars, id: \.tag) { tabbar in
            if store.get(for: tabbarParams.tabbarVarId) == tabbar.tag {
                switch tabbar.rootSourceType {
                    case let .url(urlString): JtoSRootView(url: urlString)
                    case let .mock(filename): JtoSRootView(mock: .filename, filename)
                }
            }
        }
    }
}

private extension View {

    @ViewBuilder
    func wrapIntoConditional(state: JtoSState?, store: JtoSStore) -> some View {
        if let state {
            if let conditional = state.conditional {
                switch conditional.condition {
                    case let .equal(value):             if value == store.get(for: conditional.varId) { self }
                    case let .notEqual(value):          if value != store.get(for: conditional.varId) { self }
                    case let .greater(value):           if value > store.get(for: conditional.varId) { self }
                    case let .greaterOrEqual(value):    if value >= store.get(for: conditional.varId) { self }
                    case let .less(value):              if value < store.get(for: conditional.varId) { self }
                    case let .lessOrEqual(value):       if value <= store.get(for: conditional.varId) { self }

                    default: self
                }
            }
            
            /// for other types of State
            /// else if { }

            else { self }
        }

        else { self }
    }
}
