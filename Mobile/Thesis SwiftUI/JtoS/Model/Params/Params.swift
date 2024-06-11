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

    // MARK: Internal Properties

    var ignoresSafeArea: Bool?                      = nil

    var width: CGFloatValueWrapper?                 = nil
    var maxWidth: CGFloatValueWrapper?              = nil
    var minWidth: CGFloatValueWrapper?              = nil
    var skeletonWidth: CGFloatValueWrapper?         = nil
    var skeletonMaxWidth: CGFloatValueWrapper?      = nil
    var skeletonMinWidth: CGFloatValueWrapper?      = nil

    var height: CGFloatValueWrapper?                = nil
    var maxHeight: CGFloatValueWrapper?             = nil
    var minHeight: CGFloatValueWrapper?             = nil
    var skeletonHeight: CGFloatValueWrapper?        = nil
    var skeletonMaxHeight: CGFloatValueWrapper?     = nil
    var skeletonMinHeight: CGFloatValueWrapper?     = nil

    var frameAlignment: String?                     = nil

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
}
