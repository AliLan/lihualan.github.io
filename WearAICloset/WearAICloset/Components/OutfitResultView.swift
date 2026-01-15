import SwiftUI

struct OutfitResultView: View {
    let outfit: OutfitResult
    let itemsById: [String: ClothingItem]
    let onSave: () -> Void
    let isSaving: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(outfit.reason)
                .font(.subheadline)
                .foregroundColor(.secondary)

            HStack(spacing: 12) {
                itemImage(for: outfit.topId)
                itemImage(for: outfit.bottomId)
                itemImage(for: outfit.shoesId)
                if let outerId = outfit.outerId {
                    itemImage(for: outerId)
                }
            }

            Button("Save") {
                onSave()
            }
            .buttonStyle(.bordered)
            .disabled(isSaving)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
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
            .frame(width: 64, height: 64)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        } else {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(.systemGray4))
                .frame(width: 64, height: 64)
        }
    }
}

#Preview {
    OutfitResultView(
        outfit: OutfitResult(
            topId: "top",
            bottomId: "bottom",
            shoesId: "shoes",
            outerId: "outer",
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
        onSave: {},
        isSaving: false
    )
}
