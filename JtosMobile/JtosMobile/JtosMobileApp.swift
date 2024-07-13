import SwiftUI

@main
struct JtosMobileApp: App {
    var body: some Scene {
        WindowGroup {
            let stateStore = StateStore()
            let actionDispatcher = ActionDispatcherFactory.createActionDispatcher()
            let query = ScreenQuery(path: "/api/screen/test", params: [:], body: [:])
            let viewModel = ScreenEngineViewModel(
                query: query,
                actionDispatcher: actionDispatcher,
                stateStore: stateStore
            )
            let _ = ActionDispatcherFactory.updateActionHandlers(
                actionDispatcher: actionDispatcher,
                stateStore: stateStore,
                viewModel: viewModel
            )
            ScreenEngineView(viewModel: viewModel)
        }
    }
}
