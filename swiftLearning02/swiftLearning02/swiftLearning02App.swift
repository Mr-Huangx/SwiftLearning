//
//  swiftLearning02App.swift
//  swiftLearning02
//
//  Created by 黄新 on 2025/2/7.
//

import SwiftUI

@main
struct swiftLearning02App: App {
    var viewModel = EmojiMemoryGameViewModel(4)
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel)
        }
    }
}
