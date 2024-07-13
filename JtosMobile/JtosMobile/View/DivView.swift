import SwiftUI

struct DivView: View {
    
    let div: Div
    let actionDispatcher: ActionDispatcher
    let stateStore: StateStore

    var body: some View {
        switch div.type {
        case .image(let divImage):
            DivImageView(divImage: divImage, actionDispatcher: actionDispatcher, stateStore: stateStore)
        case .container(let divContainer):
            DivContainerView(divContainer: divContainer, actionDispatcher: actionDispatcher, stateStore: stateStore)
        case .text(let divText):
            DivTextView(divText: divText, actionDispatcher: actionDispatcher, stateStore: stateStore)
        }
    }
}
