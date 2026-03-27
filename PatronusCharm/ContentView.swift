//
//  ContentView.swift
//  PatronusCharm
//
//  Created by Tasya Pandya Latifa on 23/03/26.
//

import SwiftUI

struct ContentView: View {
    @State private var vm = RitualViewModel()
    
    var body: some View {
        ZStack {
            switch vm.currentPhase {
            case .idle:
                IdleView()
                    .transition(.opacity)
            
            // Placeholder untuk page berikutnya — isi nanti
            case .inputText, .scribbling:
                CreationView()
                    .transition(.opacity)
            
            case .stirring:
                StirringView()
                    .transition(.opacity)
                    
            case .conjuring, .showWoA, .releasing, .closure:
                ResultView()
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.4), value: vm.currentPhase)
        .environment(vm) // inject ke semua child view
    }
}

#Preview {
    ContentView()
}
