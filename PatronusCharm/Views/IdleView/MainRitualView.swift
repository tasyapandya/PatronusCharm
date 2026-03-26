struct MainRitualView: View {
    var body: some View {
        ZStack {
            // Background Landscape (SVG)
            Image("background_landscape")
                .resizable()
                .ignoresSafeArea()
            
            HStack(spacing: 50) { // Berikan jarak antara penyihir dan kuali
                // Penyihir yang Beranimasi (Frame-by-frame)
                WitchAnimateView()
                
                // Kuali Polos (PNG) + Particle Effect (SpriteKit)
                PotionCauldronView() 
            }
            .padding() // Agar tidak terlalu mentok ke pinggir layar landscape
        }
    }
}