import SwiftUI

struct CounterExampleModelExampleView: View {

    var body: some View {
        ExampleRootView(mock: .filename, "ExampleCounterScreenMock")
    }
}











struct ExampleRootView: View {

    // MARK: Private Properties

    @State private var model: ExampleModel = .empty
    @State private var store: ExampleStore = .init(
        variables: [:]
    )

    private let url: String
    private let filename: String
    private let mockType: JtoSMockScreenType

    // MARK: Body

    var body: some View {
        ExampleView(model: $model)
            .environment(store)
            .onAppear {
                if mockType != .none {
                    getJtoSModelFromMock()

                    if mockType == .filename {
                        getJtoSModelFromMockFilename()
                    }
                } else {
                    getDataFromUrl()
                }
            }
    }

    // MARK: Init

    init(mock: JtoSMockScreenType, _ filename: String = "") {
        self.mockType = mock
        self.url = ""
        self.filename = filename
    }

    init(url: String) {
        self.mockType = .none
        self.filename = ""
        self.url = url
    }
}

extension ExampleRootView {

    private func getDataFromUrl() {
        model = .empty
    }

    private func getJtoSModelFromMock() {
        if let model = ExampleConverter.decodeMockJSON(for: mockType) {
            //            model.traverseModel()
            self.model = model
        } else {
            self.model = .empty
        }
    }

    private func getJtoSModelFromMockFilename() {
        if let model = ExampleConverter.decodeMockJSON(from: filename) {
            //            model.traverseModel()
            self.model = model
        } else {
            model = .empty
        }
    }
}


@Observable
private final class ExampleStore {

    // MARK: Nested Types

    enum UpdateAction {

        case set(value: Int)
        case add(value: Int)
        case sub(value: Int)
        case mult(value: Int)
        case div(value: Int)
    }

    // MARK: Private Properties

    private var variables: [String: Int]

    // MARK: Init

    init(variables: [String: Int] = [:]) {
        self.variables = variables
    }
}


private extension ExampleStore {

    // MARK: Get

    func get(for id: String) -> Int {
        variables[id] ?? 0
    }

    // MARK: Update

    func update(for id: String, action: UpdateAction) {
        switch action {
        case let .set(value): set(for: id, value: value)
        case let .add(value): set(for: id, value: get(for: id) + value)
        case let .sub(value): set(for: id, value: get(for: id) - value)
        case let .mult(value): set(for: id, value: get(for: id) * value)
        case let .div(value): set(for: id, value: get(for: id) * value)
        }
    }

    // MARK: Set

    func set(for id: String, value: Int) {
        variables[id] = value
    }
}





private struct ExampleModel: Decodable, Equatable, Hashable {

    // MARK: Type Properties

    static let empty: ExampleModel = .init(type: "", params: .init(), ui: [])

    // MARK: Nested Types

    enum ExampelType: String {

        case text, image, button, color
        case vStack, hStack, zStack
        case scrollView
        case spacer

        case unknown
    }

    // MARK: Internal Properties

    let type: String
    let params: Params
    var ui: [ExampleModel]

    var exampleType: ExampelType {
        ExampelType(rawValue: type) ??  .unknown
    }
}



private struct ExampleView: View {

    @Binding var model: ExampleModel
    @Environment(ExampleStore.self) private var store

    var body: some View {
        buildView(for: $model)
            .modifier(ApplyCommonParams(params: ParamsCommon(params: $model.wrappedValue.params)))
    }

    init(model: Binding<ExampleModel>) {
        self._model = model
    }
}

extension ExampleView {

    @ViewBuilder
    private func buildView(for element: Binding<ExampleModel>) -> some View {
        switch element.wrappedValue.exampleType {

        case .text: textView(for: element)
        case .image: imageView(for: element)
        case .color: colorView(for: element)
        case .vStack: vStackView(for: element)
        case .hStack: hStackView(for: element)
        case .zStack: zStackView(for: element)
        case .scrollView: scrollViewView(for: element)
        case .button: button(for: element)
        case .spacer: Spacer()

        default: empty
        }
    }
}

extension ExampleView {
    var empty: some View {
        ZStack {
            Color(.systemBackground).opacity(0.6)

            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                .scaleEffect(2.0, anchor: .center)
        }
    }
}

extension ExampleView {

    @ViewBuilder
    private func textView(for element: Binding<ExampleModel>) -> some View {
        let params = ParamsText(params: element.wrappedValue.params)

        if let varName = params.textFromVar {
            Text("\(store.get(for: varName))")
                .modifier(ApplyTextParams(params: params))
        } else {
            Text(params.textValue)
                .modifier(ApplyTextParams(params: params))
        }
    }

    @ViewBuilder
    private func imageView(for element: Binding<ExampleModel>) -> some View {
        let params = ParamsImage(params: element.wrappedValue.params)
        AsyncImage(url: URL(string: element.wrappedValue.params.url ?? "")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: params.contentMode)
            } else if phase.error != nil {
                ZStack {
                    Color(UIColor.systemBackground).opacity(0.3)
                    Text("Unable to load image")
                        .foregroundStyle(Color(UIColor.label))
                }
                .modifier(ApplyImageSkeletonParams(params: ParamsImageSkeleton(params: element.wrappedValue.params)))
            } else {
                empty
                    .modifier(ApplyImageSkeletonParams(params: ParamsImageSkeleton(params: element.wrappedValue.params)))
            }
        }
        .modifier(ApplyImageParams(params: params))
    }

    @ViewBuilder
    private func colorView(for element: Binding<ExampleModel>) -> some View {
        let params = ParamsColor(params: element.wrappedValue.params)
        Color.fromHex(params.colorHex)
            .modifier(ApplyColorParams(params: params))
    }

    @ViewBuilder
    private func vStackView(for element: Binding<ExampleModel>) -> some View {
        let params = ParamsVStack(params: element.wrappedValue.params)
        VStack(alignment: params.alignment, spacing: params.spacing) {
            if !element.ui.isEmpty {
                ForEach(element.ui, id: \.self) { uiChild in
                    ExampleView(model: uiChild)
                }
            }
        }
        .modifier(ApplyVStackParams(params: params))
    }

    @ViewBuilder
    private func hStackView(for element: Binding<ExampleModel>) -> some View {
        let params = ParamsHStack(params: element.wrappedValue.params)
        HStack(alignment: params.alignment, spacing: params.spacing) {
            if !element.ui.isEmpty {
                ForEach(element.ui, id: \.self) { uiChild in
                    ExampleView(model: uiChild)
                }
            }
        }
        .modifier(ApplyHStackParams(params: params))
    }

    @ViewBuilder
    private func zStackView(for element: Binding<ExampleModel>) -> some View {
        let params = ParamsZStack(params: element.wrappedValue.params)
        ZStack(alignment: params.alignment) {
            if !element.ui.isEmpty {
                ForEach(element.ui, id: \.self) { uiChild in
                    ExampleView(model: uiChild)
                }
            }
        }
        .modifier(ApplyZStackParams(params: params))
    }

    @ViewBuilder
    private func scrollViewView(for element: Binding<ExampleModel>) -> some View {
        let params = ParamsScrollView(params: element.wrappedValue.params)
        ScrollView(params.axes) {
            if !element.ui.isEmpty {
                ForEach(element.ui, id: \.self) { uiChild in
                    ExampleView(model: uiChild)
                }
            }
        }
        .modifier(ApplyScrollViewParams(params: params))
    }

    @ViewBuilder
    private func button(for element: Binding<ExampleModel>) -> some View {
        let buttonParams = ParamsButton(params: element.wrappedValue.params)
        let textParams = ParamsText(params: element.wrappedValue.params)

        Button {

            switch buttonParams.actionType {

            case .openBottomSheet(_):
                break

            case .openNewView(_):
                break

            case .goBack:
                break

            case .update:
                break

            case let .varAction(.set(varId, value)):
                store.update(for: varId, action: .set(value: value))

            case let .varAction(.add(varId, value)):
                store.update(for: varId, action: .add(value: value))

            case let .varAction(.sub(varId, value)):
                store.update(for: varId, action: .sub(value: value))

            case let .varAction(.mult(varId, value)):
                store.update(for: varId, action: .mult(value: value))

            case let .varAction(.div(varId, value)):
                store.update(for: varId, action: .div(value: value))

            default: break
            }

        } label: {
            Text(buttonParams.textValue)
                .modifier(ApplyTextParams(params: textParams))
        }
    }
}





private struct ExampleConverter { }

extension ExampleConverter {

    static func decodeMockJSON(for screenType: JtoSMockScreenType) -> ExampleModel? {
        let mockFileName = screenType.rawValue + Constants.mockFileSuffix
        return decodeMockJSON(from: mockFileName)
    }

    static func decodeMockJSON(from filename: String) -> ExampleModel? {
        if let url = Bundle.main.url(forResource: filename, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase

                let jsonData = try decoder.decode(ExampleModel.self, from: data)

                return jsonData
            } catch {
                print("error:\(error)")
            }
        }

        return nil
    }
}

extension ExampleConverter {

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

extension ExampleConverter {

    private enum Constants {

        static let mockFileSuffix = "ScreenMock"
    }
}
