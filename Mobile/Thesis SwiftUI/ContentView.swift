import SwiftUI

struct ContentView: View {

    // MARK: Internal Properties

    @State var jtos: JtoS = .empty

    // MARK: Body

    var body: some View {
        JtoSView(model: jtos)
            .onAppear {
                getJtoSModel()
            }
    }
}

extension ContentView {

    func getJtoSModel() {
        if let jtos = JtoSConverter.decodeMockJSON(for: .landing) {
            jtos.traverseModel()
            self.jtos = jtos
        } else {
            jtos = .empty
        }
    }
}

#Preview { ContentView(jtos: .empty) }
