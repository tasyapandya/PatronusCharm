//
//  IdleView.swift
//  PatronusCharm
//
//  Created by Tasya Pandya Latifa on 26/03/26.
//

import SwiftUI

struct IdleView: View {
    @Environment(RitualViewModel.self) private var vm
    @State private var showTooltip: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                // ── Layer 1: Background ──────────────────────────────
                Image("newbackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                // ── Layer 2: Main Layout ─────────────────────────────
                // Menggunakan ZStack agar kita bisa atur posisi tiap object secara absolut sesuai gambar
                ZStack(alignment: .bottom) {
                    
                    // 1. Kucing & Chat Bubble (Kiri Bawah)
                    VStack(spacing: 8) {
                        if showTooltip {
                            TooltipView(text: "Tap the book to begin your ritual")
                                .transition(.scale.combined(with: .opacity))
                        }
                        WitchView(poseB: false)
                            .frame(width: geo.size.width * 0.2) // Proporsional
                    }
                    .position(x: geo.size.width * 0.09, y: geo.size.height * 0.95)
                    
                    // 2. Cauldron (Tengah)
                    CauldronIdleView()
                        .frame(width: geo.size.width * 0.3)
                        .position(x: geo.size.width * 0.5, y: geo.size.height * 0.55)
                    
                    // 3. Buku / BookButton (Kanan Bawah)
                    BookButtonView(showTooltip: $showTooltip) {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            vm.currentPhase = .inputText
                        }
                    }
                    .position(x: geo.size.width * 0.83, y: geo.size.height * 0.75)
                    
                }
            }
        }
        .onAppear {
            handleOnAppear()
        }
    }
    
    // MARK: - Private
    
    private func handleOnAppear() {
        // Mulai BGM saat idle view muncul
        AudioService.shared.playBGM(named: "mainBgm")
        
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


