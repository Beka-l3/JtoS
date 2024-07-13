import Foundation

struct PrintAction: Decodable {
    static var realType = "PrintAction"
    let isBold: Bool
}

extension PrintAction: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(isBold)
    }
}
