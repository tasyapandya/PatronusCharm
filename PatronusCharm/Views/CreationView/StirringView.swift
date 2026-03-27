//
//  StirringView.swift
//  PatronusCharm
//
//  Created by Tasya Pandya Latifa on 27/03/26.
//

import SwiftUI

struct StirringView: View {
    @Environment(RitualViewModel.self) private var vm
    @State private var progress: Double = 0.0
    @State private var spoonOffset: CGSize = .zero
    @State private var lastAngle: Double = 0.0
    @State private var totalRotation: Double = 0.0
    
    var body: some View {
        GeometryReader { geo in
            // Titik pusat kuali (Meja)
            let center = CGPoint(x: geo.size.width / 2, y: geo.size.height * 0.55)
            // Ukuran kuali agar konsisten di semua layar
            let cauldronWidth = geo.size.width * 0.35
            
            ZStack {
                // 1. Background
                Image("newbackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                // 2. Progress Bar (Dibuat lebih pendek dan di tengah)
                VStack {
                    StirringProgressBar(progress: progress)
                        .frame(width: geo.size.width * 0.4) // Panjang cuma 40% layar
                    Spacer()
                }
                .padding(.top, 60)

                // 3. Area Kuali & Sendok (Sandwich Layer)
                ZStack {
                    // Layer Belakang Kuali
                    Image("BackCauldron")
                        .resizable()
                        .scaledToFit()
                    
                    // FILLER: Cairan (Transisi warna ke putih)
                    Circle()
                        .fill(vm.scribbleDominantColor.mix(with: .white, by: progress))
                        .frame(width: cauldronWidth * 0.85, height: cauldronWidth * 0.45)
                        .blur(radius: 8)
                        .opacity(0.7 + (progress * 0.3))
                        .offset(y: -cauldronWidth * 0.05) // Menyesuaikan dengan lubang kuali

                    // BUBBLES (Muncul mengikuti warna cairan)
                    PotionBubblesSpriteView(color: vm.scribbleDominantColor.mix(with: .white, by: progress))
                        .frame(width: cauldronWidth * 0.8, height: cauldronWidth * 0.4)
                        .offset(y: -cauldronWidth * 0.08)
                        .allowsHitTesting(false)

                    // SENDOK (Spoon)
                    Image("Spoon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: cauldronWidth * 0.4)
                        .offset(x: spoonOffset.width, y: spoonOffset.height - (cauldronWidth * 0.1))
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                    handleCircularStirring(value: value, center: center, maxRad: cauldronWidth * 0.3)
                                }
                                .onEnded { _ in lastAngle = 0.0 }
                        )

                    // Layer Depan Kuali
                    Image("FrontCauldron")
                        .resizable()
                        .scaledToFit()
                        .allowsHitTesting(false)
                }
                .frame(width: cauldronWidth)
                .position(center)
                
                // 4. Tombol Kembali ke Buku (Book Button)
                BookButtonView {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        vm.currentPhase = .inputText
                    }
                }
                .frame(width: 80, height: 80)
                // Dipindahkan ke pojok kanan bawah agar tidak hilang
                .position(x: geo.size.width * 0.85, y: geo.size.height * 0.85)
                
                // 5. Instruksi Kucing
                if progress < 0.9 {
                    WitchInstructionView(bubbleText: "Stir until the chaos clears...") {}
                        .frame(width: 250)
                        .position(x: geo.size.width * 0.25, y: geo.size.height * 0.8)
                }
            }
        }
    }

    // Logic Update dengan parameter radius yang dinamis
    private func handleCircularStirring(value: DragGesture.Value, center: CGPoint, maxRad: CGFloat) {
        let dragX = value.translation.width
        let dragY = value.translation.height
        
        let distance = sqrt(dragX * dragX + dragY * dragY)
        var limitedX = dragX
        var limitedY = dragY

        if distance > maxRad {
            limitedX = dragX * (maxRad / distance)
            limitedY = dragY * (maxRad / distance)
        }
        
        // Batasi gerakan vertikal (Y) agar tidak keluar kuali
        limitedY = max(-20, min(20, limitedY))

        withAnimation(.interactiveSpring()) {
            spoonOffset = CGSize(width: limitedX, height: limitedY)
        }

        // Hitung Progress
        let vectorX = value.location.x - center.x
        let vectorY = value.location.y - center.y
        let currentAngle = atan2(vectorY, vectorX)
        
        if lastAngle != 0.0 {
            var angleDiff = currentAngle - lastAngle
            if angleDiff > .pi { angleDiff -= 2 * .pi }
            if angleDiff < -.pi { angleDiff += 2 * .pi }
            
            totalRotation += abs(angleDiff)
            
            // 5 Putaran (2*PI * 5)
            let newProgress = totalRotation / (2 * .pi * 5.0)
            if newProgress > progress {
                progress = min(newProgress, 1.0)
                if Int(totalRotation * 10) % 5 == 0 {
                    UIImpactFeedbackGenerator(style: .soft).impactOccurred(intensity: 0.3)
                }
            }
        }
        lastAngle = currentAngle
        
        if progress >= 1.0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation { vm.conjurePatronus() }
            }
        }
    }
}

#Preview {
    let vm = RitualViewModel()
    
    vm.scribbleDominantColor = .purple
    
    vm.currentPhase = .stirring
    
    return ZStack {
        StirringView()
    }

    .environment(vm)
}
