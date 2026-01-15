import Foundation

enum Occasion: String, CaseIterable, Codable {
    case casual
    case work
    case formal
    case travel
    case fitness

    var displayName: String {
        switch self {
        case .casual:
            return "Casual"
        case .work:
            return "Work"
        case .formal:
            return "Formal"
        case .travel:
            return "Travel"
        case .fitness:
            return "Fitness"
        }
    }
}
