import Foundation

protocol ClosetService {
    func syncCloset() async -> Bool
}

struct DefaultClosetService: ClosetService {
    func syncCloset() async -> Bool {
        return true
    }
}
