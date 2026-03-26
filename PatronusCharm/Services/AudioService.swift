//
//  AudioService.swift
//  PatronusCharm
//
//  Created by Tasya Pandya Latifa on 23/03/26.
//

import Foundation
import AVFoundation
import UIKit

@Observable
class AudioService {
    static let shared = AudioService()
    
    private var bgmPlayer: AVAudioPlayer?
    private var sfxPlayer: AVAudioPlayer?
    
    // Func for BGM dengan fitur looping
    func playBGM(named name: String, volume: Float = 0.5) {
        guard let asset = NSDataAsset(name: name) else {
            print("Audio BGM '\(name)' tidak ditemukan di Assets")
            return
        }
        
        do {
            bgmPlayer = try AVAudioPlayer(data: asset.data)
            bgmPlayer?.numberOfLoops = -1 // looping selamanya
            bgmPlayer?.volume = volume
            bgmPlayer?.prepareToPlay()
            bgmPlayer?.play()
            print("🎵 Memutar BGM: \(name)")
        } catch {
            print("Gagal memutar BGM: \(error.localizedDescription)")
        }
    }
    
    func stopBGM() {
        bgmPlayer?.stop()
    }
    
    // Func for SFX (sekali putar)
    func playSFX(named name: String) {
        guard let asset = NSDataAsset(name: name) else { return }
        do {
            sfxPlayer = try AVAudioPlayer(data: asset.data)
            sfxPlayer?.play()
        } catch {
            print("Gagal memutar SFX: \(error.localizedDescription)")
        }
    }
}
