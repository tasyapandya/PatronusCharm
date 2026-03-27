//
//  CauldronIdleView.swift
//  PatronusCharm
//
//  Created by Tasya Pandya Latifa on 26/03/26.
//

import SwiftUI
import SpriteKit

import SwiftUI

struct CauldronIdleView: View {
    @Environment(RitualViewModel.self) private var vm
    
    var body: some View {
        ZStack {
            // LAYER 1: Back (Paling Belakang)
            Image("BackCauldron")
                .resizable()
                .scaledToFit()
            
            // LAYER 2: Fill (Cairan)
            Circle()
                .fill(vm.scribbleDominantColor) // Default White dari VM
                .frame(width: 300, height: 170) // Sesuaikan lubang
                .blur(radius: 10)
                .opacity(0.7)
                .offset(y: -10)
            
            // LAYER 3: Bubbles (SPRITEKIT - NEW)
            // Ditumpuk di atas cairan, di bawah kuali depan
            PotionBubblesSpriteView(color: vm.scribbleDominantColor)
                .offset(y: -15) // Posisikan di permukaan cairan

            // LAYER 4: Front (Paling Depan)
            Image("FrontCauldron")
                .resizable()
                .scaledToFit()
                // Pastikan tidak menghalangi sentuhan jika nanti ada interaksi
                .allowsHitTesting(false)
        }
    }
}

#Preview {
    // 1. Buat Mock ViewModel
    let mockVM = RitualViewModel()
    
    // 2. Beri warna dummy supaya kelihatan hasilnya di preview
    mockVM.scribbleDominantColor = .white
    
    return ZStack {
        // Beri background gelap supaya gelembung & kuali terlihat jelas
        Color.gray.ignoresSafeArea()
        
        CauldronIdleView()
            .frame(width: 250) // Sesuaikan ukuran untuk testing
    }
    // 3. INJECT ENVIRONMENT (WAJIB)
    .environment(mockVM)
}
