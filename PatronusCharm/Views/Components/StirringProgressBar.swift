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
            
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.white.opacity(0.3))
                    .frame(width: 300, height: 12)
                
                Capsule()
                    .fill(Color.orange) // Warna progress sesuai gambar kamu
                    .frame(width: 300 * progress, height: 12)
                    .animation(.linear, value: progress)
            }
            .overlay(
                Capsule().stroke(Color.white.opacity(0.5), lineWidth: 1)
            )
        }
    }
}
