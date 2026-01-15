import Foundation

final class SettingsViewModel: ObservableObject {
    @Published var styleGoal: String = "Curate everyday capsules"
    @Published var weeklyOutfitTarget: Int = 5
    @Published var smartRecommendationsEnabled: Bool = true
    @Published var analyticsEnabled: Bool = true

    private let analyticsService: AnalyticsService
    let userSession: UserSession

    init(analyticsService: AnalyticsService, userSession: UserSession) {
        self.analyticsService = analyticsService
        self.userSession = userSession
    }

    func toggleAnalytics() {
        analyticsEnabled.toggle()
        analyticsService.track(event: "analytics_toggle")
    }
}
