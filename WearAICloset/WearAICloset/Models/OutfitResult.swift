import Foundation

struct OutfitResult: Identifiable, Hashable {
    let id: UUID
    let topId: String
    let bottomId: String
    let shoesId: String
    let outerId: String?
    let reason: String

    init(
        id: UUID = UUID(),
        topId: String,
        bottomId: String,
        shoesId: String,
        outerId: String?,
        reason: String
    ) {
        self.id = id
        self.topId = topId
        self.bottomId = bottomId
        self.shoesId = shoesId
        self.outerId = outerId
        self.reason = reason
    }
}
