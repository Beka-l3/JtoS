import Foundation

struct ImageVariable: Decodable {
    let name: String
    let type: VariableType
    let falseState: String
    let trueState: String
}
