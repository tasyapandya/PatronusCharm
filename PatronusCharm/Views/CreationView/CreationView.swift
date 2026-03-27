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
    @State private var noteText: String = ""
    @State private var scribbleColor: Color = .purple
    @State private var showWitchInstruction: Bool = true
    @State private var bubbleText: String = ""
    
    @State private var canvasView = PKCanvasView()
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                // ── Layer 1: Background Dimmed ───────────────────
                Image("newbackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .overlay(Color.black.opacity(0.5))
                
                // ── Layer 2: Book Interface (PNG & Interactive) ──
                ZStack {
                    Image("potionBook")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width * 0.95)
                    
                    // Area Interaktif (Kiri: Scribble, Kanan: Text)
                    HStack(spacing: 0) {
                        // SISI KIRI: Area Scribble (Canvas)
                        ScribbleCanvas(canvasView: $canvasView, selectedColor: $scribbleColor)
                            .frame(width: geo.size.width * 0.25, height: geo.size.height * 0.2)
                            .padding(.leading, 30)
                        
                        // SISI KANAN: Journaling Area
                        VStack(alignment: .leading) {
                            TextEditor(text: $noteText)
                                .scrollContentBackground(.hidden)
                                .background(Color.clear)
                                .font(.custom("Iowan Old Style", size: 14)) // Font serif agar estetik
                                .foregroundColor(Color(red: 0.2, green: 0.15, blue: 0.1))
                                .padding(.top, 130)
                        }
                        .frame(width: geo.size.width * 0.32)
                        .padding(.trailing, 25)
                    }
                }
                .padding(.bottom, 50)

                // ── Layer 3: Witch Instructor (Pose B) ───────────
                VStack {
                    Spacer()
                    HStack {
                        WitchInstructionView(bubbleText: "Draw a potion on the left side, and write your thoughts on the right side."){}
                            .frame(width: 250)
                            .position(
                                x: geo.size.width * 0.15,
                                y: geo.size.height * 0.82
                            )
                        Spacer()
                    }
                }
                
                // ── Layer 4: CTA Button ──────────────────────────
                VStack {
                    Spacer()
                    Button(action: {
                        withAnimation {
                            vm.analyzeText(noteText)
                            vm.currentPhase = .stirring }
                    }) {
                        Text("Create")
                            .font(.headline)
                            .padding(.horizontal, 50)
                            .padding(.vertical, 12)
                            .background(noteText.isEmpty ? Color.gray : Color("#E8B86D"))
                            .foregroundColor(.white)
                            .cornerRadius(25)
                    }
                    .disabled(noteText.isEmpty)
                    .padding(.bottom,20)
                }
            }
        }
    }
}

#Preview {
    ZStack {
        CreationView()
    }
        .environment(RitualViewModel())
}
