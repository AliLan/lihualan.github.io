import Foundation
import FirebaseFirestore

protocol OutfitsRepository {
    @discardableResult
    func observeOutfits(
        userId: String,
        onChange: @escaping ([Outfit]) -> Void,
        onError: @escaping (Error) -> Void
    ) -> ListenerRegistration

    func saveOutfit(userId: String, outfit: Outfit) async throws
    func deleteOutfit(userId: String, outfitId: String) async throws
}

struct FirestoreOutfitsRepository: OutfitsRepository {
    private var firestore: Firestore { Firestore.firestore() }

    @discardableResult
    func observeOutfits(
        userId: String,
        onChange: @escaping ([Outfit]) -> Void,
        onError: @escaping (Error) -> Void
    ) -> ListenerRegistration {
        firestore
            .collection("users")
            .document(userId)
            .collection("outfits")
            .order(by: "createdAt", descending: true)
            .addSnapshotListener { snapshot, error in
                if let error {
                    onError(error)
                    return
                }

                let outfits = snapshot?.documents.compactMap { Outfit.fromDocument($0) } ?? []
                onChange(outfits)
            }
    }

    func saveOutfit(userId: String, outfit: Outfit) async throws {
        let payload: [String: Any] = [
            "mood": outfit.mood.rawValue,
            "occasion": outfit.occasion.rawValue,
            "topId": outfit.topId,
            "bottomId": outfit.bottomId,
            "shoesId": outfit.shoesId,
            "outerId": outfit.outerId as Any,
            "createdAt": Timestamp(date: outfit.createdAt),
            "reason": outfit.reason as Any
        ]

        try await firestore
            .collection("users")
            .document(userId)
            .collection("outfits")
            .document(outfit.id)
            .setData(payload)
    }

    func deleteOutfit(userId: String, outfitId: String) async throws {
        try await firestore
            .collection("users")
            .document(userId)
            .collection("outfits")
            .document(outfitId)
            .delete()
    }
}
