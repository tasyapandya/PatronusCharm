//
//  Emotion.swift
//  PatronusCharm
//
//  Created by Tasya Pandya Latifa on 23/03/26.
//

import SwiftUI

enum Emotion: String, CaseIterable {
    case anger
    case overwhelmed
    case anxiety
    case unknown
    
    var displayName: String {
        switch self {
        case .anger: return "Anger"
        case .overwhelmed: return "Overwhelmed"
        case .anxiety: return "Anxiety"
        case .unknown: return "Unknown"
        }
    }
    
    var color: Color {
        switch self {
        case .anger: return Color("#E84040")
        case .overwhelmed: return Color("#8B5CF6")
        case .anxiety: return Color("#94A3B8")
        case .unknown: return Color("#C4A8E8")
        }
    }
}
