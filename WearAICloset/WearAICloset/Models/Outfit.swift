import Foundation
import FirebaseFirestore

struct Outfit: Identifiable, Codable {
    let id: String
    var mood: Mood
    var occasion: Occasion
    var topId: String
    var bottomId: String
    var shoesId: String
    var outerId: String?
    var createdAt: Date
    var reason: String?

    init(
        id: String,
        mood: Mood,
        occasion: Occasion,
        topId: String,
        bottomId: String,
        shoesId: String,
        outerId: String?,
        createdAt: Date,
        reason: String?
    ) {
        self.id = id
        self.mood = mood
        self.occasion = occasion
        self.topId = topId
        self.bottomId = bottomId
        self.shoesId = shoesId
        self.outerId = outerId
        self.createdAt = createdAt
        self.reason = reason
    }
}

extension Outfit {
    static func fromDocument(_ document: QueryDocumentSnapshot) -> Outfit? {
        let data = document.data()
        guard
            let moodRaw = data["mood"] as? String,
            let mood = Mood(rawValue: moodRaw),
            let occasionRaw = data["occasion"] as? String,
            let occasion = Occasion(rawValue: occasionRaw),
            let topId = data["topId"] as? String,
            let bottomId = data["bottomId"] as? String,
            let shoesId = data["shoesId"] as? String,
            let createdAt = (data["createdAt"] as? Timestamp)?.dateValue()
        else {
            return nil
        }

        let outerId = data["outerId"] as? String
        let reason = data["reason"] as? String

        return Outfit(
            id: document.documentID,
            mood: mood,
            occasion: occasion,
            topId: topId,
            bottomId: bottomId,
            shoesId: shoesId,
            outerId: outerId,
            createdAt: createdAt,
            reason: reason
        )
    }
}
