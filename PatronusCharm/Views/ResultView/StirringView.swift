struct StirringView: View {
    @State private var progress: Double = 0.0
    @State private var spoonPosition: CGPoint = .zero
    
    var body: some View {
        VStack {
            // 1. Loading Bar (Native SwiftUI)
            ZStack(alignment: .leading) {
                Capsule().fill(.gray.opacity(0.3)).frame(height: 8)
                Capsule().fill(.yellow).frame(width: 300 * progress, height: 8)
                    .shadow(color: .yellow, radius: 4)
            }
            .frame(width: 300)
            .padding(.top, 50)
            
            Spacer()
            
            // 2. Cauldron Sandwich
            ZStack {
                // Layer Paling Belakang
                Image("cauldron_back")
                
                // Cairan
                Circle()
                    .fill(progress < 1.0 ? Color.purple : Color.cyan.opacity(0.5))
                    .frame(width: 200)
                    .blur(radius: 10)
                
                // Sendok (Spoon)
                Image("spoon")
                    .position(spoonPosition)
                    .gesture(
                        DragGesture().onChanged { value in
                            spoonPosition = value.location
                            updateStirringProgress(value: value)
                        }
                    )
                
                // Layer Paling Depan (Bibir Kuali)
                Image("cauldron_front_rim")
                    .allowsHitTesting(false) // Supaya tidak menghalangi gesture jari ke sendok
            }
            
            Spacer()
        }
    }
    
    private func updateStirringProgress(value: DragGesture.Value) {
        // Logika untuk menambah progress jika gerakan melingkar terdeteksi
        // Gunakan haptic feedback di sini
        if progress < 1.0 {
            progress += 0.005 
            // Trigger Haptic: UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        }
    }
}