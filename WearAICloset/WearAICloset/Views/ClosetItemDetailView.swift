import SwiftUI

struct ClosetItemDetailView: View {
    let item: ClothingItem
    @ObservedObject var viewModel: ClosetViewModel
    @State private var showingDeleteConfirmation = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let errorMessage = viewModel.errorMessage {
                    ErrorBanner(message: errorMessage) {
                        viewModel.clearError()
                    }
                    .padding(.horizontal)
                }

                AsyncImage(url: item.imageURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(maxWidth: .infinity, minHeight: 240)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, minHeight: 240)
                            .foregroundColor(.secondary)
                    @unknown default:
                        EmptyView()
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))

                VStack(alignment: .leading, spacing: 8) {
                    LabeledContent("Category", value: item.category.displayName)
                    LabeledContent(
                        "Created",
                        value: item.createdAt.formatted(date: .abbreviated, time: .shortened)
                    )
                }
                .padding(.horizontal)

                Button(role: .destructive) {
                    showingDeleteConfirmation = true
                } label: {
                    Text("Delete Item")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationTitle("Item Details")
        .alert("Delete Item", isPresented: $showingDeleteConfirmation) {
            Button("Delete", role: .destructive) {
                Task {
                    await viewModel.deleteItem(item)
                }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This will remove the item from Firestore and delete the image from Storage.")
        }
    }
}

#Preview {
    ClosetItemDetailView(
        item: ClothingItem(
            id: UUID().uuidString,
            imageURL: URL(string: "https://example.com/item.jpg")!,
            storagePath: "users/mock/items/item.jpg",
            category: .outerwear,
            createdAt: Date()
        ),
        viewModel: ClosetViewModel(
            closetItemsRepository: FirestoreClosetItemsRepository(),
            userSession: UserSession(authService: DefaultAuthService())
        )
    )
}
