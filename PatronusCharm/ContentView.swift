//
//  ContentView.swift
//  PatronusCharm
//
//  Created by Tasya Pandya Latifa on 23/03/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Image("newbackground")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
        }
    }
}


#Preview {
    ContentView()
}

