import Foundation

final class HomeViewModel: ObservableObject {
    @Published var highlightItems: [ClothingItem] = []
    @Published var currentMood: Mood = .calm
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let closetRepository: ClosetRepository
    private let analyticsService: AnalyticsService
    let userSession: UserSession

    init(closetRepository: ClosetRepository, analyticsService: AnalyticsService, userSession: UserSession) {
        self.closetRepository = closetRepository
        self.analyticsService = analyticsService
        self.userSession = userSession
        loadHighlights()
    }

    func refresh() {
        analyticsService.track(event: "home_refresh")
        loadHighlights()
    }

    private func loadHighlights() {
        isLoading = true
        highlightItems = closetRepository.fetchHighlights()
        currentMood = .calm
        isLoading = false
        errorMessage = nil
    }
}
