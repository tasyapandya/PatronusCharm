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
        lottieFile: "patronus_phoenix",
        tintColor: Emotion.unknown.color,
        emotion: .unknown
    )
    
    static let deer = Spirit(
        name: "Deer",
        lottieFile: "patronus_deer",
        tintColor: Emotion.anger.color,
        emotion: .anger
    )
    
    static let rabbit = Spirit(
        name: "Rabbit",
        lottieFile: "patronus_rabbit",
        tintColor: Emotion.overwhelmed.color,
        emotion: .overwhelmed
    )
    
    static let horse = Spirit(
        name: "Horse",
        lottieFile: "patronus_horse",
        tintColor: Emotion.anxiety.color,
        emotion: .anxiety
    )
}
