import Foundation

enum Mood: String, CaseIterable, Codable, Identifiable {
    case happy
    case calm
    case confident
    case casual
    case lowkey

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .happy:
            return "Happy"
        case .calm:
            return "Calm"
        case .confident:
            return "Confident"
        case .casual:
            return "Casual"
        case .lowkey:
            return "Lowkey"
        }
    }
}
