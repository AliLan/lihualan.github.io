import Foundation
import FirebaseAuth

protocol AuthService {
    var currentUserId: String? { get }
    func signInAnonymously() async throws -> String
}

struct DefaultAuthService: AuthService {
    var currentUserId: String? {
        Auth.auth().currentUser?.uid
    }

    func signInAnonymously() async throws -> String {
        try await withCheckedThrowingContinuation { continuation in
            Auth.auth().signInAnonymously { result, error in
                if let error {
                    continuation.resume(throwing: error)
                    return
                }

                if let uid = result?.user.uid {
                    continuation.resume(returning: uid)
                } else {
                    continuation.resume(throwing: URLError(.userAuthenticationRequired))
                }
            }
        }
    }
}
