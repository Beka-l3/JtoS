import SwiftUI

struct ParamsImage: JtoSParams {

    let url: String
    let contentMode: ContentMode

    // MARK: Init

    init(params: Params) {
        self.url = params.value ?? ""
        self.contentMode = params.contentMode == "fill" ? .fill : .fit
    }
}
