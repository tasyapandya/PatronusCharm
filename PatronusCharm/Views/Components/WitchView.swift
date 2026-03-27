//
//  WitchAnimateView.swift
//  PatronusCharm
//
//  Created by Tasya Pandya Latifa on 26/03/26.
//

import SwiftUI

struct WitchView: View {
    var poseB: Bool = false
    
    var body: some View {
        Image(poseB ? "witch_pose_b" : "witch_pose_a")
            .resizable()
            .scaledToFit()
    }
}

#Preview {
    HStack {
        WitchView(poseB: false)
        WitchView(poseB: true)
    }
    .background(Color.black)
}
