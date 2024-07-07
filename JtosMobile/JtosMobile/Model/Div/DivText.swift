import Foundation

struct DivText: Decodable {
    let text: String
    let width: Size
    let height: Size
    let padding: DivEdgeInsets
    let fontSize: Int
    let backgroundColor: ColorRGB
    let horizontalAlignment: DivHorizontalAlignment
}
