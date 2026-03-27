//
//  BubblesScene.swift
//  PatronusCharm
//
//  Created by Tasya Pandya Latifa on 27/03/26.
//


import SpriteKit
import SwiftUI

class BubblesScene: SKScene {
    
    var emitterNode: SKEmitterNode?
    
    override func didMove(to view: SKView) {
        backgroundColor = .clear
        
        if let emitter = SKEmitterNode(fileNamed: "potionBubbles") {
            emitter.position = CGPoint(x: frame.midX, y: frame.midY)
            emitter.zPosition = 1
            
            // --- INI KUNCINYA ---
            // 1. Matikan sequence warna bawaan file .sks
            emitter.particleColorSequence = nil
            
            // 2. Pastikan warna bisa berubah 100% (1.0 = Full Color Override)
            emitter.particleColorBlendFactor = 1.0
            
            addChild(emitter)
            self.emitterNode = emitter
        }
    }
    
    func updateParticleColor(to color: Color) {
        let uiColor = UIColor(color)
        
        // Buat warnanya lebih terang sedikit (vibrant)
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        uiColor.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        let brighterColor = UIColor(hue: h, saturation: s, brightness: min(b + 0.2, 1.0), alpha: a)
        
        // Terapkan ke emitter
        emitterNode?.particleColor = brighterColor
        emitterNode?.particleColorBlendFactor = 1.0 // Pastikan lagi di sini
    }
}
