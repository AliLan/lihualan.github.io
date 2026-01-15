import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel

    var body: some View {
        NavigationStack {
            Form {
                Section("Profile") {
                    LabeledContent("Style Goal", value: viewModel.styleGoal)
                    LabeledContent("Weekly Outfit Target", value: "\(viewModel.weeklyOutfitTarget)")
                }

                Section("Preferences") {
                    Toggle("Smart Recommendations", isOn: $viewModel.smartRecommendationsEnabled)
                    Toggle("Analytics Sharing", isOn: $viewModel.analyticsEnabled)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView(viewModel: SettingsViewModel(
        analyticsService: DefaultAnalyticsService()
    ))
}
