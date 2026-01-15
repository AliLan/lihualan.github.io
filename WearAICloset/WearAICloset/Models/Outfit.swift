import Foundation

struct Outfit: Identifiable, Codable {
    let id: UUID
    var name: String
    var items: [ClothingItem]
    var occasion: Occasion
    var mood: Mood
    var createdAt: Date
    var isFavorite: Bool
    var notes: String?

    init(
        id: UUID = UUID(),
        name: String,
        items: [ClothingItem],
        occasion: Occasion,
        mood: Mood,
        createdAt: Date = Date(),
        isFavorite: Bool = false,
        notes: String? = nil
    ) {
        self.id = id
        self.name = name
        self.items = items
        self.occasion = occasion
        self.mood = mood
        self.createdAt = createdAt
        self.isFavorite = isFavorite
        self.notes = notes
    }
}
