import Foundation

enum Occasion: String, CaseIterable, Codable, Identifiable {
    case work
    case travel
    case date
    case casual
    case home

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .work:
            return "Work"
        case .travel:
            return "Travel"
        case .date:
            return "Date"
        case .casual:
            return "Casual"
        case .home:
            return "Home"
        }
    }
}
