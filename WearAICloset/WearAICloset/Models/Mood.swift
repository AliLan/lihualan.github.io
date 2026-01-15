import Foundation

enum Mood: String, CaseIterable, Codable {
    case calm
    case bold
    case cozy
    case energetic
    case romantic

    var displayName: String {
        switch self {
        case .calm:
            return "Calm"
        case .bold:
            return "Bold"
        case .cozy:
            return "Cozy"
        case .energetic:
            return "Energetic"
        case .romantic:
            return "Romantic"
        }
    }
}
