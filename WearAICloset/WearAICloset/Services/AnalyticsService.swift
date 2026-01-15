import Foundation

protocol AnalyticsService {
    func track(event: String)
}

struct DefaultAnalyticsService: AnalyticsService {
    func track(event: String) {
        // Placeholder implementation
    }
}
