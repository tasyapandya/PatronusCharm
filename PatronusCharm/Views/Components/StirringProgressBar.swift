//
//  StirringProgressBar.swift
//  PatronusCharm
//
//  Created by Tasya Pandya Latifa on 27/03/26.
//

import SwiftUI

struct StirringProgressBar: View {
    var progress: Double
    
    var body: some View {
        VStack(spacing: 8) {
            Text("Stirring Progress")
                .font(.custom("Iowan Old Style", size: 18))
                .foregroundColor(.white)
            
            // Pakai GeometryReader supaya bar-nya tahu lebar yang tersedia
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    // Background Bar
                    Capsule()
                        .fill(Color.white.opacity(0.3))
                        .frame(height: 12)
                    
                    // Progress Bar (Warna Putih)
                    Capsule()
                        .fill(Color.white)
                        // Sekarang lebarnya otomatis: Lebar Total x Progress
                        .frame(width: geo.size.width * progress, height: 12)
                        .animation(.linear, value: progress)
                }
                .overlay(
                    Capsule().stroke(Color.white.opacity(0.5), lineWidth: 1)
                )
            }
            .frame(height: 12) // Tentukan tinggi area bar-nya saja
        }
    }
}
