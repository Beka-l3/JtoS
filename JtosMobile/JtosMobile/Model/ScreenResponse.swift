import Foundation

struct ScreenResponse: Decodable, Equatable, Hashable {
    
    // MARK: - Properties
    
    var ui: Array<Section>
    
    mutating func update(with newScreenResponse: ScreenResponse?) {
        guard let newScreenResponse = newScreenResponse else { return }
    }
}
