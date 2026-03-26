//
//  TooltipView.swift
//  PatronusCharm
//

import SwiftUI

struct TooltipView: View {
    let text: String
    
    var body: some View {
        HStack(spacing: 6) {
            // Bintang kecil sesuai spec PRD
            Text("✦")
                .font(.system(size: 11))
                .foregroundStyle(Color("#C4A8E8"))
            
            Text(text)
                .font(.system(size: 13))
                .foregroundStyle(Color("#E8B86D"))
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color("#2D2040").opacity(0.9))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color("#6B4FA0"), lineWidth: 1)
                )
        )
        // Max width sesuai spec PRD: 220px
        .frame(maxWidth: 220)
    }
}

#Preview {
    TooltipView(text: "Tap the book to begin your ritual")
        .background(Color.black)
}