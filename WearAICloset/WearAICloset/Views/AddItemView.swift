import PhotosUI
import SwiftUI
import UIKit

struct AddItemView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: ClosetViewModel

    @State private var selectedImage: UIImage?
    @State private var selectedCategory: Category?
    @State private var selectedPhotoItem: PhotosPickerItem?
    @State private var showCameraPicker = false

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

                Section("Photo") {
                    if let selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 240)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }

                    PhotosPicker(selection: $selectedPhotoItem, matching: .images) {
                        Label("Choose from Library", systemImage: "photo.on.rectangle")
                    }

                    if UIImagePickerController.isSourceTypeAvailable(.camera) {
                        Button {
                            showCameraPicker = true
                        } label: {
                            Label("Take Photo", systemImage: "camera")
                        }
                    }
                }

                Section("Category") {
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(Category.allCases) { category in
                            Text(category.displayName).tag(Optional(category))
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("Add Item")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        Task {
                            guard let selectedImage, let selectedCategory else { return }
                            await viewModel.addItem(image: selectedImage, category: selectedCategory)
                            if viewModel.errorMessage == nil {
                                dismiss()
                            }
                        }
                    }
                    .disabled(selectedImage == nil || selectedCategory == nil)
                }
            }
            .onChange(of: selectedPhotoItem) { newItem in
                guard let newItem else { return }
                Task {
                    if let data = try? await newItem.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        selectedImage = image
                    }
                }
            }
            .sheet(isPresented: $showCameraPicker) {
                ImagePicker(sourceType: .camera) { image in
                    selectedImage = image
                }
            }
        }
    }
}

#Preview {
    AddItemView(viewModel: ClosetViewModel(
        closetItemsRepository: FirestoreClosetItemsRepository(),
        userSession: UserSession(authService: DefaultAuthService())
    ))
}
