import Foundation

struct PrintAction: Decodable {
    static var realType = "PrintAction"
    let isBold: Bool
}
