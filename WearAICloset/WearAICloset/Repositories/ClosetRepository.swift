import Foundation

protocol ClosetRepository {
    func fetchHighlights() -> [ClothingItem]
    func fetchRecentItems() -> [ClothingItem]
    func fetchCategories() -> [Category]
}

struct MockClosetRepository: ClosetRepository {
    func fetchHighlights() -> [ClothingItem] {
        [
            ClothingItem(
                name: "Linen Button-Up",
                category: .tops,
                color: "Sand",
                season: "Spring",
                mood: .calm,
                occasion: .work
            ),
            ClothingItem(
                name: "Wide-Leg Trousers",
                category: .bottoms,
                color: "Navy",
                season: "All Season",
                mood: .bold,
                occasion: .work
            )
        ]
    }

    func fetchRecentItems() -> [ClothingItem] {
        [
            ClothingItem(
                name: "Wrap Dress",
                category: .dresses,
                color: "Emerald",
                season: "Summer",
                mood: .romantic,
                occasion: .formal
            ),
            ClothingItem(
                name: "Trail Sneakers",
                category: .footwear,
                color: "White",
                season: "All Season",
                mood: .energetic,
                occasion: .fitness
            )
        ]
    }

    func fetchCategories() -> [Category] {
        Category.allCases
    }
}
