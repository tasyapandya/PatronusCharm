//
//  CauldronIdleView.swift
//  PatronusCharm
//
//  Created by Tasya Pandya Latifa on 26/03/26.
//

import SwiftUI
import SpriteKit

struct CauldronIdleView: View {
    @Environment(RitualViewModel.self) private var vm
    // 1. Terima parameter width dari luar
    var width: CGFloat = 200

    var body: some View {
        ZStack {
            // LAYER 1: Bagian Belakang Kuali
            Image("BackCauldron")
                .resizable()
                .scaledToFit()

            // LAYER 2: Fill (Cairan) - SEKARANG DINAMIS!
            Circle()
                .fill(vm.scribbleDominantColor)
                // Kita buat lebar cairan 85% dari lebar kuali,
                // dan tingginya sekitar 45% dari lebar kuali.
                .frame(width: width * 0.85, height: width * 0.60)
                .blur(radius: width * 0.05) // Blur juga harus dinamis biar nggak pecah
                .opacity(0.7)
                // Offset juga harus relatif
                .offset(y: -width * 0.08)

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
        // Pasang frame utama di sini
        .frame(width: width)
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
