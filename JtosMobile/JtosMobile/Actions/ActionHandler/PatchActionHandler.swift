import Foundation

class PatchActionHandler: AbstractActionHandler {
    
    weak var viewModel: ScreenEngineViewModel?
    weak var stateStore: StateStore?
    
    init(viewModel: ScreenEngineViewModel, stateStore: StateStore) {
        self.viewModel = viewModel
        self.stateStore = stateStore
    }

    func handle(action: Action) {
        guard let stateStore = stateStore else { return }
        switch action {
        case .patchAction(let patchAction):
            let query = ScreenQuery(
                path: "/api/state/\(patchAction.path)",
                params: [:],
                body: [
                    "target": patchAction.target,
                    "state": stateStore.store.mapValues { $0.toString }
                ]
            )
            viewModel?.fetchPatch(query: query, stateStore: stateStore)
        default:
            return
        }
    }
}
