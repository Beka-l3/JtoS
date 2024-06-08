import SwiftUI
import UIKit

struct ContentView: View {

    // MARK: Internal Properties

    @State var jtos: JtoS = .empty
    let string = "https://images.unsplash.com/photo-1625926852782-3bef718476dc?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"

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
