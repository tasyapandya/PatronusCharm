//
//  Color+Extensions.swift
//  PatronusCharm
//
//  Created by Tasya Pandya Latifa on 23/03/26.
//

import SwiftUI

extension Color {
    init(_ hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8) & 0xFF) / 255
        let b = Double(int & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
    
    // Warna per emosi
    
    static let angerRed      = Color("#E84040")
    static let overwhelmedPurple = Color("#8B5CF6")
    static let anxietySilver = Color("#94A3B8")
    static let defaultAmber  = Color("#E8B86D")
    static let cauldronPurple = Color("#6B4FA0")
    static let deepNight     = Color("#1A1228")
}
