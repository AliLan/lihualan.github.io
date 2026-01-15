import Foundation

final class SettingsViewModel: ObservableObject {
    @Published var styleGoal: String = "Curate everyday capsules"
    @Published var weeklyOutfitTarget: Int = 5
    @Published var smartRecommendationsEnabled: Bool = true
    @Published var analyticsEnabled: Bool = true

    private let analyticsService: AnalyticsService

    init(analyticsService: AnalyticsService) {
        self.analyticsService = analyticsService
    }

    func toggleAnalytics() {
        analyticsEnabled.toggle()
        analyticsService.track(event: "analytics_toggle")
    }
}
