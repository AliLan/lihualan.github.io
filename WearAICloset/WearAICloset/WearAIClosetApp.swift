import SwiftUI

@main
struct WearAIClosetApp: App {
    @StateObject private var homeViewModel = HomeViewModel(
        closetRepository: MockClosetRepository(),
        analyticsService: DefaultAnalyticsService()
    )
    @StateObject private var closetViewModel = ClosetViewModel(
        closetRepository: MockClosetRepository(),
        closetService: DefaultClosetService()
    )
    @StateObject private var favoritesViewModel = FavoritesViewModel(
        outfitRepository: MockOutfitRepository()
    )
    @StateObject private var settingsViewModel = SettingsViewModel(
        analyticsService: DefaultAnalyticsService()
    )

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
