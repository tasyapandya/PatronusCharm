//
//  OnboardingManager.swift
//  PatronusCharm
//
//  Created by Tasya Pandya Latifa on 23/03/26.
//

import SwiftUI
import Observation

@Observable
class OnboardingManager {
    static let shared = OnboardingManager()
    
    enum TooltipType: String {
        case startRitual = "hasShownStartRitual"
        case typeFeeling = "hasShownTypeFeeling"
        case scribbleChaos = "hasShownScribbleChaos"
        case stirPotion = "hasShownStirPotion"
        case releaseSpirit = "hasShownReleaseSpirit"
    }
    
    private let defaults = UserDefaults.standard
    
    // Inisialisasi privat untuk Singleton
    private init() {}
    
    func hasShown(tooltip: TooltipType) -> Bool {
        return defaults.bool(forKey: tooltip.rawValue)
    }
    
    func markShown(tooltip: TooltipType) {
        defaults.set(true, forKey: tooltip.rawValue)
    }
}
