//
//  Spirit.swift
//  PatronusCharm
//
//  Created by Tasya Pandya Latifa on 23/03/26.
//

import SwiftUI

struct Spirit: Identifiable {
    let id = UUID()
    let name: String
    let lottieFile: String
    let tintColor: Color
    let emotion: Emotion
    
    static let phoenix = Spirit(
        name: "Phoenix",
        lottieFile: "spirit_phoenix",
        tintColor: Emotion.anger.color,
        emotion: .anger
    )
    
    static let jellyfish = Spirit(
        name: "Moon Jellyfish",
        lottieFile: "spirit_jellyfish",
        tintColor: Emotion.overwhelmed.color,
        emotion: .overwhelmed
    )
    
    static let owl = Spirit(
        name: "Celestial Owl",
        lottieFile: "spirit_owl",
        tintColor: Emotion.anxiety.color,
        emotion: .anxiety
    )
    
    static let particles = Spirit(
        name: "Glowing Particle Cluster",
        lottieFile: "spirit_particles",
        tintColor: Emotion.unknown.color,
        emotion: .unknown
    )
}
