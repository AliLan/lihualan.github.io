import Combine
import Foundation
import FirebaseFirestore
import UIKit

@MainActor
final class ClosetViewModel: ObservableObject {
    @Published var items: [ClothingItem] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let closetItemsRepository: ClosetItemsRepository
    let userSession: UserSession
    private var listener: ListenerRegistration?
    private var cancellables = Set<AnyCancellable>()

    init(closetItemsRepository: ClosetItemsRepository, userSession: UserSession) {
        self.closetItemsRepository = closetItemsRepository
        self.userSession = userSession
        bindSession()
    }

    var itemsByCategory: [Category: [ClothingItem]] {
        Dictionary(grouping: items) { $0.category }
    }

    func addItem(image: UIImage, category: Category) async {
        guard let userId = userSession.userId else {
            errorMessage = "You must be signed in to add items."
            return
        }

        guard let imageData = image.resized(maxDimension: 1600).jpegData(compressionQuality: 0.75) else {
            errorMessage = "Unable to process the selected image."
            return
        }

        isLoading = true
        defer { isLoading = false }

        do {
            let itemId = UUID().uuidString
            try await closetItemsRepository.addItem(
                userId: userId,
                itemId: itemId,
                imageData: imageData,
                category: category
            )
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func deleteItem(_ item: ClothingItem) async {
        guard let userId = userSession.userId else {
            errorMessage = "You must be signed in to delete items."
            return
        }

        isLoading = true
        defer { isLoading = false }

        do {
            try await closetItemsRepository.deleteItem(userId: userId, item: item)
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
        items = []

        guard let userId else {
            return
        }

        isLoading = true
        listener = closetItemsRepository.observeItems(
            userId: userId,
            onChange: { [weak self] items in
                self?.items = items.sorted { $0.createdAt > $1.createdAt }
                self?.isLoading = false
            },
            onError: { [weak self] error in
                self?.errorMessage = error.localizedDescription
                self?.isLoading = false
            }
        )
    }
}
