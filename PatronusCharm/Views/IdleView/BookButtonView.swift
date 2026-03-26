//
//  BookButtonView.swift
//  PatronusCharm
//

import SwiftUI

struct BookButtonView: View {
    @Binding var showTooltip: Bool
    var onTap: () -> Void
    
    // Untuk animasi glow pulse
    @State private var glowing: Bool = false
    
    var body: some View {
        Button(action: onTap) {
            ZStack {
                // ── Glow layer di belakang buku ──────────────────
                // Ellipse supaya glow mengikuti bentuk buku (landscape)
                Ellipse()
                    .fill(Color("#E8B86D").opacity(glowing ? 0.35 : 0.1))
                    .frame(width: 200, height: 80)
                    .blur(radius: 16)
                    .animation(
                        .easeInOut(duration: 1.8)
                        .repeatForever(autoreverses: true),
                        value: glowing
                    )
                
                // ── Buku ─────────────────────────────────────────
                Image("book_open")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180)
            }
        }
        .buttonStyle(.plain) // hapus default iOS button styling
        .onAppear {
            glowing = true
        }
    }
}

#Preview {
    BookButtonView(showTooltip: .constant(false)) {}
        .background(Color(red: 0.2, green: 0.15, blue: 0.1))
}