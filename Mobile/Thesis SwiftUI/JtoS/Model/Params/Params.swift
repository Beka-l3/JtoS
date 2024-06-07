import Foundation

struct Params: Decodable, Equatable, Hashable {

    // MARK: Nested Types

    struct CGFloatValueWrapper: Codable, Equatable, Hashable {
        var value: CGFloat

        enum CodingKeys: String, CodingKey {
            case value
        }

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

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            if value.isInfinite {
                try container.encode("Infinity", forKey: .value)
            } else {
                try container.encode(Double(value), forKey: .value)
            }
        }
    }

    // MARK: Internal Properties

    var ignoresSafeArea: Bool?              = nil

    var width: CGFloatValueWrapper?         = nil
    var maxWidth: CGFloatValueWrapper?      = nil
    var minWidth: CGFloatValueWrapper?      = nil

    var height: CGFloatValueWrapper?        = nil
    var maxHeight: CGFloatValueWrapper?     = nil
    var minHeight: CGFloatValueWrapper?     = nil

    var frameAlignment: String?             = nil

    var colorHex: String?                   = nil
    var cornerRadius: Double?               = nil

    var value: String?                      = nil
    var font: String?                       = nil
    var fontSize: Int?                      = nil

    var url: String?                        = nil
    var contentMode: String?                = nil

    var spacing: Int?                       = nil
    var alignment: String?                  = nil
    var axes: String?                       = nil
}
