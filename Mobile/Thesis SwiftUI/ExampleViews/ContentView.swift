import SwiftUI

struct ContentView: View {

    var body: some View {
        JtoSRootView(resource: .mock(filename: "TabbarScreenMock"))
//        JtoSRootView(resource: .mock(filename: "Innopolis"))
    }
}

#Preview { ContentView() }
