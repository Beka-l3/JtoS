import SwiftUI

struct SectionView: View {

    // MARK: - Properties

    var section: Section
    let actionDispatcher: ActionDispatcher
    let stateStore: StateStore

    var body: some View {
        buildView(from: section)
    }
    
    // MARK: - Private
    
    @ViewBuilder
    private func buildView(from section: Section) -> some View {
        VStack(spacing: 0) {
            ForEach(section.views, id: \.self.id) { view in
                if let div = view.states.first?.div {
                    DivView(
                        div: div,
                        actionDispatcher: actionDispatcher,
                        stateStore: stateStore
                    )
                } else {
                    EmptyView()
                }
            }
        }
    }
}
