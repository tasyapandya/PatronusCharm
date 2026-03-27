//
//  WitchBubbleView.swift
//  PatronusCharm
//
//  Created by Tasya Pandya Latifa on 26/03/26.
//


//
//  WitchBubbleView.swift
//  PatronusCharm
//

import SwiftUI

struct WitchBubbleView: View {
    let text: String
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Bubble utama
            Text(text)
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(Color("#3D2B1F"))
                .multilineTextAlignment(.leading)
                .lineSpacing(3)
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color("#F5ECD7"))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color("#C4A882"), lineWidth: 1)
                        )
                )
            
            // Tail segitiga di kiri bawah → menunjuk ke kucing
            Triangle()
                .fill(Color("#F5ECD7"))
                .overlay(
                    Triangle()
                        .stroke(Color("#C4A882"), lineWidth: 1)
                )
                .frame(width: 12, height: 10)
                .offset(x: 20, y: 9)
        }
        .frame(maxWidth: 200) // ← tune: lebar bubble
    }
}

// Shape helper untuk tail bubble
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

#Preview {
    WitchBubbleView(text: "Tap the book to\nbegin your potion creation!")
        .padding()
        .background(Color.gray)
}
