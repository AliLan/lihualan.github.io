import Foundation

final class FavoritesViewModel: ObservableObject {
    @Published var favoriteOutfits: [Outfit] = []

    private let outfitRepository: OutfitRepository
    let userSession: UserSession

    init(outfitRepository: OutfitRepository, userSession: UserSession) {
        self.outfitRepository = outfitRepository
        self.userSession = userSession
        loadFavorites()
    }

    private func loadFavorites() {
        favoriteOutfits = outfitRepository.fetchFavoriteOutfits()
    }
}
