//
//  WitchAnimateView.swift
//  PatronusCharm
//
//  Created by Tasya Pandya Latifa on 26/03/26.
//


import SwiftUI
internal import Combine

struct WitchAnimateView: View {
    // Variabel untuk menyimpan pose mana yang aktif (true = Pose A, false = Pose B)
    @State private var isPoseAActive = true
    
    // Timer untuk mengubah pose secara otomatis setiap 0.5 detik
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    // Nama aset gambar berdasarkan posisi yang aktif
    private var witchImageName: String {
        isPoseAActive ? "witch_pose_a" : "witch_pose_b"
    }

    var body: some View {
        VStack {
            // Tampilkan gambar penyihir dengan nama yang dinamis
            Image(witchImageName)
                .resizable()
                .scaledToFit()
                .frame(height: 250)
                .transition(.opacity) // Opsional: tambahkan transisi halus saat pindah frame
                .animation(.easeInOut(duration: 0.1), value: isPoseAActive) // Opsional: durasi transisi
            
            // Tangkap sinyal timer dan ubah state pose
            .onReceive(timer) { _ in
                isPoseAActive.toggle() // Mengubah true jadi false, dan sebaliknya
            }
        }
    }
}
