import SwiftUI

@main
struct WearAIClosetApp: App {
    @StateObject private var userSession: UserSession
    @StateObject private var homeViewModel: HomeViewModel
    @StateObject private var closetViewModel: ClosetViewModel
    @StateObject private var favoritesViewModel: FavoritesViewModel
    @StateObject private var settingsViewModel: SettingsViewModel

    init() {
        let session = UserSession(authService: DefaultAuthService())
        _userSession = StateObject(wrappedValue: session)
        _homeViewModel = StateObject(wrappedValue: HomeViewModel(
            closetRepository: MockClosetRepository(),
            analyticsService: DefaultAnalyticsService(),
            userSession: session
        ))
        _closetViewModel = StateObject(wrappedValue: ClosetViewModel(
            closetItemsRepository: FirestoreClosetItemsRepository(),
            userSession: session
        ))
        _favoritesViewModel = StateObject(wrappedValue: FavoritesViewModel(
            outfitRepository: MockOutfitRepository(),
            userSession: session
        ))
        _settingsViewModel = StateObject(wrappedValue: SettingsViewModel(
            analyticsService: DefaultAnalyticsService(),
            userSession: session
        ))
    }

    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView(viewModel: homeViewModel)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }

                ClosetView(viewModel: closetViewModel)
                    .tabItem {
                        Label("Closet", systemImage: "square.grid.2x2")
                    }

                FavoritesView(viewModel: favoritesViewModel)
                    .tabItem {
                        Label("Favorites", systemImage: "heart")
                    }

                SettingsView(viewModel: settingsViewModel)
                    .tabItem {
                        Label("Settings", systemImage: "gearshape")
                    }
            }
        }
    }
}
