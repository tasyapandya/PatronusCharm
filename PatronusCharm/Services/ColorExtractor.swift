//
//  ColorExtractor.swift
//  PatronusCharm
//
//  Created by Tasya Pandya Latifa on 26/03/26.
//

import UIKit
import SwiftUI

struct ColorExtractor {
    
    // Input: UIImage dari PKCanvasView snapshot
    // Output: SwiftUI Color dari dominant color coretan
    static func extract(from image: UIImage) -> Color {
        
        // Resize ke 50x50 dulu
        guard let resized = resize(image, to: CGSize(width: 50, height: 50)),
              let cgImage = resized.cgImage else {
            return Color("#E8B86D") // fallback: amber
        }
        
        let width = cgImage.width
        let height = cgImage.height
        let bytesPerPixel = 4
        var pixelData = [UInt8](repeating: 0, count: width * height * bytesPerPixel)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        guard let context = CGContext(
            data: &pixelData,
            width: width, height: height,
            bitsPerComponent: 8,
            bytesPerRow: width * bytesPerPixel,
            space: colorSpace,
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        ) else { return Color("#E8B86D") }
        
        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        var totalR: Double = 0
        var totalG: Double = 0
        var totalB: Double = 0
        var count: Double = 0
        
        for i in stride(from: 0, to: pixelData.count, by: bytesPerPixel) {
            let r = Double(pixelData[i])
            let g = Double(pixelData[i + 1])
            let b = Double(pixelData[i + 2])
            let a = Double(pixelData[i + 3])
            
            // Skip pixel putih/transparan — hanya hitung warna coretan
            let brightness = (r + g + b) / 3
            guard a > 10, brightness < 230 else { continue }
            
            totalR += r; totalG += g; totalB += b
            count += 1
        }
        
        // Kalau canvas kosong (semua pixel putih/transparan)
        guard count > 0 else { return Color("#E8B86D") }
        
        return Color(
            red: totalR / count / 255,
            green: totalG / count / 255,
            blue: totalB / count / 255
        )
    }
    
    private static func resize(_ image: UIImage, to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        image.draw(in: CGRect(origin: .zero, size: size))
        let resized = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resized
    }
}
