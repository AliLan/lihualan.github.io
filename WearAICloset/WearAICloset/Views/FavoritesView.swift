import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: FavoritesViewModel

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                Text("Saved Outfits")
                    .font(.title2)
                    .fontWeight(.semibold)

                ForEach(viewModel.favoriteOutfits) { outfit in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(outfit.name)
                            .font(.subheadline)
                        Text("\(outfit.items.count) pieces • \(outfit.occasion.displayName)")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        if let firstItem = outfit.items.first {
                            Text("First item: \(firstItem.category.displayName)")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Favorites")
        }
    }
}

#Preview {
    FavoritesView(viewModel: FavoritesViewModel(
        outfitRepository: MockOutfitRepository(),
        userSession: UserSession(authService: DefaultAuthService())
    ))
}
