//
//  PotionBubblesSpriteView.swift
//  PatronusCharm
//
//  Created by Tasya Pandya Latifa on 27/03/26.
//


import SwiftUI
import SpriteKit

struct PotionBubblesSpriteView: View {
    var color: Color
    
    @State private var scene: BubblesScene = {
        let s = BubblesScene()
        s.size = CGSize(width: 300, height: 200)
        s.scaleMode = .resizeFill
        return s
    }()
    
    var body: some View {
        SpriteView(scene: scene, options: [.allowsTransparency])
            .onAppear {
                scene.updateParticleColor(to: color)
            }
            // Gunakan syntax iOS 17 (tanpa parameter kedua jika tidak butuh old value)
            .onChange(of: color) {
                scene.updateParticleColor(to: color)
            }
            .allowsHitTesting(false)
    }
}
