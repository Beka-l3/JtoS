import SwiftUI

struct JtoSRootView: View {

    // MARK: Private Properties

    @State private var jtos: JtoS = .empty
    @State private var store: JtoSStore = .init()

    private let url: String
    private let mockType: JtoSMockScreenType
    private let mockFilename: String

    // MARK: Body

    var body: some View {
        JtoSView(model: $jtos)
            .environment(store)
            .onAppear {
                if mockType != .none {
                    getJtoSModelFromMock()
                } else {
                    getDataFromUrl()
                }
        }
    }

    // MARK: Init

    init(mock: JtoSMockScreenType, _ filename: String = "") {
        self.mockType = mock
        self.url = ""
        self.mockFilename = filename
    }

    init(url: String) {
        self.mockType = .none
        self.url = url
        self.mockFilename = ""
    }
}

extension JtoSRootView {

    private func getDataFromUrl() {
        jtos = .empty
    }

    private func getJtoSModelFromMock() {
        let model = if mockType == .filename {
            JtoSConverter.decodeMockJSON(from: mockFilename)
        } else {
            JtoSConverter.decodeMockJSON(for: mockType)
        }

        if let model = model {
            model.traverseModel()
            jtos = model
        } else {
            jtos = .empty
        }
    }
}
