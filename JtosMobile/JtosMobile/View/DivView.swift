import SwiftUI

struct DivView: View {
    
    let div: Div
    let actionDispatcher: ActionDispatcher

    var body: some View {
        switch div.type {
        case .image(let divImage):
            DivImageView(divImage: divImage, actionDispatcher: actionDispatcher)
        case .container(let divContainer):
            DivContainerView(divContainer: divContainer, actionDispatcher: actionDispatcher)
        case .text(let divText):
            DivTextView(divText: divText, actionDispatcher: actionDispatcher)
        }
    }
}
