import Foundation

struct JtoS: Decodable, Equatable, Hashable {

    // MARK: - Nested Types

    enum JtoSType: String {

        case text, image, button
        case vStack, hStack

        case unknown
    }

    // MARK: Internal Properties

    let type: String
    let params: Params
    var ui: [JtoS]?

    var jToSType: JtoSType {
        JtoSType(rawValue: type) ??  .unknown
    }
}


extension JtoS {

    // MARK: Type Properties

    static let empty: JtoS = .init(type: "", params: .init())
}