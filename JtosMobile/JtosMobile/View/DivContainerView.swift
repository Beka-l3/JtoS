import SwiftUI

struct DivContainerView: View {
    
    let divContainer: DivContainer
    let actionDispatcher: ActionDispatcher
    let stateStore: StateStore

    var body: some View {
        buildContainerView(divContainer)
    }
    
    
    @ViewBuilder
    private func buildContainerView(_ containerData: DivContainer) -> some View {
        if containerData.orientation == .horizontal {
            HStack(alignment: containerData.verticalAlignment.toSwiftUIVertical(), spacing: 0) {
                ForEach(containerData.items, id: \.id) { item in
                    DivView(div: item, actionDispatcher: actionDispatcher, stateStore: stateStore)
                }
            }
            .frame(
                width: containerData.width.getSize(),
                height: containerData.height.getSize(),
                alignment: containerData.horizontalAlignment.toSwiftUI()
            )
            .frame(
                maxWidth: containerData.width.getMaxSize(),
                maxHeight: containerData.height.getMaxSize(),
                alignment: containerData.horizontalAlignment.toSwiftUI()
            )
            .setPaddings(containerData.padding.toSwiftUI())
            .background(Color(uiColor: containerData.backgroundColor.toUIColor()))
            .addCorners(
                topLeadingRadius: containerData.cornerRadius.topLeading,
                bottomLeadingRadius: containerData.cornerRadius.bottomLeading,
                bottomTrailingRadius: containerData.cornerRadius.bottomTrailing,
                topTrailingRadius: containerData.cornerRadius.topTrailing
            )
        } else {
            VStack(alignment: containerData.horizontalAlignment.toSwiftUI(), spacing: 0) {
                ForEach(containerData.items, id: \.id) { item in
                    DivView(div: item, actionDispatcher: actionDispatcher, stateStore: stateStore)
                }
            }
            .frame(
                width: containerData.width.getSize(),
                height: containerData.height.getSize(),
                alignment: containerData.verticalAlignment.toSwiftUI()
            )
            .frame(
                maxWidth: containerData.width.getMaxSize(),
                maxHeight: containerData.height.getMaxSize(),
                alignment: containerData.horizontalAlignment.toSwiftUI()
            )
            .setPaddings(containerData.padding.toSwiftUI())
            .background(Color(uiColor: containerData.backgroundColor.toUIColor()))
            .addCorners(
                topLeadingRadius: containerData.cornerRadius.topLeading,
                bottomLeadingRadius: containerData.cornerRadius.bottomLeading,
                bottomTrailingRadius: containerData.cornerRadius.bottomTrailing,
                topTrailingRadius: containerData.cornerRadius.topTrailing
            )
        }
    }
}

extension View {
    @ViewBuilder
    func addCorners(
        topLeadingRadius: CGFloat,
        bottomLeadingRadius: CGFloat,
        bottomTrailingRadius: CGFloat,
        topTrailingRadius: CGFloat
    ) -> some View {
        if topLeadingRadius == 0.0 && bottomLeadingRadius == 0.0 && bottomTrailingRadius == 0.0 && topTrailingRadius == 0.0 {
            self
        } else if 
            topLeadingRadius == bottomLeadingRadius &&
            topLeadingRadius == bottomTrailingRadius &&
            topLeadingRadius == topTrailingRadius
        {
            self.cornerRadius(topLeadingRadius)
        } else {
            self
            .clipShape(
                .rect(
                    topLeadingRadius: topLeadingRadius,
                    bottomLeadingRadius: bottomLeadingRadius,
                    bottomTrailingRadius: bottomTrailingRadius,
                    topTrailingRadius: topTrailingRadius
                )
            )
        }
    }
    
    @ViewBuilder
    func setPaddings(
        _ edgeInsets: EdgeInsets
    ) -> some View {
        if edgeInsets.leading == 0.0 && edgeInsets.trailing == 0.0 && edgeInsets.bottom == 0.0 && edgeInsets.top == 0.0 {
            self
        } else {
            self.padding(edgeInsets)
        }
    }
}
