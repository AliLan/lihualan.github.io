import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var selectedMood: Mood = .happy
    @Published var selectedOccasion: Occasion = .casual
    @Published var generatedOutfits: [OutfitResult] = []
    @Published var isGenerating: Bool = false
    @Published var isSaving: Bool = false
    @Published var errorMessage: String?
    @Published var saveMessage: String?

    private let closetItemsRepository: ClosetItemsRepository
    private let outfitsRepository: OutfitsRepository
    private let analyticsService: AnalyticsService
    private let ruleEngine: OutfitRuleEngine
    let userSession: UserSession

    private var cachedItems: [ClothingItem] = []
    private var generationSeed = UInt64(Date().timeIntervalSince1970)
    private var savedKeys = Set<String>()

    init(
        closetItemsRepository: ClosetItemsRepository,
        outfitsRepository: OutfitsRepository,
        analyticsService: AnalyticsService,
        ruleEngine: OutfitRuleEngine = OutfitRuleEngine(),
        userSession: UserSession
    ) {
        self.closetItemsRepository = closetItemsRepository
        self.outfitsRepository = outfitsRepository
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

    func saveOutfit(_ result: OutfitResult) {
        Task {
            await saveOutfitAsync(result)
        }
    }

    private func saveOutfitAsync(_ result: OutfitResult) async {
        guard let userId = userSession.userId else {
            errorMessage = "You must be signed in to save outfits."
            return
        }

        let key = "\(result.topId)-\(result.bottomId)-\(result.shoesId)-\(result.outerId ?? "none")"
        guard !savedKeys.contains(key) else {
            saveMessage = "Already saved this outfit."
            return
        }

        let outfit = Outfit(
            id: UUID().uuidString,
            mood: selectedMood,
            occasion: selectedOccasion,
            topId: result.topId,
            bottomId: result.bottomId,
            shoesId: result.shoesId,
            outerId: result.outerId,
            createdAt: Date(),
            reason: result.reason
        )

        isSaving = true
        defer { isSaving = false }

        do {
            try await outfitsRepository.saveOutfit(userId: userId, outfit: outfit)
            savedKeys.insert(key)
            saveMessage = "Saved to Favorites."
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
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
