import SwiftUI

struct ParamsButton: JtoSParams {

    // MARK: Nested Types

    enum ActionType {

        case none
        case openBottomSheet(urlString: String)
        case openNewView(urlString: String)
        case goBack
        case update
    }

    // MARK: Internal Properties

    let textValue: String
    let actionType: ActionType

    // MARK: Init

    init(params: Params) {
        self.textValue = params.textValue ?? ""
        self.actionType = .none
    }
}
