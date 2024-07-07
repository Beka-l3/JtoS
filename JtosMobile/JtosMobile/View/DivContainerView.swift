import SwiftUI

struct DivContainerView: View {
    
    let divContainer: DivContainer
    
    var body: some View {
        buildContainerView(divContainer)
    }
    
    
    @ViewBuilder
    private func buildContainerView(_ containerData: DivContainer) -> some View {
        if containerData.orientation == .horizontal {
            HStack(alignment: .firstTextBaseline, spacing: 0) {
                ForEach(containerData.items, id: \.id) { item in
                    DivView(div: item)
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
            .padding(containerData.padding.toSwiftUI())
            .background(Color(uiColor: containerData.backgroundColor.toUIColor()))
            .clipShape(
                .rect(
                    topLeadingRadius: containerData.cornerRadius.topLeading,
                    bottomLeadingRadius: containerData.cornerRadius.bottomLeading,
                    bottomTrailingRadius: containerData.cornerRadius.bottomTrailing,
                    topTrailingRadius: containerData.cornerRadius.topTrailing
                )
            )
        } else {
            VStack(spacing: 0) {
                ForEach(containerData.items, id: \.id) { item in
                    DivView(div: item)
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
                alignment: containerData.verticalAlignment.toSwiftUI()
            )
            .padding(containerData.padding.toSwiftUI())
            .background(Color(uiColor: containerData.backgroundColor.toUIColor()))
            .clipShape(
                .rect(
                    topLeadingRadius: containerData.cornerRadius.topLeading,
                    bottomLeadingRadius: containerData.cornerRadius.bottomLeading,
                    bottomTrailingRadius: containerData.cornerRadius.bottomTrailing,
                    topTrailingRadius: containerData.cornerRadius.topTrailing
                )
            )
        }
    }
}
