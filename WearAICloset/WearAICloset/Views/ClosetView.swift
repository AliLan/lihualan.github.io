import SwiftUI

struct ClosetView: View {
    @ObservedObject var viewModel: ClosetViewModel

    var body: some View {
        NavigationStack {
            List {
                Section("Categories") {
                    ForEach(viewModel.categories, id: \.self) { category in
                        HStack {
                            Text(category.displayName)
                            Spacer()
                            Text("\(viewModel.itemCount(for: category))")
                                .foregroundColor(.secondary)
                        }
                    }
                }

                Section("Recent Items") {
                    ForEach(viewModel.recentItems) { item in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.name)
                                .font(.subheadline)
                            Text("\(item.color) • \(item.season)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Closet")
        }
    }
}

#Preview {
    ClosetView(viewModel: ClosetViewModel(
        closetRepository: MockClosetRepository(),
        closetService: DefaultClosetService()
    ))
}
