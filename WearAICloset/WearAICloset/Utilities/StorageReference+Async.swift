import FirebaseStorage

extension StorageReference {
    func putDataAsync(_ data: Data) async throws -> StorageMetadata {
        try await withCheckedThrowingContinuation { continuation in
            putData(data, metadata: nil) { metadata, error in
                if let error {
                    continuation.resume(throwing: error)
                } else if let metadata {
                    continuation.resume(returning: metadata)
                } else {
                    continuation.resume(throwing: URLError(.cannotCreateFile))
                }
            }
        }
    }

    func deleteAsync() async throws {
        try await withCheckedThrowingContinuation { continuation in
            delete { error in
                if let error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume()
                }
            }
        }
    }
}
