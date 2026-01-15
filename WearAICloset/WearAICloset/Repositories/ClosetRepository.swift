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
                id: UUID().uuidString,
                imageURL: URL(string: "https://example.com/item1.jpg")!,
                storagePath: "users/mock/items/item1.jpg",
                category: .top,
                createdAt: Date()
            ),
            ClothingItem(
                id: UUID().uuidString,
                imageURL: URL(string: "https://example.com/item2.jpg")!,
                storagePath: "users/mock/items/item2.jpg",
                category: .bottom,
                createdAt: Date().addingTimeInterval(-86400)
            )
        ]
    }

    func fetchRecentItems() -> [ClothingItem] {
        [
            ClothingItem(
                id: UUID().uuidString,
                imageURL: URL(string: "https://example.com/item3.jpg")!,
                storagePath: "users/mock/items/item3.jpg",
                category: .outerwear,
                createdAt: Date().addingTimeInterval(-172800)
            ),
            ClothingItem(
                id: UUID().uuidString,
                imageURL: URL(string: "https://example.com/item4.jpg")!,
                storagePath: "users/mock/items/item4.jpg",
                category: .shoes,
                createdAt: Date().addingTimeInterval(-259200)
            )
        ]
    }

    func fetchCategories() -> [Category] {
        Category.allCases
    }
}
