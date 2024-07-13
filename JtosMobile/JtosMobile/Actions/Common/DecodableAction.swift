protocol AbstractAction {
    static var realType: String { get }
}

typealias DecodableAction = AbstractAction & Decodable
