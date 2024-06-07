import SwiftUI


extension Color {
    /// Creates a SwiftUI color from a hexadecimal string.
    /// - Parameter hex: A hex color string. It can include # or not and can be 6 or 8 digits long (RRGGBB or RRGGBBAA).
    /// - Returns: A SwiftUI Color generated from the hex string.
    
    static func fromHex(_ hex: String) -> Color {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        
        let a, r, g, b: UInt64
        
        switch hex.count {
            
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            
        case 8: // RGBA (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            
        default:
            (a, r, g, b) = (255, 0, 0, 0) // Return black color if hex format is wrong
            
        }
        
        return Color(red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, opacity: Double(a) / 255)
    }
}

