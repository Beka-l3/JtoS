import SwiftUI

@main
struct JtosMobileApp: App {
    var body: some Scene {
        WindowGroup {
            let actionDispatcher = ActionDispatcherFactory.createActionDispatcher()
            let query = ScreenQuery(path: "/api/screen/test", params: [:], body: [:])
            let viewModel = ScreenEngineViewModel(query: query, actionDispatcher: actionDispatcher)
            ScreenEngineView(viewModel: viewModel)
        }
    }
}
