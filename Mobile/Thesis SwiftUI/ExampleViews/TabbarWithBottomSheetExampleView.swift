import SwiftUI

struct TabbarWithBottomSheetExampleView: View {

    // MARK: Internal Properties

    @State private var index = 0

    private let forButtons = [
        (systemImage: "circle", hex: "4fd673"),
        (systemImage: "square", hex: "d667f5"),
        (systemImage: "triangle", hex: "eb3859"),
        (systemImage: "star", hex: "6bc4ed")
    ]

    // MARK: Body

    var body: some View {
        zStack()
    }
}

extension TabbarWithBottomSheetExampleView {

    @ViewBuilder
    private func zStack() -> some View {
        ZStack {

            SomeViewForSomeView(index: index, hex: forButtons[index].hex)

            VStack {
                Spacer()

                tabbar()
            }
        }
        .ignoresSafeArea()
    }

    @ViewBuilder
    private func tabbar() -> some View {
        ZStack {
            tabbarBgView()
            tabbarButtons()
        }
        .frame(maxWidth: .infinity, maxHeight: 80)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal, 16)
        .padding(.bottom, 24)
    }

    private func tabbarBgView() -> some View {
        Color.fromHex("aa000000")
            .background { Blur(radius: 4) }
    }

    private func tabbarButtons() -> some View {
        HStack {
            Spacer()

            ForEach(0..<forButtons.count) { i in
                tabbarButton(idx: i)

                Spacer()
            }
        }
    }

    private func tabbarButton(idx: Int) -> some View {
        let color = (index == idx) ? Color.fromHex(forButtons[idx].hex) : .gray

        return Button {
            index = idx
        } label: {
            Image(systemName: forButtons[idx].systemImage)
                .foregroundStyle(color)
                .shadow(color: color, radius: 12)
        }
        .frame(width: 60, height: 60)
    }
}


private struct SomeViewForSomeView: View {

    // MARK: Internal Properties

    let index: Int
    let hex: String

    @State var shouldShowBS: Bool = false

    // MARK: Body

    var body: some View {
        bgColor()

        if index == 1 {
            Button {
                shouldShowBS = true
            } label: {
                Text("Show BS")
                    .font(.system(size: 22))
                    .foregroundStyle(Color.white)
                    .frame(width: 180, height: 60)
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .sheet(isPresented: $shouldShowBS) {
                Text("Hello World")
            }
        }
    }

    // MARK: Private Methods

    @ViewBuilder
    private func getView(for idx: Int) -> some View {
        ZStack {
            bgColor()

        }
    }

    @ViewBuilder
    private func bgColor() -> some View {
        Color.black

        Color.fromHex(hex)
            .opacity(0.6)
            .background(Blur(radius: 4))
    }
}
