import SwiftUI

// MARK: View Modifier

struct ApplyTabbarParams: ViewModifier {

    var params: ParamsTabbar

    func body(content: Content) -> some View {
        content
    }
}

// MARK: Tabbar

extension JtoSView {

    // MARK: Public Methods

    @ViewBuilder
    func tabbarNavigation(for element: Binding<JtoS>) -> some View {
        let tabbarParams = ParamsTabbar(params: element.wrappedValue.params)

        ZStack {
            rootViewForTabbar(tabbarParams)

            VStack {
                Spacer()

                tabbarView(element.wrappedValue.params, tabbarParams: tabbarParams)
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }

    // MARK: Private Methods

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
                    case let .url(urlString): JtoSRootView(resource: .url(string: urlString))
                    case let .mock(filename): JtoSRootView(resource: .mock(filename: filename))
                }
            }
        }
    }
}
