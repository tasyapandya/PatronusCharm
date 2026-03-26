//
//  MainRitualView.swift
//  PatronusCharm
//
//  Created by Tasya Pandya Latifa on 26/03/26.
//

import SwiftUI

struct MainRitualView: View {
    var body: some View {
        ZStack {
            // Background Landscape (SVG)
            Image("background_landscape")
                .resizable()
                .ignoresSafeArea()
            
            HStack(spacing: 50) {
                WitchAnimateView()
                CauldronIdleView()
            }
            .padding()
        }
    }
}
