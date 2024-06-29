import SwiftUI

struct ParamsColor {

    let colorHex: String

    // MARK: Init

    init(params: Params) {
        self.colorHex = params.colorHex ?? ""
    }
}
