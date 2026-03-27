//
//  WitchInstructionView.swift
//  PatronusCharm
//

import SwiftUI

struct WitchInstructionView: View {
    let bubbleText: String
    var onDismiss: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            // Bubble chat di atas kucing
            WitchBubbleView(text: bubbleText)
                .padding(.leading, 48) // ← tune: offset bubble dari kiri
            
            // Kucing
            WitchView(poseB: false)
                .frame(width: 120) // ← tune: ukuran kucing
        }
    }
}

#Preview {
    ZStack {
        Color.black.opacity(0.45).ignoresSafeArea()
        WitchInstructionView(bubbleText: "Tap the book to\nbegin your ritual!") {}
    }
}