import Foundation
import FirebaseFirestore

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

extension ClothingItem {
    static func fromDocument(_ document: QueryDocumentSnapshot) -> ClothingItem? {
        let data = document.data()
        guard
            let imageURLString = data["imageURL"] as? String,
            let imageURL = URL(string: imageURLString),
            let storagePath = data["storagePath"] as? String,
            let categoryRaw = data["category"] as? String,
            let category = Category(rawValue: categoryRaw),
            let createdAt = (data["createdAt"] as? Timestamp)?.dateValue()
        else {
            return nil
        }

        return ClothingItem(
            id: document.documentID,
            imageURL: imageURL,
            storagePath: storagePath,
            category: category,
            createdAt: createdAt
        )
    }
}
