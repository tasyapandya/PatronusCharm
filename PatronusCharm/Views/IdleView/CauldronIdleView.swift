//
//  CauldronIdleView.swift
//  PatronusCharm
//
//  Created by Tasya Pandya Latifa on 26/03/26.
//

import SwiftUI
import SpriteKit

struct CauldronIdleView: View {
    // @State supaya scene hanya dibuat SEKALI
    // bukan setiap kali SwiftUI re-render
    @State private var bubbleScene: SKScene = {
        let scene = SKScene(size: CGSize(width: 200, height: 200))
        scene.backgroundColor = .clear
        if let emitter = SKEmitterNode(fileNamed: "potionBubbles.sks") {
            emitter.position = CGPoint(x: 100, y: 70)
            scene.addChild(emitter)
        }
        return scene
    }()
    
    var body: some View {
        ZStack {
            Image("cauldronIdle")
                .resizable()
                .scaledToFit()
                .frame(width: 550)
            
            // Bubble/asap overlay di atas kuali
            SpriteView(scene: bubbleScene, options: [.allowsTransparency])
                .frame(width: 100, height: 100)
                .offset(y: -50)
                .allowsHitTesting(false) // supaya tap tidak tertangkap SpriteKit
        }
    }
}

#Preview {
    CauldronIdleView()
        .background(Color.black)
}
