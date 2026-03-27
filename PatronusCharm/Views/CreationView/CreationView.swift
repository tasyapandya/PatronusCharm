import SwiftUI

struct CreationView: View {
    @Environment(RitualViewModel.self) private var vm
    
    @State private var scribbleColor: Color = .purple // Default warna chaos
    @State private var noteText: String = ""
    @State private var showInstructions: Bool = true
    
    var body: some View {
        ZStack {
            // ── Layer 1: Background Utama ───────────────────────
            Image("newbackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            // ── Layer 2: Book Interface ──────────────────────────
            VStack(spacing: 20) {
                HStack(alignment: .top, spacing: 0) {
                    
                    // HALAMAN KIRI: Scribble (Bahan)
                    VStack {
                        Text("Ingredient")
                            .font(.custom("Iowan Old Style", size: 24).bold())
                        Text("Pour your chaos here...")
                            .font(.caption)
                            .italic()
                        
                        // Placeholder untuk Canvas Scribble
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white.opacity(0.01)) // Area gambar
                            .overlay(
                                Text("Drawing Canvas Area") // Nanti ganti dengan PencilKit/Canvas
                                    .foregroundColor(.gray)
                            )
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .padding(40)
                    .frame(width: 450) // Sesuaikan dengan lebar halaman buku di asset
                    
                    Divider().frame(height: 400).opacity(0) // Spacer tengah buku
                    
                    // HALAMAN KANAN: Journaling (Resep)
                    VStack {
                        Text("Recipe")
                            .font(.custom("Iowan Old Style", size: 24).bold())
                        Text("Write what weighs on you...")
                            .font(.caption)
                            .italic()
                        
                        TextEditor(text: $noteText)
                            .scrollContentBackground(.hidden)
                            .background(Color.clear)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding(.top, 10)
                    }
                    .padding(40)
                    .frame(width: 450)
                }
                .background(
                    Image("bookOpened") // Asset buku terbuka kamu
                        .resizable()
                        .scaledToFit()
                )
                .frame(height: 500)
                
                // ── Layer 3: CTA Button ──────────────────────────
                Button(action: handleCreate) {
                    Text("Create")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 15)
                        .background(noteText.isEmpty ? Color.gray : Color("#E8B86D"))
                        .cornerRadius(25)
                }
                .disabled(noteText.isEmpty)
            }
            
            // ── Layer 4: Witch Instructor ──────────────────────
            VStack {
                Spacer()
                HStack {
                    // Pakai Pose B sesuai requirement (ada tangan)
                    WitchView(poseB: true) 
                        .frame(width: 200)
                        .offset(x: -50, y: 50)
                    Spacer()
                }
            }
        }
    }
    
    private func handleCreate() {
        // Logic Klasifikasi Sederhana
        let detectedEmotion = analyzeEmotion(text: noteText)
        // Update VM dan pindah phase
        withAnimation {
            vm.currentPhase = .stirring //
        }
    }
    
    private func analyzeEmotion(text: String) -> Emotion {
        let input = text.lowercased()
        if input.contains("angry") || input.contains("mad") { return .anger }
        if input.contains("overwhelmed") || input.contains("tired") { return .overwhelmed }
        return .anxiety // Default
    }
}