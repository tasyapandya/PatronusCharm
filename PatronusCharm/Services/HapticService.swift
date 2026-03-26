//
//  HapticService.swift
//  PatronusCharm
//
//  Created by Tasya Pandya Latifa on 23/03/26.
//

import CoreHaptics
import UIKit

class HapticService {
    
    // Engine adalah "mesin" haptic — perlu diinisialisasi sekali
    // dan dijaga tetap hidup selama app berjalan
    private var engine: CHHapticEngine?
    
    init() {
        prepareEngine()
    }
    
    // MARK: - Setup
    
    private func prepareEngine() {
        // Tidak semua iPhone support Core Haptics
        // (iPhone 6 ke bawah tidak support) — selalu cek dulu
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            print("Device tidak support Core Haptics")
            return
        }
        
        do {
            engine = try CHHapticEngine()
            
            // Engine bisa berhenti otomatis saat tidak dipakai
            // Ini callback untuk menghidupkannya lagi
            engine?.stoppedHandler = { reason in
                print("Haptic engine berhenti: \(reason)")
            }
            
            engine?.resetHandler = { [weak self] in
                print("Haptic engine reset — menghidupkan ulang...")
                try? self?.engine?.start()
            }
            
            try engine?.start()
        } catch {
            print("Gagal membuat haptic engine: \(error)")
        }
    }
    
    // MARK: - Public Functions
    
    /// Getaran kasar saat scribble — gritty, chaos
    /// Dipanggil berulang selama user menggambar di canvas
    func playChaosFeedback() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics,
              let engine else { return }
        
        // Sharpness tinggi (0.8) = terasa tajam dan kasar
        // Intensity medium (0.5) = tidak terlalu kuat, tapi terasa
        // Duration pendek (0.1) = seperti "gratan" kecil
        let sharpness = CHHapticEventParameter(
            parameterID: .hapticSharpness,
            value: 0.8
        )
        let intensity = CHHapticEventParameter(
            parameterID: .hapticIntensity,
            value: 0.5
        )
        
        let event = CHHapticEvent(
            eventType: .hapticTransient, // Transient = pendek, satu ketukan
            parameters: [intensity, sharpness],
            relativeTime: 0,
            duration: 0.1
        )
        
        play(events: [event], engine: engine)
    }
    
    /// Getaran lembut saat stirring — fluid, menenangkan
    /// Dipanggil berulang selama user mengaduk kuali
    func playClarityFeedback() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics,
              let engine else { return }
        
        // Sharpness rendah (0.1) = terasa smooth dan lembut
        // Intensity rendah (0.3) = hampir tidak terasa, subtle
        // Duration panjang (0.3) = mengalir, bukan ketukan
        let sharpness = CHHapticEventParameter(
            parameterID: .hapticSharpness,
            value: 0.1
        )
        let intensity = CHHapticEventParameter(
            parameterID: .hapticIntensity,
            value: 0.3
        )
        
        let event = CHHapticEvent(
            eventType: .hapticContinuous, // Continuous = mengalir, bukan ketukan
            parameters: [intensity, sharpness],
            relativeTime: 0,
            duration: 0.3
        )
        
        play(events: [event], engine: engine)
    }
    
    /// Satu hentakan kuat saat Patronus berhasil muncul
    func playSuccessHaptic() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics,
              let engine else { return }
        
        // Pattern dua event: satu kuat, satu echo lebih kecil
        // Efeknya seperti "dug... dug" — terasa ada sesuatu yang muncul
        let strongHit = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
            ],
            relativeTime: 0
        )
        
        let echo = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.4),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.2)
            ],
            relativeTime: 0.15 // 0.15 detik setelah hit pertama
        )
        
        play(events: [strongHit, echo], engine: engine)
    }
    
    /// Getaran sangat lembut sebagai hint — "hei, coba ini"
    /// Dipanggil saat canvas kosong tapi user coba tap Create
    func playSoftHint() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics,
              let engine else { return }
        
        let event = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.2),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.1)
            ],
            relativeTime: 0
        )
        
        play(events: [event], engine: engine)
    }
    
    // MARK: - Private Helper
    
    // Semua fungsi publik di atas memanggil helper ini
    // supaya tidak ada duplikasi kode try-catch
    private func play(events: [CHHapticEvent], engine: CHHapticEngine) {
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: CHHapticTimeImmediate)
        } catch {
            print("Gagal memutar haptic: \(error)")
        }
    }
}
