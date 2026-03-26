//
//  RitualViewModel.swift
//  PatronusCharm
//
//  Created by Tasya Pandya Latifa on 23/03/26.
//

import SwiftUI

@Observable class RitualViewModel {
    
    // State utama
    var currentPhase: RitualPhase = .idle
    var currentEmotion: Emotion = .unknown
    var detectedPatronus: Spirit = .phoenix
    var currentWoA: String = ""
    var scribbleDominantColor: Color = .white
    var isProcessing: Bool = false
    
    // Services & ViewModels
    private let classifier = ClassificationViewModel()
    private let haptic = HapticService()
    
    // Dipanggil saat user tap Create
    func analyzeText(_ text: String) {
        currentEmotion = classifier.classifyEmotion(from: text)
    }
    
    func setScribbleColor(_ color: Color) {
        scribbleDominantColor = color
    }
    
    // Dipanggil saat stirring selesai
    func conjurePatronus() {
        // Tentukan patronus dari emosi
        switch currentEmotion {
        case .anger:       detectedPatronus = .deer
        case .overwhelmed: detectedPatronus = .rabbit
        case .anxiety:     detectedPatronus = .horse
        case .unknown:     detectedPatronus = .phoenix
        }
        
        // Ambil WoA random
        currentWoA = AffirmationPool.random(for: currentEmotion)
        
        // Trigger haptic
        haptic.playSuccessHaptic()
        
        currentPhase = .conjuring
    }
    
    func releasePatronus() {
        currentPhase = .releasing
        
        // Setelah animasi selesai, closure lalu reset
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.currentPhase = .closure
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.reset()
            }
        }
    }
    
    func reset() {
        currentPhase = .idle
        currentEmotion = .unknown
        detectedPatronus = .phoenix
        currentWoA = ""
        scribbleDominantColor = .white
    }
}
