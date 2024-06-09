import SwiftUI
import UIKit

struct ContentView: View {

    let imageUrl = "https://images.unsplash.com/photo-1615961439949-65582e3c843a?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"

    var body: some View {
        JtoSRootView(mock: .landing)

//        zStack()
    }
}

extension ContentView {

    @ViewBuilder
    private func zStack() -> some View {
        ZStack {
            asyncImage()

            vStack()
        }
        .frame(maxWidth: .infinity, maxHeight: 300)
        .padding(24)
    }

    @ViewBuilder
    private func asyncImage() -> some View {
        AsyncImage(url: URL(string: imageUrl)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else if phase.error != nil {
                Text("could not load image")
            } else {
                ProgressView()
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    @ViewBuilder
    private func vStack() -> some View {
        VStack {
            Spacer()

            hStack()
        }
    }

    @ViewBuilder
    private func hStack() -> some View {
        HStack {
            Text("Some Text")
                .font(.system(size: 24))
                .foregroundStyle(Color.white)
                .padding(16)

            Spacer()

            Button {
                print("\n\nhey\n\n")
            } label: {
                Text("Some Button")
                    .font(.system(size: 10).bold())
                    .foregroundStyle(Color.black)
                    .frame(width: 80, height: 30)
                    .background(Color.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(16)
            }

        }
    }
}

#Preview { ContentView() }
