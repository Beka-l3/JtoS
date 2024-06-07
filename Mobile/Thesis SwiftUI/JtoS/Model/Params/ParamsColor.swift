import SwiftUI

struct ParamsColor: JtoSParams {

    let colorHex: String

    // MARK: Init

    init(params: Params) {
        self.colorHex = params.colorHex ?? ""
    }
}
