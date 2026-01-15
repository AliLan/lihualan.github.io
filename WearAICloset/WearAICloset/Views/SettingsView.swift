import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel
    @State private var showingClearConfirmation = false

    var body: some View {
        NavigationStack {
            Form {
                if let errorMessage = viewModel.errorMessage {
                    Section {
                        ErrorBanner(message: errorMessage) {
                            viewModel.clearError()
                        }
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
                    LabeledContent("App Version", value: viewModel.appVersionText)
                }

                Section("Data") {
                    if let statusMessage = viewModel.statusMessage {
                        Text(statusMessage)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }

                    Button(role: .destructive) {
                        showingClearConfirmation = true
                    } label: {
                        Text("Clear My Data")
                    }
                    .disabled(viewModel.isClearingData)
                }
            }
            .overlay {
                if viewModel.isClearingData {
                    LoadingView(message: "Clearing your data...")
                        .padding()
                }
            }
            .navigationTitle("Settings")
            .alert("Clear My Data", isPresented: $showingClearConfirmation) {
                Button("Clear", role: .destructive) {
                    Task {
                        await viewModel.clearMyData()
                    }
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("This will delete all your items and saved outfits.")
            }
        }
    }
}

#Preview {
    SettingsView(viewModel: SettingsViewModel(
        analyticsService: DefaultAnalyticsService(),
        dataCleanupService: FirestoreDataCleanupService(),
        userSession: UserSession(authService: DefaultAuthService())
    ))
}
