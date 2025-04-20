//
//  AudioPlayerView.swift
//  AudioPlayer
//
//  Created by 黄新 on 2025/4/20.
//

import SwiftUI
import AVFoundation

struct AudioPlayerView: View {
    @StateObject private var audioManager = AudioManager()

    var body: some View {
        VStack(spacing: 20) {
            Text("MP3 播放器")
                .font(.title)
                .padding()

            Button(action: {
                audioManager.togglePlayback()
            }) {
                Image(systemName: audioManager.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.blue)
            }

            Slider(value: $audioManager.progress, in: 0...1)
                .accentColor(.blue)
        }
        .padding()
        .onAppear {
            // 加载 MP3 文件路径，这里使用本地文件
            audioManager.loadAudio(fileName: "music", fileType: "mp3")
        }
        .onDisappear {
            audioManager.stop()
        }
    }
}

class AudioManager: ObservableObject {
    private var player: AVAudioPlayer?
    private var timer: Timer?

    @Published var isPlaying = false
    @Published var progress: Double = 0.0

    func loadAudio(fileName: String, fileType: String) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileType) else {
            print("找不到音频文件")
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
        } catch {
            print("音频播放出错：\(error.localizedDescription)")
        }
    }

    func togglePlayback() {
        guard let player = player else { return }

        if player.isPlaying {
            player.pause()
            stopTimer()
        } else {
            player.play()
            startTimer()
        }

        isPlaying = player.isPlaying
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            if let player = self.player {
                self.progress = player.currentTime / player.duration
            }
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func stop() {
        player?.stop()
        isPlaying = false
        stopTimer()
    }
}

#Preview {
    AudioPlayerView()
}
