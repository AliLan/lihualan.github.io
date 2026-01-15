import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    @Published var styleGoal: String = "Curate everyday capsules"
    @Published var weeklyOutfitTarget: Int = 5
    @Published var smartRecommendationsEnabled: Bool = true
    @Published var analyticsEnabled: Bool = true
    @Published var isClearingData: Bool = false
    @Published var statusMessage: String?
    @Published var errorMessage: String?

    private let analyticsService: AnalyticsService
    private let dataCleanupService: DataCleanupService
    let userSession: UserSession

    init(
        analyticsService: AnalyticsService,
        dataCleanupService: DataCleanupService,
        userSession: UserSession
    ) {
        self.analyticsService = analyticsService
        self.dataCleanupService = dataCleanupService
        self.userSession = userSession
    }

    var appVersionText: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
        return "\(version) (\(build))"
    }

    func toggleAnalytics() {
        analyticsEnabled.toggle()
        analyticsService.track(event: "analytics_toggle")
    }

    func clearError() {
        errorMessage = nil
    }

    func clearMyData() async {
        guard let userId = userSession.userId else {
            errorMessage = "You must be signed in to clear your data."
            return
        }

        isClearingData = true
        statusMessage = "Clearing closet items and outfits..."
        defer {
            isClearingData = false
            statusMessage = nil
        }

        do {
            try await dataCleanupService.clearUserData(userId: userId)
            statusMessage = "Data cleared successfully."
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
