import SwiftUI
import UIKit

struct ContentView: View {

    var body: some View {
//        JtoSRootView(mock: .landing)

//        ImageExampleView()

//        CounterExampleView()

//        CounterWithModelExampleView()

        JtoSRootView(mock: .tabbar)

//        ZStack {
//
//            VStack {
//                Spacer()
//
//                Color.fromHex("88000000")
//                    .frame(maxWidth: .infinity, maxHeight: 60)
//                    .clipShape(RoundedRectangle(cornerRadius: 16))
//                    .padding(.horizontal, 16)
//                    .padding(.bottom, 32)
//            }
//        }
//        .ignoresSafeArea(.all)
    }
}

#Preview { ContentView() }
