//
//  ScribbleCanvasPlaceholder.swift
//  PatronusCharm
//
//  Created by Tasya Pandya Latifa on 26/03/26.
//

import SwiftUI
import PencilKit

struct ScribbleCanvas: UIViewRepresentable {
    @Binding var canvasView: PKCanvasView
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.drawingPolicy = .anyInput
        canvasView.backgroundColor = .clear
        canvasView.isOpaque = false
        
        // Warna default awal
        canvasView.tool = PKInkingTool(.pen, color: .systemPurple, width: 5)
        
        // Setup observer menggunakan toolPicker yang ada di coordinator
        context.coordinator.toolPicker.addObserver(canvasView)
        
        canvasView.delegate = context.coordinator
        
        DispatchQueue.main.async {
            context.coordinator.setupToolPicker(for: canvasView)
        }
        
        return canvasView
    }

    func updateUIView(_ uiView: PKCanvasView, context: Context) {}

    // Fungsi pembersih yang sekarang menggunakan instance toolPicker dari coordinator
    static func dismantleUIView(_ uiView: PKCanvasView, coordinator: Coordinator) {
        uiView.resignFirstResponder()
        
        // Sembunyikan dan hapus observer menggunakan instance yang sama
        coordinator.toolPicker.setVisible(false, forFirstResponder: uiView)
        coordinator.toolPicker.removeObserver(uiView)
        
        // Hapus delegate saat view dibongkar
        uiView.delegate = nil
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    // 👇 TAMBAHKAN PKCanvasViewDelegate DI SINI 👇
    class Coordinator: NSObject, PKCanvasViewDelegate {
        // Instance toolPicker sekarang "hidup" di dalam Coordinator
        let toolPicker = PKToolPicker()
        
        func setupToolPicker(for canvasView: PKCanvasView) {
            // Kita coba ambil window dari canvasView langsung
            if canvasView.window != nil {
                toolPicker.setVisible(true, forFirstResponder: canvasView)
                toolPicker.addObserver(canvasView)
                canvasView.becomeFirstResponder()
            } else if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                      let _ = windowScene.windows.first {
                // Fallback
                toolPicker.setVisible(true, forFirstResponder: canvasView)
                toolPicker.addObserver(canvasView)
                canvasView.becomeFirstResponder()
            }
        }
        
        // FUNGSI UNTUK MEMUTAR SFX & HAPTIC SAAT MULAI MENGGAMBAR
        func canvasViewDidBeginUsingTool(_ canvasView: PKCanvasView) {
            AudioService.shared.playSFX(named: "scribbleSfx")
            HapticService.shared.startChaosFeedback() // 📳 Mulai kresek-kresek
        }
                
        // FUNGSI UNTUK MENGHENTIKAN SFX & HAPTIC SAAT JARI/PENCIL DIANGKAT
        func canvasViewDidEndUsingTool(_ canvasView: PKCanvasView) {
            AudioService.shared.stopSFX()
            HapticService.shared.stopChaosFeedback() // 📳 Berhenti getar
        }
    }
}
