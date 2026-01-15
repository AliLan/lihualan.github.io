import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: FavoritesViewModel

    var body: some View {
        NavigationStack {
            List {
                if let errorMessage = viewModel.errorMessage {
                    Section {
                        ErrorBanner(message: errorMessage) {
                            viewModel.clearError()
                        }
                    }
                }

                if viewModel.outfits.isEmpty {
                    Section {
                        Text("No saved outfits yet")
                            .foregroundColor(.secondary)
                    }
                } else {
                    ForEach(viewModel.outfits) { outfit in
                        NavigationLink {
                            OutfitDetailView(
                                outfit: outfit,
                                itemsById: viewModel.itemsById,
                                onDelete: {
                                    Task { await viewModel.deleteOutfit(outfit) }
                                }
                            )
                        } label: {
                            OutfitRowView(outfit: outfit, itemsById: viewModel.itemsById)
                        }
                    }
                }
            }
            .overlay {
                if viewModel.isLoading {
                    LoadingView(message: "Loading favorites...")
                        .padding()
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

private struct OutfitRowView: View {
    let outfit: Outfit
    let itemsById: [String: ClothingItem]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(outfit.mood.displayName) • \(outfit.occasion.displayName)")
                .font(.headline)

            Text(outfit.createdAt.formatted(date: .abbreviated, time: .shortened))
                .font(.caption)
                .foregroundColor(.secondary)

            HStack(spacing: 8) {
                itemImage(for: outfit.topId)
                itemImage(for: outfit.bottomId)
                itemImage(for: outfit.shoesId)
            }
        }
        .padding(.vertical, 4)
    }

    @ViewBuilder
    private func itemImage(for itemId: String) -> some View {
        if let item = itemsById[itemId] {
            AsyncImage(url: item.imageURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable().scaledToFill()
                case .failure:
                    Image(systemName: "photo")
                        .foregroundColor(.secondary)
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 44, height: 44)
            .clipShape(RoundedRectangle(cornerRadius: 6))
        } else {
            RoundedRectangle(cornerRadius: 6)
                .fill(Color(.systemGray4))
                .frame(width: 44, height: 44)
        }
    }
}

#Preview {
    FavoritesView(viewModel: FavoritesViewModel(
        outfitsRepository: FirestoreOutfitsRepository(),
        closetItemsRepository: FirestoreClosetItemsRepository(),
        userSession: UserSession(authService: DefaultAuthService())
    ))
}
