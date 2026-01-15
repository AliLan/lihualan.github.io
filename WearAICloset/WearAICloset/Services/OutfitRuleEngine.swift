import Foundation

struct OutfitRuleEngine {
    func validate(items: [ClothingItem]) -> String? {
        let categories = Set(items.map { $0.category })
        let missing: [String] = [
            Category.top, .bottom, .shoes
        ].compactMap { categories.contains($0) ? nil : $0.displayName }

        if !missing.isEmpty {
            return "Add at least one item for: \(missing.joined(separator: ", "))."
        }
        return nil
    }

    func generateOutfits(
        items: [ClothingItem],
        mood: Mood,
        occasion: Occasion,
        seed: UInt64
    ) -> [OutfitResult] {
        let tops = items.filter { $0.category == .top }
        let bottoms = items.filter { $0.category == .bottom }
        let shoes = items.filter { $0.category == .shoes }
        let outers = items.filter { $0.category == .outerwear }

        guard !tops.isEmpty, !bottoms.isEmpty, !shoes.isEmpty else {
            return []
        }

        let reason = reasonText(for: mood, occasion: occasion)
        let baseCombos = crossProduct(tops: tops, bottoms: bottoms, shoes: shoes)
        var rng = SeededRandomNumberGenerator(seed: seed)
        let shuffled = baseCombos.shuffled(using: &rng)
        let targetCount = min(max(3, shuffled.count >= 5 ? 5 : 3), max(3, shuffled.count))

        var results: [OutfitResult] = []
        var usedCombos = Set<String>()

        for combo in shuffled {
            if results.count >= targetCount {
                break
            }

            let key = "\(combo.top.id)-\(combo.bottom.id)-\(combo.shoes.id)"
            guard !usedCombos.contains(key) else { continue }
            usedCombos.insert(key)

            let outerId = chooseOuter(
                outers: outers,
                occasion: occasion,
                rng: &rng
            )

            results.append(
                OutfitResult(
                    topId: combo.top.id,
                    bottomId: combo.bottom.id,
                    shoesId: combo.shoes.id,
                    outerId: outerId,
                    reason: reason
                )
            )
        }

        return results
    }

    private func crossProduct(
        tops: [ClothingItem],
        bottoms: [ClothingItem],
        shoes: [ClothingItem]
    ) -> [(top: ClothingItem, bottom: ClothingItem, shoes: ClothingItem)] {
        var combos: [(ClothingItem, ClothingItem, ClothingItem)] = []
        for top in tops {
            for bottom in bottoms {
                for shoe in shoes {
                    combos.append((top, bottom, shoe))
                }
            }
        }
        return combos
    }

    private func chooseOuter(
        outers: [ClothingItem],
        occasion: Occasion,
        rng: inout SeededRandomNumberGenerator
    ) -> String? {
        guard !outers.isEmpty else { return nil }
        let shouldPrefer = occasion == .work || occasion == .date || occasion == .travel
        if shouldPrefer {
            return outers.randomElement(using: &rng)?.id
        }
        let includeOuter = Bool.random(using: &rng)
        return includeOuter ? outers.randomElement(using: &rng)?.id : nil
    }

    private func reasonText(for mood: Mood, occasion: Occasion) -> String {
        "\(occasion.displayName.lowercased()) + \(mood.displayName.lowercased()): balanced look"
    }
}

struct SeededRandomNumberGenerator: RandomNumberGenerator {
    private var state: UInt64

    init(seed: UInt64) {
        state = seed
    }

    mutating func next() -> UInt64 {
        state &+= 0x9E3779B97F4A7C15
        var z = state
        z = (z ^ (z >> 30)) &* 0xBF58476D1CE4E5B9
        z = (z ^ (z >> 27)) &* 0x94D049BB133111EB
        return z ^ (z >> 31)
    }
}
