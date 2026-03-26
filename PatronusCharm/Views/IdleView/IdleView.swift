//
//  IdleView.swift
//  PatronusCharm
//

import SwiftUI

struct IdleView: View {
    @Environment(RitualViewModel.self) private var vm
    
    // Untuk tooltip onboarding
    @State private var showTooltip: Bool = false
    
    // Untuk animasi buku (subtle float)
    @State private var bookFloating: Bool = false
    
    var body: some View {
        ZStack {
            
            // ── Layer 1: Background ──────────────────────────────
            Image("background_landscape")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            // ── Layer 2: Karakter & Kuali ────────────────────────
            VStack {
                Spacer()
                
                HStack(alignment: .bottom, spacing: 24) {
                    // Witch kiri — Pose A
                    WitchView(poseB: false)
                    
                    // Kuali kanan dengan bubble
                    CauldronIdleView()
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 16)
            }
            
            // ── Layer 3: Buku sebagai CTA ────────────────────────
            VStack {
                HStack {
                    Spacer()
                    BookButtonView(showTooltip: $showTooltip) {
                        // Action saat buku ditekan
                        withAnimation(.easeInOut(duration: 0.4)) {
                            vm.currentPhase = .inputText
                        }
                    }
                    .padding(.top, 60)
                    .padding(.trailing, 24)
                }
                Spacer()
            }
            
            // ── Layer 4: Tooltip Onboarding ──────────────────────
            if showTooltip {
                VStack {
                    HStack {
                        Spacer()
                        TooltipView(text: "Tap the book to begin your ritual")
                            .padding(.top, 130) // tepat di bawah buku
                            .padding(.trailing, 32)
                    }
                    Spacer()
                }
                .transition(.opacity)
            }
        }
        .onAppear {
            handleOnAppear()
        }
    }
    
    // MARK: - Private
    
    private func handleOnAppear() {
        // Mulai BGM saat idle view muncul
        AudioService.shared.playBGM(named: "bgm_ambient")
        
        // Cek apakah perlu tampilkan tooltip
        let manager = OnboardingManager.shared
        if !manager.hasShown(tooltip: .startRitual) {
            // Delay sedikit supaya layar sudah selesai render
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation(.easeIn(duration: 0.3)) {
                    showTooltip = true
                }
                manager.markShown(tooltip: .startRitual)
                
                // Auto-hide tooltip setelah 4 detik
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    withAnimation(.easeOut(duration: 0.3)) {
                        showTooltip = false
                    }
                }
            }
        }
    }
}

#Preview {
    IdleView()
        .environment(RitualViewModel())
}