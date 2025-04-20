//
//  ContentView.swift
//  AudioPlayer
//
//  Created by 黄新 on 2025/4/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationStack{
            Spacer()
            NavigationLink("音频播放"){
                AudioPlayerView()
            }
            .navigationBarTitle("目录", displayMode: .inline)
            .toolbar(.hidden)
            
            Spacer()
            NavigationLink("视频播放"){
                VideoPlayerView()
            }
            Spacer()
        }
        
    }
}

#Preview {
    ContentView()
}
