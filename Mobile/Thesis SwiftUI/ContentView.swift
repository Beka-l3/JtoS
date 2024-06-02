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

    func foo() {
        if let jtos = JtoSConverter.decodeMockJSON(for: .catalog) {
            jtos.traverseModel()
        }
    }

    func getJtoSModel() {
        if let jtos = JtoSConverter.decodeMockJSON(for: .catalog) {
            jtos.traverseModel()
            self.jtos = jtos
        } else {
            jtos = .empty
        }
    }
}

#Preview { ContentView(jtos: .empty) }
