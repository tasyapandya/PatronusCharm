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
    @Binding var selectedColor: Color

    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.drawingPolicy = .anyInput // Bisa pakai jari atau Apple Pencil
        canvasView.backgroundColor = .clear
        canvasView.isOpaque = false
        
        // Setting alat tulis default (Inking Tool)
        updateTool()
        
        return canvasView
    }

    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        updateTool()
    }
    
    private func updateTool() {
        // Mengubah warna pen berdasarkan state selectedColor
        let uiColor = UIColor(selectedColor)
        canvasView.tool = PKInkingTool(.pen, color: uiColor, width: 5)
    }
}
