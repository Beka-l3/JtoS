import Foundation

struct Params: Decodable, Equatable, Hashable {

    // MARK: Nested Types

    struct CGFloatValueWrapper: Decodable, Equatable, Hashable {

        // MARK: Nested Types
        
        enum CodingKeys: String, CodingKey {
            case value
        }

        // MARK: Internal Properties

        var value: CGFloat

        // MARK: Init

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            if let doubleValue = try? container.decode(Double.self, forKey: .value) {
                value = CGFloat(doubleValue)
            } else if let stringValue = try? container.decode(String.self, forKey: .value), stringValue == "Infinity" {
                value = .infinity
            } else {
                throw DecodingError.dataCorruptedError(forKey: .value, in: container, debugDescription: "Value cannot be decoded")
            }
        }
    }

    struct Padding: Decodable, Equatable, Hashable {

        let edges: [String]
        let length: CGFloat
    }

    struct ButtonAction: Decodable, Equatable, Hashable {

        // MARK: Nested Types

        struct VarAction: Decodable, Equatable, Hashable {

            var action: String
            var varId: String
            var value: Int
        }

        // MARK: Internal Properties

        var varAction: VarAction?
    }

    struct FrameSize: Decodable, Equatable, Hashable {
        var width: CGFloatValueWrapper?             = nil
        var maxWidth: CGFloatValueWrapper?          = nil
        var minWidth: CGFloatValueWrapper?          = nil

        var height: CGFloatValueWrapper?            = nil
        var maxHeight: CGFloatValueWrapper?         = nil
        var minHeight: CGFloatValueWrapper?         = nil

        var alignment: String?                      = nil
    }

    struct State: Decodable, Equatable, Hashable {

        var conditional: String?
        var valueForConditional: Int?

        var varId: String?
    }

    struct Tabbar: Decodable, Equatable, Hashable {

        let systemImage: String?
        let imageUrl: String?
    }

    // MARK: Internal Properties

    var ignoresSafeArea: Bool?                      = nil

    var frame: FrameSize?                           = nil
    var skeletonFrame: FrameSize?                   = nil

    var padding: Padding?                           = nil
    var padding2: Padding?                          = nil

    var bgColorHex: String?                         = nil
    var colorHex: String?                           = nil
    var cornerRadius: Double?                       = nil

    var textValue: String?                          = nil
    var font: String?                               = nil
    var fontSize: Int?                              = nil

    var url: String?                                = nil
    var contentMode: String?                        = nil

    var spacing: Int?                               = nil
    var alignment: String?                          = nil
    var axes: String?                               = nil

    var textFromVar: String?                        = nil

    var buttonAction: ButtonAction?                 = nil

    var state: State?                               = nil

    var tabbars: [Tabbar]?                          = nil
}
