import Foundation

final class HomeViewModel: ObservableObject {
    @Published var highlightItems: [ClothingItem] = []
    @Published var currentMood: Mood = .calm
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let closetRepository: ClosetRepository
    private let analyticsService: AnalyticsService

    init(closetRepository: ClosetRepository, analyticsService: AnalyticsService) {
        self.closetRepository = closetRepository
        self.analyticsService = analyticsService
        loadHighlights()
    }

    func refresh() {
        analyticsService.track(event: "home_refresh")
        loadHighlights()
    }

    private func loadHighlights() {
        isLoading = true
        highlightItems = closetRepository.fetchHighlights()
        currentMood = highlightItems.first?.mood ?? .calm
        isLoading = false
        errorMessage = nil
    }
}
