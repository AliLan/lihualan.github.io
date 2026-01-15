import Foundation
import FirebaseFirestore
import FirebaseStorage

protocol DataCleanupService {
    func clearUserData(userId: String) async throws
}

struct FirestoreDataCleanupService: DataCleanupService {
    private var firestore: Firestore { Firestore.firestore() }
    private var storage: Storage { Storage.storage() }

    func clearUserData(userId: String) async throws {
        try await deleteItems(userId: userId)
        try await deleteOutfits(userId: userId)
    }

    private func deleteItems(userId: String) async throws {
        let itemsSnapshot = try await firestore
            .collection("users")
            .document(userId)
            .collection("items")
            .getDocuments()

        for document in itemsSnapshot.documents {
            let data = document.data()
            if let storagePath = data["storagePath"] as? String {
                let storageRef = storage.reference().child(storagePath)
                try await storageRef.deleteAsync()
            }
            try await document.reference.delete()
        }
    }

    private func deleteOutfits(userId: String) async throws {
        let outfitsSnapshot = try await firestore
            .collection("users")
            .document(userId)
            .collection("outfits")
            .getDocuments()

        for document in outfitsSnapshot.documents {
            try await document.reference.delete()
        }
    }
}
