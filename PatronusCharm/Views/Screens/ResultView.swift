//
//  ResultView.swift
//  PatronusCharm
//
//  Created by Tasya Pandya Latifa on 27/03/26.
//

import SwiftUI

struct ResultView: View {
    @Environment(RitualViewModel.self) private var vm
    @State private var spiritOpacity: Double = 0.0
    @State private var spiritScale: CGFloat = 0.6
    @State private var showTapHint: Bool = false
    @State private var showWoA: Bool = false
    @State private var showSwipeHint: Bool = false
    @State private var dragOffset: CGSize = .zero
    @State private var showClosurePage: Bool = false
    @State private var isBreathing = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Background Tetap Sama
                Image("newbackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .overlay(Color.black.opacity(0.2))

                // Kuali di Tengah
                cauldronGroup(width: geo.size.width * 0.35)
                    .position(x: geo.size.width / 2, y: geo.size.height * 0.6)
                    .opacity(showClosurePage ? 0 : 1)
                    .overlay(Color.black.opacity(0.8))

                // SPIRIT & WOA AREA
                VStack(spacing: 0) {
                    if showWoA {
                        SpeechBubbleView(text: vm.currentWoA)
                            .transition(.asymmetric(
                                insertion: .move(edge: .bottom).combined(with: .opacity),
                                removal: .opacity
                            ))
                    } else {
                        // Placeholder agar Spirit tidak loncat saat WoA muncul
                        Color.clear.frame(height: 100)
                    }

                    // SPIRIT (DIPERBESAR)
                    ZStack {
                        Circle() // Aura Glow
                            .fill(vm.scribbleDominantColor)
                            .frame(width: geo.size.width * 0.5)
                            .blur(radius: 60)
                            // 1. Glow-nya ikut berdenyut
                            .opacity(spiritOpacity * (isBreathing ? 0.5 : 0.2))

                        Image(vm.patronusImageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width * 0.3)
                            // 2. Shadow ikut berdenyut layaknya makhluk hidup
                            .shadow(color: .white.opacity(isBreathing ? 0.6 : 0.2), radius: isBreathing ? 25 : 10)
                    }
                    // 3. Efek melayang (naik turun pelan)
                    .offset(y: isBreathing ? -8 : 8)
                    // 4. Terapkan animasi HANYA pada perubahan isBreathing
                    .animation(
                        .easeInOut(duration: 2).repeatForever(autoreverses: true),
                        value: isBreathing
                    )
                    // 5. Modifier asli milikmu (Pastikan dragOffset di bawah .animation agar tidak bentrok)
                    .scaleEffect(spiritScale)
                    .opacity(spiritOpacity)
                    .offset(dragOffset)
                    .onTapGesture { handleSpiritTapped() }
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if showWoA && value.translation.height < 0 {
                                    dragOffset = value.translation
                                }
                            }
                            .onEnded { value in
                                if showWoA && value.translation.height < -120 {
                                    handleReleaseGesture()
                                } else {
                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                                        dragOffset = .zero
                                    }
                                }
                            }
                    )
                    // 6. Trigger animasinya saat view ini muncul
                    .onAppear {
                        isBreathing = true
                    }
                    hintsView
                }
                .position(x: geo.size.width / 2, y: geo.size.height * 0.5)

                // Closure Page
                if showClosurePage {
                    closurePageView
                }
            }
            .onAppear { startSequence() }
        }
    }
    
    // Helper View biar kodenya rapi
    private func cauldronGroup(width: CGFloat) -> some View {
        ZStack {
            Image("BackCauldron").resizable().scaledToFit()
            Circle().fill(.white).frame(width: width * 0.8).blur(radius: 10).offset(y: -10)
            Image("FrontCauldron").resizable().scaledToFit()
        }
        .frame(width: width)
    }

    private var hintsView: some View {
        VStack {
            if showTapHint && !showWoA {
                Text("Tap the spirit to hear its message").font(.headline).foregroundColor(.white)
            }
            if showSwipeHint {
                VStack(spacing: 5) {
                    Image(systemName: "chevron.up.circle.fill").font(.title2)
                    Text("Swipe up to release").font(.headline)
                }
                .foregroundColor(.white)
            }
        }.frame(height: 60)
    }
    
    private var closurePageView: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            Text("That burden is no longer yours to carry.")
                .font(.custom("Iowan Old Style", size: 24))
                .italic().foregroundColor(.white).multilineTextAlignment(.center).padding(20)
        }.transition(.opacity)
    }

    // LOGIC
    private func startSequence() {
        withAnimation(.easeOut(duration: 1.5)) {
            spiritOpacity = 1.0
            spiritScale = 1.0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation { showTapHint = true }
        }
    }

    private func handleSpiritTapped() {
        guard !showWoA else { return }
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        withAnimation(.spring()) {
            showTapHint = false
            showWoA = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation { showSwipeHint = true }
        }
    }

    private func handleReleaseGesture() {
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        withAnimation(.easeOut(duration: 0.8)) {
            dragOffset.height = -1200
            spiritOpacity = 0
            showWoA = false
            showSwipeHint = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation { showClosurePage = true }
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                withAnimation { vm.reset() }
            }
        }
    }
}

#Preview {
    ResultView().environment(RitualViewModel())
}
