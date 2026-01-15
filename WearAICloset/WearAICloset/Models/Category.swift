import Foundation

enum Category: String, CaseIterable, Codable {
    case tops
    case bottoms
    case outerwear
    case dresses
    case footwear
    case accessories

    var displayName: String {
        switch self {
        case .tops:
            return "Tops"
        case .bottoms:
            return "Bottoms"
        case .outerwear:
            return "Outerwear"
        case .dresses:
            return "Dresses"
        case .footwear:
            return "Footwear"
        case .accessories:
            return "Accessories"
        }
    }
}
