import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                Text("Today's Style Pulse")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text("Mood: \(viewModel.currentMood.displayName)")
                    .font(.headline)

                if viewModel.isLoading {
                    LoadingView(message: "Loading recommendations...")
                }

                if let errorMessage = viewModel.errorMessage {
                    ErrorBanner(message: errorMessage) {
                        viewModel.refresh()
                    }
                }

                Text("Highlights")
                    .font(.headline)

                ForEach(viewModel.highlightItems) { item in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.name)
                            .font(.subheadline)
                        Text("\(item.category.displayName) • \(item.color)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 6)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(
        closetRepository: MockClosetRepository(),
        analyticsService: DefaultAnalyticsService()
    ))
}
