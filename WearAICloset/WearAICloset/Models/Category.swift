import Foundation

enum Category: String, CaseIterable, Codable, Identifiable {
    case top
    case bottom
    case outerwear
    case shoes

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .top:
            return "Top"
        case .bottom:
            return "Bottom"
        case .outerwear:
            return "Outerwear"
        case .shoes:
            return "Shoes"
        }
    }
}
