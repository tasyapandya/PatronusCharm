//
//  WitchAnimateView.swift
//  PatronusCharm
//
//  Created by Tasya Pandya Latifa on 26/03/26.
//

import SwiftUI
internal import Combine

struct WitchView: View {
    // false = Pose A (tanpa tangan) → Page 1
    // true  = Pose B (ada tangan)   → Page 2
    var poseB: Bool = false
    
    var body: some View {
        Image(poseB ? "witch_pose_b" : "witch_pose_a")
            .resizable()
            .scaledToFit()
            .frame(height: 350)
    }
}

#Preview {
    HStack {
        WitchView(poseB: false)
        WitchView(poseB: true)
    }
    .background(Color.black)
}
