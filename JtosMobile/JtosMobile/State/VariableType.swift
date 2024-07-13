import Foundation

enum VariableType: Decodable {
    case integer(IntegerEnumValue)
    case boolean(BooleanEnumValue)
    
    private enum CodingKeys: String, CodingKey {
        case type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        
        switch type {
        case "Integer":
            let integerValue = try IntegerEnumValue(from: decoder)
            self = .integer(integerValue)
        case "Boolean":
            let booleanValue = try BooleanEnumValue(from: decoder)
            self = .boolean(booleanValue)
        default:
            throw DecodingError.dataCorruptedError(forKey: .type, in: container, debugDescription: "Invalid variable type")
        }
    }
}

struct IntegerEnumValue: Decodable {
    let defaultValue: Int
}

struct BooleanEnumValue: Decodable {
    let defaultValue: Bool
}
