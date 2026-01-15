import Foundation

struct ClothingItem: Identifiable, Codable {
    let id: String
    var imageURL: URL
    var storagePath: String
    var category: Category
    var createdAt: Date

    init(
        id: String,
        imageURL: URL,
        storagePath: String,
        category: Category,
        createdAt: Date
    ) {
        self.id = id
        self.imageURL = imageURL
        self.storagePath = storagePath
        self.category = category
        self.createdAt = createdAt
    }
}
