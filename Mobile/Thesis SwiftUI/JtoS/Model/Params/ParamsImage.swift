import SwiftUI

struct ParamsImage {

    let url: String
    let contentMode: ContentMode

    // MARK: Init

    init(params: Params) {
        self.url = params.url ?? ""
        self.contentMode = params.contentMode == "fill" ? .fill : .fit
    }
}
