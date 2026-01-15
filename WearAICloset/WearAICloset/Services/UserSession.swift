import Foundation

@MainActor
final class UserSession: ObservableObject {
    @Published private(set) var userId: String?
    @Published var errorMessage: String?

    private let authService: AuthService

    init(authService: AuthService) {
        self.authService = authService
        Task {
            await bootstrap()
        }
    }

    var userIdDisplay: String {
        guard let userId else {
            return "Not signed in"
        }
        return String(userId.prefix(8))
    }

    func bootstrap() async {
        do {
            try FirebaseBootstrap.configureIfPossible()
            errorMessage = nil
            if let existingUserId = authService.currentUserId {
                userId = existingUserId
                return
            }
            userId = try await authService.signInAnonymously()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
