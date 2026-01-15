import SwiftUI

struct ClosetView: View {
    @ObservedObject var viewModel: ClosetViewModel
    @State private var showingAddItem = false

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

                ForEach(Category.allCases) { category in
                    Section(category.displayName) {
                        let items = viewModel.itemsByCategory[category] ?? []
                        if items.isEmpty {
                            Text("No items yet")
                                .foregroundColor(.secondary)
                        } else {
                            ForEach(items) { item in
                                NavigationLink {
                                    ClosetItemDetailView(item: item, viewModel: viewModel)
                                } label: {
                                    ClosetItemRow(item: item)
                                }
                            }
                        }
                    }
                }
            }
            .overlay {
                if viewModel.isLoading {
                    LoadingView(message: "Updating closet...")
                        .padding()
                }
            }
            .navigationTitle("Closet")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Item") {
                        showingAddItem = true
                    }
                }
            }
            .sheet(isPresented: $showingAddItem) {
                AddItemView(viewModel: viewModel)
            }
        }
    }
}

private struct ClosetItemRow: View {
    let item: ClothingItem

    var body: some View {
        HStack(spacing: 12) {
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
            .frame(width: 56, height: 56)
            .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 4) {
                Text(item.category.displayName)
                    .font(.headline)
                Text(item.createdAt.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ClosetView(viewModel: ClosetViewModel(
        closetItemsRepository: FirestoreClosetItemsRepository(),
        userSession: UserSession(authService: DefaultAuthService())
    ))
}
