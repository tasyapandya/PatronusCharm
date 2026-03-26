//
//  BookButtonView.swift
//  PatronusCharm
//
//  Created by Tasya Pandya Latifa on 26/03/26.
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
                // Glow layer
                Ellipse()
                    .fill(Color("#E8B86D").opacity(glowing ? 0.4 : 0.1))
                    // Tambahkan skala agar terlihat berdenyut keluar-masuk
                    .scaleEffect(glowing ? 1.2 : 0.9)
                    .frame(width: 100, height: 70)
                    .blur(radius: glowing ? 15 : 5) // Blur juga ikut berdenyut
                    .animation(
                        .easeInOut(duration: 1.8).repeatForever(autoreverses: true),
                        value: glowing
                    )

                // Gambar Buku
                Image("bookOpened")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250)
                    // Opsional: Tambahkan shadow tipis yang mengikuti bentuk SVG
                    .shadow(color: Color("#E8B86D").opacity(glowing ? 0.5 : 0.2), radius: 10)
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
