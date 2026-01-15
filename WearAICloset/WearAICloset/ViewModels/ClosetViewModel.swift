import Foundation

final class ClosetViewModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var recentItems: [ClothingItem] = []

    private let closetRepository: ClosetRepository
    private let closetService: ClosetService
    let userSession: UserSession

    init(closetRepository: ClosetRepository, closetService: ClosetService, userSession: UserSession) {
        self.closetRepository = closetRepository
        self.closetService = closetService
        self.userSession = userSession
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
