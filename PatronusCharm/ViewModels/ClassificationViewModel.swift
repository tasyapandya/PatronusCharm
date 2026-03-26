//
//  ClassificationViewModel.swift
//  PatronusCharm
//
//  Created by Tasya Pandya Latifa on 23/03/26.
//

import SwiftUI

class ClassificationViewModel {
    
    private let keywords: [Emotion: [String]] = [
        .anger: [
            "angry", "anger", "mad", "rage", "furious", "frustrated",
            "irritated", "annoyed", "hate", "explode", "fire", "livid",
            "outraged", "bitter", "resentful"
        ],
        .overwhelmed: [
            "overwhelmed", "too much", "exhausted", "tired", "heavy",
            "burden", "cant cope", "can't cope", "drowning", "swamped",
            "stressed", "pressure", "suffocating", "helpless", "lost"
        ],
        .anxiety: [
            "anxious", "anxiety", "worried", "worry", "scared", "panic",
            "nervous", "uncertain", "fear", "dread", "restless", "chaotic",
            "overthinking", "uneasy", "tense"
        ]
    ]
    
    // Fungsi utama dipanggil dari RitualViewModel
    func classifyEmotion(from text: String) -> Emotion {
        let lowercased = text.lowercased()
        
        // Hitung berapa keyword yang cocok per emosi
        var scores: [Emotion: Int] = [.anger: 0, .overwhelmed: 0, .anxiety: 0]
        
        for (emotion, words) in keywords {
            for word in words {
                if lowercased.contains(word) {
                    scores[emotion, default: 0] += 1
                }
            }
        }
        
        // Ambil emosi dengan score tertinggi
        // Kalau semua 0 (tidak ada keyword cocok) → return .unknown → Phoenix
        guard let best = scores.max(by: { $0.value < $1.value }),
              best.value > 0 else {
            return .unknown
        }
        
        return best.key
    }
}
