import SwiftUI

struct OutfitDetailView: View {
    let outfit: Outfit
    let itemsById: [String: ClothingItem]
    let onDelete: () -> Void
    @State private var showingDeleteConfirmation = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("\(outfit.mood.displayName) • \(outfit.occasion.displayName)")
                    .font(.title3)
                    .fontWeight(.semibold)

                if let reason = outfit.reason {
                    Text(reason)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                VStack(alignment: .leading, spacing: 12) {
                    itemSection(title: "Top", itemId: outfit.topId)
                    itemSection(title: "Bottom", itemId: outfit.bottomId)
                    itemSection(title: "Shoes", itemId: outfit.shoesId)
                    if let outerId = outfit.outerId {
                        itemSection(title: "Outerwear", itemId: outerId)
                    }
                }

                Button(role: .destructive) {
                    showingDeleteConfirmation = true
                } label: {
                    Text("Delete Outfit")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .navigationTitle("Outfit")
        .alert("Delete Outfit", isPresented: $showingDeleteConfirmation) {
            Button("Delete", role: .destructive) {
                onDelete()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This will remove the outfit from your favorites.")
        }
    }

    @ViewBuilder
    private func itemSection(title: String, itemId: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            if let item = itemsById[itemId] {
                AsyncImage(url: item.imageURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(maxWidth: .infinity, minHeight: 160)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, minHeight: 160)
                            .foregroundColor(.secondary)
                    @unknown default:
                        EmptyView()
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))
            } else {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemGray5))
                    .frame(height: 160)
            }
        }
    }
}

#Preview {
    OutfitDetailView(
        outfit: Outfit(
            id: UUID().uuidString,
            mood: .confident,
            occasion: .work,
            topId: "top",
            bottomId: "bottom",
            shoesId: "shoes",
            outerId: "outer",
            createdAt: Date(),
            reason: "work + confident: clean silhouette"
        ),
        itemsById: [
            "top": ClothingItem(
                id: "top",
                imageURL: URL(string: "https://example.com/top.jpg")!,
                storagePath: "users/mock/items/top.jpg",
                category: .top,
                createdAt: Date()
            )
        ],
        onDelete: {}
    )
}
