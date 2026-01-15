import Foundation

final class FavoritesViewModel: ObservableObject {
    @Published var favoriteOutfits: [Outfit] = []

    private let outfitRepository: OutfitRepository

    init(outfitRepository: OutfitRepository) {
        self.outfitRepository = outfitRepository
        loadFavorites()
    }

    private func loadFavorites() {
        favoriteOutfits = outfitRepository.fetchFavoriteOutfits()
    }
}
