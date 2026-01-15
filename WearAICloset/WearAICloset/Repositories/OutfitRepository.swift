import Foundation

protocol OutfitRepository {
    func fetchFavoriteOutfits() -> [Outfit]
}

struct MockOutfitRepository: OutfitRepository {
    func fetchFavoriteOutfits() -> [Outfit] {
        let baseItem = ClothingItem(
            id: UUID().uuidString,
            imageURL: URL(string: "https://example.com/item5.jpg")!,
            storagePath: "users/mock/items/item5.jpg",
            category: .top,
            createdAt: Date().addingTimeInterval(-604800)
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
