//
//  SpeechBubbleView.swift
//  PatronusCharm
//
//  Created by Tasya Pandya Latifa on 27/03/26.
//

import SwiftUI

struct SpeechBubbleView: View {
    var text: String
    
    var body: some View {
        VStack(spacing: 0) {
            // Kotak Teks
            Text(text)
                .font(.custom("Iowan Old Style", size: 18))
                .italic()
                .foregroundColor(Color(red: 0.2, green: 0.15, blue: 0.1))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
                .padding(.vertical, 15)
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color.white.opacity(0.95))
                )
                .shadow(color: .black.opacity(0.1), radius: 8, y: 4)
                // Batasi lebar maksimal agar tidak kena pinggir layar HP
                .frame(maxWidth: 320)

            // Ekor Bubble (Segitiga)
            Image(systemName: "arrowtriangle.down.fill")
                .resizable()
                .frame(width: 25, height: 15)
                .foregroundColor(Color.white.opacity(0.95))
                .offset(y: -2) // Tarik sedikit ke atas biar nyambung sempurna
        }
    }
}

#Preview {
    VStack {
        Color.gray.ignoresSafeArea()
        SpeechBubbleView(text: "Your heart is a beacon of light.")
    }
}

