import Foundation

struct ClothingItem: Identifiable, Codable {
    let id: UUID
    var name: String
    var category: Category
    var color: String
    var season: String
    var imageName: String?
    var mood: Mood
    var occasion: Occasion
    var isFavorite: Bool
    var lastWorn: Date?
    var notes: String?

    init(
        id: UUID = UUID(),
        name: String,
        category: Category,
        color: String,
        season: String,
        imageName: String? = nil,
        mood: Mood,
        occasion: Occasion,
        isFavorite: Bool = false,
        lastWorn: Date? = nil,
        notes: String? = nil
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.color = color
        self.season = season
        self.imageName = imageName
        self.mood = mood
        self.occasion = occasion
        self.isFavorite = isFavorite
        self.lastWorn = lastWorn
        self.notes = notes
    }
}
