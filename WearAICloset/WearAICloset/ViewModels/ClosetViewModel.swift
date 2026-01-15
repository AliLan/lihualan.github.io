import Foundation

final class ClosetViewModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var recentItems: [ClothingItem] = []

    private let closetRepository: ClosetRepository
    private let closetService: ClosetService

    init(closetRepository: ClosetRepository, closetService: ClosetService) {
        self.closetRepository = closetRepository
        self.closetService = closetService
        loadData()
    }

    func itemCount(for category: Category) -> Int {
        recentItems.filter { $0.category == category }.count
    }

    private func loadData() {
        categories = closetRepository.fetchCategories()
        recentItems = closetRepository.fetchRecentItems()
    }

    func syncCloset() async {
        _ = await closetService.syncCloset()
    }
}
