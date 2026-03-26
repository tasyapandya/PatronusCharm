//
//  WitchAnimateView.swift
//  PatronusCharm
//
//  Created by Tasya Pandya Latifa on 26/03/26.
//


import SwiftUI

struct WitchAnimateView: View {
    // 1. Variabel untuk menyimpan pose mana yang aktif (true = Pose A, false = Pose B)
    @State private var isPoseAActive = true
    
    // 2. Buat Timer untuk mengubah pose secara otomatis setiap 0.5 detik
    // (Kamu bisa atur angkanya agar lebih lambat/cepat)
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    // Tentukan nama aset gambar berdasarkan posisi yang aktif
    private var witchImageName: String {
        isPoseAActive ? "witch_pose_a" : "witch_pose_b"
    }

    var body: some View {
        VStack {
            // 3. Tampilkan gambar penyihir dengan nama yang dinamis
            Image(witchImageName)
                .resizable()
                .scaledToFit()
                .frame(height: 250) // Sesuaikan ukuran penyihir di layar
                .transition(.opacity) // Opsional: tambahkan transisi halus saat pindah frame
                .animation(.easeInOut(duration: 0.1), value: isPoseAActive) // Opsional: durasi transisi
            
            // 4. Tangkap sinyal timer dan ubah state pose
            .onReceive(timer) { _ in
                isPoseAActive.toggle() // Mengubah true jadi false, dan sebaliknya
            }
        }
    }
}