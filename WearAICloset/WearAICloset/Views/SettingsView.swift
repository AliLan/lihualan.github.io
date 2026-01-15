import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel

    var body: some View {
        NavigationStack {
            Form {
                if let errorMessage = viewModel.userSession.errorMessage {
                    Section {
                        ErrorBanner(message: errorMessage, retryAction: {
                            Task {
                                await viewModel.userSession.bootstrap()
                            }
                        })
                    }
                }

                Section("Profile") {
                    LabeledContent("Style Goal", value: viewModel.styleGoal)
                    LabeledContent("Weekly Outfit Target", value: "\(viewModel.weeklyOutfitTarget)")
                }

                Section("Preferences") {
                    Toggle("Smart Recommendations", isOn: $viewModel.smartRecommendationsEnabled)
                    Toggle("Analytics Sharing", isOn: $viewModel.analyticsEnabled)
                }

                Section("Session") {
                    LabeledContent("User ID", value: viewModel.userSession.userIdDisplay)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView(viewModel: SettingsViewModel(
        analyticsService: DefaultAnalyticsService(),
        userSession: UserSession(authService: DefaultAuthService())
    ))
}
