import Foundation

protocol OutfitRepository {
    func fetchFavoriteOutfits() -> [Outfit]
}

struct MockOutfitRepository: OutfitRepository {
    func fetchFavoriteOutfits() -> [Outfit] {
        let baseItem = ClothingItem(
            name: "Cashmere Sweater",
            category: .tops,
            color: "Cream",
            season: "Winter",
            mood: .cozy,
            occasion: .casual
        )
        return [
            Outfit(
                name: "Weekend Warmth",
                items: [baseItem],
                occasion: .casual,
                mood: .cozy,
                isFavorite: true
            ),
            Outfit(
                name: "City Evening",
                items: [baseItem],
                occasion: .formal,
                mood: .bold,
                isFavorite: true
            )
        ]
    }
}
