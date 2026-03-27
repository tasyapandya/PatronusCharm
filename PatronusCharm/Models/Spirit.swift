//
//  Spirit.swift
//  PatronusCharm
//
//  Created by Tasya Pandya Latifa on 23/03/26.
//

import SwiftUI

enum Spirit: String, CaseIterable {
    case deer, rabbit, horse, phoenix

    // Properti untuk ambil nama file PNG
    var imageName: String {
        switch self {
        case .deer: return "Spirit_deer"
        case .rabbit: return "Spirit_rabbit"
        case .horse: return "Spirit_horse"
        case .phoenix: return "Spirit_phoenix"
        }
    }

    // Properti untuk warna aura (tint)
    var tintColor: Color {
        return .white
    }
    
    // Nama tampilan
    var displayName: String {
        self.rawValue.capitalized
    }
}
