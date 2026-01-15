import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if let errorMessage = viewModel.errorMessage {
                        ErrorBanner(message: errorMessage) {
                            viewModel.generateOutfits()
                        }
                    }

                    if let saveMessage = viewModel.saveMessage {
                        Text(saveMessage)
                            .font(.caption)
                            .foregroundColor(.green)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Mood")
                            .font(.headline)
                        Picker("Mood", selection: $viewModel.selectedMood) {
                            ForEach(Mood.allCases) { mood in
                                Text(mood.displayName).tag(mood)
                            }
                        }
                        .pickerStyle(.segmented)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Occasion")
                            .font(.headline)
                        Picker("Occasion", selection: $viewModel.selectedOccasion) {
                            ForEach(Occasion.allCases) { occasion in
                                Text(occasion.displayName).tag(occasion)
                            }
                        }
                        .pickerStyle(.segmented)
                    }

                    HStack(spacing: 12) {
                        Button("Generate Outfits") {
                            viewModel.generateOutfits()
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(viewModel.isGenerating)

                        Button("Regenerate") {
                            viewModel.regenerateOutfits()
                        }
                        .buttonStyle(.bordered)
                        .disabled(viewModel.isGenerating || viewModel.generatedOutfits.isEmpty)
                    }

                    if viewModel.isGenerating {
                        LoadingView(message: "Generating outfits...")
                    }

                    if viewModel.generatedOutfits.isEmpty {
                        Text("No outfits generated yet.")
                            .foregroundColor(.secondary)
                    } else {
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(viewModel.generatedOutfits) { outfit in
                                OutfitResultView(
                                    outfit: outfit,
                                    itemsById: viewModel.itemsById,
                                    onSave: {
                                        viewModel.saveOutfit(outfit)
                                    },
                                    isSaving: viewModel.isSaving
                                )
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(
        closetItemsRepository: FirestoreClosetItemsRepository(),
        outfitsRepository: FirestoreOutfitsRepository(),
        analyticsService: DefaultAnalyticsService(),
        userSession: UserSession(authService: DefaultAuthService())
    ))
}
