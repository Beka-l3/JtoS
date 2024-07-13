import Foundation

struct PatchAction: DecodableAction {
    static var realType = "PatchAction"
    let path: String
    let target: String
}

extension PatchAction: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(path)
    }
}
