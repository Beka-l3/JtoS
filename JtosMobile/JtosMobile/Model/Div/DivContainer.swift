struct DivContainer: Decodable {
    let width: Size
    let height: Size
    let padding: DivEdgeInsets
    let items: Array<Div>
    let orientation: DivOrientation
    let cornerRadius: DivCornerRadius
    let backgroundColor: ColorRGB
    let horizontalAlignment: DivHorizontalAlignment
    let verticalAlignment: DivVerticalAlignment
}
