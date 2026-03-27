//
//  IdleView.swift
//  PatronusCharm
//
//  Created by Tasya Pandya Latifa on 26/03/26.
//

import SwiftUI

struct IdleView: View {
    @Environment(RitualViewModel.self) private var vm
    
    // Kontrol visibility kucing + bubble + dim
    @State private var showWitchInstruction: Bool = true
    @State private var bubbleText: String = "Tap the book to\nbegin your potion creation!"
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                // ── Layer 1: Background ──────────────────────────
                Image("newbackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                // ── Layer 2: Cauldron (tengah) ───────────────────
                CauldronIdleView()
                    .frame(width: geo.size.width * 0.3)
                    .position(
                        x: geo.size.width * 0.5,
                        y: geo.size.height * 0.55
                    )
                
                // ── Layer 3: Buku (kanan bawah) ─────────────
                BookButtonView {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        vm.currentPhase = .inputText
                    }
                }
                .position(
                    x: geo.size.width * 0.83,
                    y: geo.size.height * 0.75
                )
                
                // ── Layer 4: Dim overlay + Kucing + Bubble ───────
                // Hanya muncul saat onboarding atau sebelum stirring
                if showWitchInstruction {
                    
                    // Dim background — fokus ke kucing
                    Color.black
                        .opacity(0.45)
                        .ignoresSafeArea()
                        .transition(.opacity)
                        // Tap di luar kucing → dismiss
                        .onTapGesture {
                            dismissWitchInstruction()
                        }
                    
                    // Kucing + Bubble chat
                    WitchInstructionView(bubbleText: bubbleText) {
                        dismissWitchInstruction()
                    }
                    .position(
                        x: geo.size.width * 0.15,  // ← tune: posisi X
                        y: geo.size.height * 0.82   // ← tune: posisi Y
                    )
                    .transition(
                        .asymmetric(
                            insertion: .move(edge: .bottom).combined(with: .opacity),
                            removal: .move(edge: .bottom).combined(with: .opacity)
                        )
                    )
                }
            }
        }
        .onAppear {
            handleOnAppear()
        }
    }
    
    // MARK: - Private
    
    private func handleOnAppear() {
        AudioService.shared.playBGM(named: "mainBgm")
        
        let manager = OnboardingManager.shared
        if !manager.hasShown(tooltip: .startRitual) {
            bubbleText = "Tap the book to\nbegin your ritual!"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                withAnimation(.spring(duration: 0.5)) {
                    showWitchInstruction = true
                }
                manager.markShown(tooltip: .startRitual)
            }
        }
    }
    
    // Dipanggil dari ResultView/RitualViewModel sebelum stirring
    // Atau bisa trigger dari luar via vm.shouldShowWitchHint
    func showStirringInstruction() {
        bubbleText = "Stir the cauldron\nuntil the chaos clears..."
        withAnimation(.spring(duration: 0.5)) {
            showWitchInstruction = true
        }
    }
    
    private func dismissWitchInstruction() {
        withAnimation(.easeOut(duration: 0.35)) {
            showWitchInstruction = false
        }
    }
}

#Preview {
    IdleView()
        .environment(RitualViewModel())
}
