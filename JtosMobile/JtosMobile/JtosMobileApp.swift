import SwiftUI

@main
struct JtosMobileApp: App {
    var body: some Scene {
        WindowGroup {
            let stateStore = StateStore()
            let actionDispatcher = ActionDispatcherFactory.createActionDispatcher(stateStore: stateStore)
            let query = ScreenQuery(path: "/api/screen/test", params: [:], body: [:])
            let viewModel = ScreenEngineViewModel(
                query: query,
                actionDispatcher: actionDispatcher,
                stateStore: stateStore
            )
            ScreenEngineView(viewModel: viewModel)
        }
    }
}
