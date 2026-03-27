//
//  RitualViewModel.swift
//  PatronusCharm
//
//  Created by Tasya Pandya Latifa on 23/03/26.
//

import SwiftUI

@Observable class RitualViewModel {
    
    // ─── State Utama ───
    var currentPhase: RitualPhase = .idle
    var currentEmotion: Emotion = .unknown
    var detectedPatronus: Spirit = .phoenix
    var currentWoA: String = ""
    var scribbleDominantColor: Color = .white
    
    // ─── Services ───
    private let classifier = ClassificationViewModel()
    private let haptic = HapticService()
    
    // ─── Computed Properties (Untuk memudahkan View) ───
    // Agar ResultView tinggal panggil vm.patronusImageName
    var patronusImageName: String {
        return detectedPatronus.imageName
    }

    // ─── Logic ───
    
    func analyzeText(_ text: String) {
        // CoreML/Natural Language Analysis
        currentEmotion = classifier.classifyEmotion(from: text)
    }
    
    // Dipanggil saat stirring selesai di StirringView
    func conjurePatronus() {
        // 1. Tentukan roh berdasarkan emosi hasil analisis
        switch currentEmotion {
        case .anger:        detectedPatronus = .deer
        case .overwhelmed:  detectedPatronus = .rabbit
        case .anxiety:      detectedPatronus = .horse
        case .unknown:      detectedPatronus = .phoenix
        }
        
        // 2. Ambil kata-kata afirmasi (WoA)
        currentWoA = AffirmationPool.random(for: currentEmotion)
        
        // 3. Mainkan haptic sukses
        haptic.playSuccessHaptic()
        
        // 4. Pindah ke phase Result (Conjuring)
        withAnimation(.easeInOut(duration: 1.0)) {
            currentPhase = .conjuring
        }
    }
    
    // Dipanggil saat user swipe up di ResultView
    func releasePatronus() {
        // Pindah ke phase Releasing (proses terbang/menghilang)
        currentPhase = .releasing
        
        // Trigger haptic yang kuat
        haptic.playSuccessHaptic() // Atau ganti ke haptic yang lebih 'heavy'
        
        // Sequence Penutup: Releasing -> Closure -> Reset to Idle
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(.easeInOut(duration: 1.0)) {
                self.currentPhase = .closure
            }
            
            // Tampilkan pesan penutup sebentar sebelum balik ke awal
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                withAnimation(.easeInOut(duration: 1.5)) {
                    self.reset()
                }
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
