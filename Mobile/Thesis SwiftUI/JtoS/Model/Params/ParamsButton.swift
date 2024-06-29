import SwiftUI

struct ParamsButton {

    // MARK: Internal Properties

    let textValue: String

    // MARK: Init

    init(params: Params) {
        self.textValue = params.textValue ?? ""
    }
}
