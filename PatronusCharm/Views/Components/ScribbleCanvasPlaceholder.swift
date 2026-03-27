import SwiftUI

struct ScribbleCanvasPlaceholder: View {
    @Binding var selectedColor: Color
    
    var body: some View {
        ZStack {
            // Area Canvas Transparan
            Canvas { context, size in
                // Nanti logika drawing coretan ditaruh di sini
            }
            .background(Color.black.opacity(0.001)) // Agar tetap bisa di-tap meski kosong
            
            // Label bantuan jika user belum mulai mencoret
            Text("Tap to draw...")
                .font(.caption)
                .foregroundColor(.gray.opacity(0.5))
        }
        .onAppear {
            // Contoh logic: Set warna default untuk stirring nanti
            selectedColor = Color.purple 
        }
    }
}