import Foundation

struct Params: Decodable, Equatable, Hashable {

    // MARK: Nested Types

    struct Size: Decodable, Equatable, Hashable {

        let w: Int
        let h: Int
    }

    // MARK: Internal Properties

    // MARK: Common

    var ignoresSafeArea: Bool?      = nil

    var size: Size?                 = nil
    var colorHex: String?           = nil
    var cornerRadius: Double?       = nil

    var value: String?              = nil
    var font: String?               = nil
    var fontSize: Int?              = nil

    var url: String?                = nil
    var contentMode: String?        = nil

    var alignment: String?          = nil
    var spacing: Int?               = nil

    var axes: String?               = nil
}
