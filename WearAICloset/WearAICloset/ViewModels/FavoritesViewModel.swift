import Combine
import Foundation
import FirebaseFirestore

@MainActor
final class FavoritesViewModel: ObservableObject {
    @Published var outfits: [Outfit] = []
    @Published var itemsById: [String: ClothingItem] = [:]
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let outfitsRepository: OutfitsRepository
    private let closetItemsRepository: ClosetItemsRepository
    let userSession: UserSession

    private var listener: ListenerRegistration?
    private var cancellables = Set<AnyCancellable>()

    init(
        outfitsRepository: OutfitsRepository,
        closetItemsRepository: ClosetItemsRepository,
        userSession: UserSession
    ) {
        self.outfitsRepository = outfitsRepository
        self.closetItemsRepository = closetItemsRepository
        self.userSession = userSession
        bindSession()
    }

    func deleteOutfit(_ outfit: Outfit) async {
        guard let userId = userSession.userId else {
            errorMessage = "You must be signed in to delete outfits."
            return
        }

        isLoading = true
        defer { isLoading = false }

        do {
            try await outfitsRepository.deleteOutfit(userId: userId, outfitId: outfit.id)
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func clearError() {
        errorMessage = nil
    }

    private func bindSession() {
        userSession.$userId
            .receive(on: DispatchQueue.main)
            .sink { [weak self] userId in
                self?.startListening(userId: userId)
            }
            .store(in: &cancellables)
    }

    private func startListening(userId: String?) {
        listener?.remove()
        outfits = []
        itemsById = [:]

        guard let userId else {
            return
        }

        isLoading = true
        listener = outfitsRepository.observeOutfits(
            userId: userId,
            onChange: { [weak self] outfits in
                self?.outfits = outfits.sorted { $0.createdAt > $1.createdAt }
                Task { await self?.refreshItems(userId: userId) }
                self?.isLoading = false
            },
            onError: { [weak self] error in
                self?.errorMessage = error.localizedDescription
                self?.isLoading = false
            }
        )
    }

    private func refreshItems(userId: String) async {
        do {
            let items = try await closetItemsRepository.fetchItems(userId: userId)
            itemsById = Dictionary(uniqueKeysWithValues: items.map { ($0.id, $0) })
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
