//
//  VideoPlayerView.swift
//  AudioPlayer
//
//  Created by 黄新 on 2025/4/20.
//

import SwiftUI
import AVKit




struct VideoPlayerView: View {
    // 本地视频（放到 app bundle）或远程视频 URL 都支持
    private let player = AVPlayer(url: URL(string: "https://www.w3schools.com/html/mov_bbb.mp4")!)
    
    var body: some View {
        VideoPlayer(player: player)
            .onAppear {
                player.play()
            }
            .onDisappear {
                player.pause()
            }
            .ignoresSafeArea() // 如果你想全屏
    }
}

#Preview {
    VideoPlayerView()
}
