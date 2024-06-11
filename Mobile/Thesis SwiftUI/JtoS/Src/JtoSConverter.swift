import SwiftUI

struct JtoSConverter { }

extension JtoSConverter {

    static func decodeMockJSON(for screenType: JtoSMockScreenType) -> JtoS? {
        let mockFileName = screenType.rawValue + Constants.mockFileSuffix
        return decodeMockJSON(from: mockFileName)
    }

    static func decodeMockJSON(from filename: String) -> JtoS? {
        if let url = Bundle.main.url(forResource: filename, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase

                let jsonData = try decoder.decode(JtoS.self, from: data)

                return jsonData
            } catch {
                print("error:\(error)")
            }
        }

        return nil
    }
}

extension JtoSConverter {

    static var empty: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

extension JtoSConverter {

    private enum Constants {

        static let mockFileSuffix = "ScreenMock"
    }
}
