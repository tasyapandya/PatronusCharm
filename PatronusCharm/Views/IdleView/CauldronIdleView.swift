//
//  CauldronIdleView.swift
//  PatronusCharm
//
//  Created by Tasya Pandya Latifa on 26/03/26.
//

import SwiftUI

import SwiftUI
import SpriteKit

struct CauldronIdleView: View {
    // Utk scene SpriteKit yang menampung particle
    var bubbleScene: SKScene {
        let scene = SKScene(size: CGSize(width: 200, height: 200))
        scene.backgroundColor = .clear
        
        if let emitter = SKEmitterNode(fileNamed: "potionBubbles.sks") {
            emitter.position = CGPoint(x: 100, y: 50) // Posisikan di tengah kuali
            scene.addChild(emitter)
        }
        return scene
    }

    var body: some View {
        ZStack {
            
            Image("cauldronIdle")
                .resizable()
                .scaledToFit()
                .frame(width: 300)

            // Efek Gelembung di atas kuali
            SpriteView(scene: bubbleScene, options: [.allowsTransparency])
                .frame(width: 200, height: 200)
                .offset(y: -50) // Sesuaikan agar pas di mulut kuali
        }
    }
}

#Preview {
    CauldronIdleView()
}
