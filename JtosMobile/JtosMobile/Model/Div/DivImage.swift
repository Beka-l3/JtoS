struct DivImage: Decodable {
    let imageUrl: String?
    let imageVariable: ImageVariable?
    let contentMode: DivContentMode
    let width: Size
    let height: Size
    let padding: DivEdgeInsets
    let action: ActionWrapper?
}
