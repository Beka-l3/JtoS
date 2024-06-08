import SwiftUI

struct JtoSRootView: View {

    // MARK: Private Properties

    @State private var jtos: JtoS = .empty

    private let url: String
    private let mockType: JtoSMockScreenType

    // MARK: Body

    var body: some View {
        JtoSView(model: $jtos).onAppear {
            if mockType != .none {
                getJtoSModelFromMock()
            } else {
                getDataFromUrl()
            }
        }
    }

    // MARK: Init

    init(mock: JtoSMockScreenType) {
        self.mockType = mock
        self.url = ""
    }

    init(url: String) {
        self.mockType = .none
        self.url = url
    }
}

extension JtoSRootView {

    private func getDataFromUrl() {
        jtos = .empty
    }

    private func getJtoSModelFromMock() {
        if let model = JtoSConverter.decodeMockJSON(for: mockType) {
            model.traverseModel()

            jtos = model

            jtos.traverseModel()
        } else {
            jtos = .empty
        }
    }
}
