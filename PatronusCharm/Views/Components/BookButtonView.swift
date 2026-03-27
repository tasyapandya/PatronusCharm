//
//  BookButtonView.swift
//  PatronusCharm
//
//  Created by Tasya Pandya Latifa on 26/03/26.
//

import SwiftUI

struct BookButtonView: View {
    var onTap: () -> Void
    
    @State private var glowing: Bool = false
    
    var body: some View {
        Button(action: onTap) {
            ZStack {
                // Glow pulse
                Ellipse()
                    .fill(Color("#E8B86D").opacity(glowing ? 0.4 : 0.1))
                    .scaleEffect(glowing ? 1.2 : 0.9)
                    .frame(width: 100, height: 70)
                    .blur(radius: glowing ? 15 : 5)
                    .animation(
                        .easeInOut(duration: 1.8).repeatForever(autoreverses: true),
                        value: glowing
                    )
                
                Image("bookOpened")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250)
                    .shadow(
                        color: Color("#E8B86D").opacity(glowing ? 0.5 : 0.2),
                        radius: 10
                    )
            }
        }
        .buttonStyle(.plain)
        .onAppear { glowing = true }
    }
}

#Preview {
    BookButtonView {}
        .background(Color(red: 0.2, green: 0.15, blue: 0.1))
}
