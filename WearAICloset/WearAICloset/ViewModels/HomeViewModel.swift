import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var selectedMood: Mood = .happy
    @Published var selectedOccasion: Occasion = .casual
    @Published var generatedOutfits: [OutfitResult] = []
    @Published var isGenerating: Bool = false
    @Published var errorMessage: String?

    private let closetItemsRepository: ClosetItemsRepository
    private let analyticsService: AnalyticsService
    private let ruleEngine: OutfitRuleEngine
    let userSession: UserSession

    private var cachedItems: [ClothingItem] = []
    private var generationSeed = UInt64(Date().timeIntervalSince1970)

    init(
        closetItemsRepository: ClosetItemsRepository,
        analyticsService: AnalyticsService,
        ruleEngine: OutfitRuleEngine = OutfitRuleEngine(),
        userSession: UserSession
    ) {
        self.closetItemsRepository = closetItemsRepository
        self.analyticsService = analyticsService
        self.ruleEngine = ruleEngine
        self.userSession = userSession
    }

    var itemsById: [String: ClothingItem] {
        Dictionary(uniqueKeysWithValues: cachedItems.map { ($0.id, $0) })
    }

    func generateOutfits() {
        Task {
            await generateOutfitsAsync(regenerate: false)
        }
    }

    func regenerateOutfits() {
        Task {
            await generateOutfitsAsync(regenerate: true)
        }
    }

    private func generateOutfitsAsync(regenerate: Bool) async {
        guard let userId = userSession.userId else {
            errorMessage = "You must be signed in to generate outfits."
            return
        }

        isGenerating = true
        defer { isGenerating = false }

        do {
            cachedItems = try await closetItemsRepository.fetchItems(userId: userId)
            let validationError = ruleEngine.validate(items: cachedItems)
            if let validationError {
                errorMessage = validationError
                generatedOutfits = []
                return
            }

            if regenerate {
                generationSeed &+= 1
            }

            analyticsService.track(event: "home_generate_outfits")
            generatedOutfits = ruleEngine.generateOutfits(
                items: cachedItems,
                mood: selectedMood,
                occasion: selectedOccasion,
                seed: generationSeed
            )
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
            generatedOutfits = []
        }
    }
}
