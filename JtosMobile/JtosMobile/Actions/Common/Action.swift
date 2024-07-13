import Foundation


enum Action: Decodable {
    case printAction(PrintAction)
    case changeIntegerStateAction(ChangeIntegerStateAction)
    case listAction(ListAction)
    case patchAction(PatchAction)
    case changeBooleanStateAction(ChangeBooleanStateAction)
    
    private enum CodingKeys: String, CodingKey {
        case realType
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let realType = try container.decode(String.self, forKey: .realType)
        
        switch realType {
        case PrintAction.realType:
            let printAction = try PrintAction(from: decoder)
            self = .printAction(printAction)
        case ChangeIntegerStateAction.realType:
            let changeIntegerStateAction = try ChangeIntegerStateAction(from: decoder)
            self = .changeIntegerStateAction(changeIntegerStateAction)
        case ListAction.realType:
            let listAction = try ListAction(from: decoder)
            self = .listAction(listAction)
        case PatchAction.realType:
            let patchAction = try PatchAction(from: decoder)
            self = .patchAction(patchAction)
        case ChangeBooleanStateAction.realType:
            let changeBooleanStateAction = try ChangeBooleanStateAction(from: decoder)
            self = .changeBooleanStateAction(changeBooleanStateAction)
        default:
            fatalError("Action do not exist")
        }
    }
}

extension Action: Hashable {}

