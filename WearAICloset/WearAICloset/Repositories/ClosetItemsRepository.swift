import Foundation
import FirebaseFirestore
import FirebaseStorage

protocol ClosetItemsRepository {
    @discardableResult
    func observeItems(
        userId: String,
        onChange: @escaping ([ClothingItem]) -> Void,
        onError: @escaping (Error) -> Void
    ) -> ListenerRegistration

    func addItem(userId: String, itemId: String, imageData: Data, category: Category) async throws
    func deleteItem(userId: String, item: ClothingItem) async throws
}

struct FirestoreClosetItemsRepository: ClosetItemsRepository {
    private var firestore: Firestore { Firestore.firestore() }
    private var storage: Storage { Storage.storage() }

    @discardableResult
    func observeItems(
        userId: String,
        onChange: @escaping ([ClothingItem]) -> Void,
        onError: @escaping (Error) -> Void
    ) -> ListenerRegistration {
        firestore
            .collection("users")
            .document(userId)
            .collection("items")
            .order(by: "createdAt", descending: true)
            .addSnapshotListener { snapshot, error in
                if let error {
                    onError(error)
                    return
                }

                let items = snapshot?.documents.compactMap { document -> ClothingItem? in
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
                } ?? []

                onChange(items)
            }
    }

    func addItem(userId: String, itemId: String, imageData: Data, category: Category) async throws {
        let storagePath = "users/\(userId)/items/\(itemId).jpg"
        let storageRef = storage.reference().child(storagePath)
        _ = try await storageRef.putDataAsync(imageData)
        let downloadURL = try await storageRef.downloadURL()

        let payload: [String: Any] = [
            "imageURL": downloadURL.absoluteString,
            "storagePath": storagePath,
            "category": category.rawValue,
            "createdAt": Timestamp(date: Date())
        ]

        try await firestore
            .collection("users")
            .document(userId)
            .collection("items")
            .document(itemId)
            .setData(payload)
    }

    func deleteItem(userId: String, item: ClothingItem) async throws {
        let storageRef = storage.reference().child(item.storagePath)
        try await storageRef.deleteAsync()

        try await firestore
            .collection("users")
            .document(userId)
            .collection("items")
            .document(item.id)
            .delete()
    }
}
