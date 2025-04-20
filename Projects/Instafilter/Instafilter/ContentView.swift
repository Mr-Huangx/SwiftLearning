//
//  ContentView.swift
//  Instafilter
//
//  Created by 黄新 on 2025/4/7.
//

import SwiftUI

struct ContentView: View {
    @State private var blurAmount = 0.0

    var body: some View {
        VStack {
            Text("Hello, World!")
                .blur(radius: blurAmount)

            Slider(value: $blurAmount, in: 0...20)

            Button("Random Blur") {
                blurAmount = Double.random(in: 0...20)
            }
        }
    }
}

#Preview {
    ContentView()
}
