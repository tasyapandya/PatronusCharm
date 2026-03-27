//
//  CreationView.swift
//  PatronusCharm
//
//  Created by Tasya Pandya Latifa on 26/03/26.
//

import SwiftUI
import PencilKit

struct CreationView: View {
    @Environment(RitualViewModel.self) private var vm
    
    // States
    @State private var noteText: String = ""
    @State private var canvasView = PKCanvasView()
    @State private var isDrawingActive: Bool = false // Kontrol kapan toolbar muncul
    @State private var showWitchInstruction: Bool = true // Kontrol overlay instruksi
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                // ── Layer 1: Background ───────────────────
                Image("newbackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .overlay(Color.black.opacity(0.4))
                
                // ── Layer 2: Book Interface ──
                ZStack {
                    Image("potionBook")
                        .resizable()
                        .scaledToFit()
                        // Mengisi hampir seluruh lebar layar agar lega
                        .frame(width: geo.size.width * 0.99)
                    
                    HStack(spacing: 0) {
                        // SISI KIRI: Scribble Area
                        VStack {
                            ScribbleCanvas(canvasView: $canvasView)
                                .frame(width: geo.size.width * 0.40, height: geo.size.height * 0.30)
                                .cornerRadius(15)
                                // Canvas hanya bisa disentuh jika instruksi sudah hilang
                                .disabled(showWitchInstruction)
                        }
                        .frame(width: geo.size.width * 0.50)
                        
                        Spacer().frame(width: geo.size.width * 0.02)
                        
                        // SISI KANAN: Journaling Area
                        VStack {
                            TextEditor(text: $noteText)
                                .scrollContentBackground(.hidden)
                                .background(Color.clear)
                                .font(.custom("Iowan Old Style", size: 18))
                                .foregroundColor(Color(red: 0.2, green: 0.15, blue: 0.1))
                                .padding(.top, geo.size.height * 0.50) // Dinamis sesuai layar
                                .padding(.bottom, 60)
                                .disabled(showWitchInstruction)
                        }
                        .frame(width: geo.size.width * 0.38)
                        .padding(.trailing, 40)
                    }
                }
                
                // ── Layer 3: CTA Button (POJOK KANAN) ──────
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: { processAndStartStirring() }) {
                            HStack {
                                Text("Create")
                                Image(systemName: "sparkles")
                            }
                            .font(.headline)
                            .padding(.horizontal, 40)
                            .padding(.vertical, 14)
                            .background(noteText.isEmpty ? Color.gray : Color("#572985"))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 4)
                        }
                        .disabled(noteText.isEmpty || showWitchInstruction)
                        .padding(.trailing, 50)
                        .padding(.bottom, 40)
                    }
                }

                // ── Layer 4: Initial Instruction Overlay ──
                if showWitchInstruction {
                    ZStack {
                        // 1. Background gelap yang sekarang BISA DI-TAP
                        Color.black.opacity(0.6)
                            .ignoresSafeArea()
                            .onTapGesture {
                                dismissInstruction()
                            }
                        
                        // 2. Kucing + Bubble
                        WitchInstructionView(bubbleText: "Draw your magic on the left, and pour your thoughts on the right.\n\n(Tap to begin)") {
                            dismissInstruction()
                        }
                        .frame(width: 350)
                        // Kita tambah tap gesture di sini juga buat jaga-jaga
                        .onTapGesture {
                            dismissInstruction()
                        }
                    }
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                    .zIndex(10) // Pastikan dia berada di urutan paling atas (Z-index tertinggi)
                }
            }
        }
    }
    
    private func processAndStartStirring() {
        let drawingImage = canvasView.drawing.image(from: canvasView.bounds, scale: 1.0)
        let extractedColor = ColorExtractor.extract(from: drawingImage)
        
        withAnimation(.easeInOut(duration: 0.6)) {
            vm.scribbleDominantColor = extractedColor
            vm.analyzeText(noteText)
            vm.currentPhase = .stirring
        }
    }
    
    private func dismissInstruction() {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
            showWitchInstruction = false
            // Toolbar PencilKit muncul saat keyboard/focus aktif
            canvasView.becomeFirstResponder()
        }
    }
}

#Preview {
    CreationView()
        .environment(RitualViewModel())
}
