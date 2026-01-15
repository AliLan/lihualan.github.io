import Foundation
import FirebaseCore

enum FirebaseBootstrapError: Error, LocalizedError {
    case missingConfiguration

    var errorDescription: String? {
        switch self {
        case .missingConfiguration:
            return "Firebase configuration is missing. Add GoogleService-Info.plist to the WearAICloset target."
        }
    }
}

struct FirebaseBootstrap {
    static func configureIfPossible() throws {
        guard Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") != nil else {
            throw FirebaseBootstrapError.missingConfiguration
        }

        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
    }
}
