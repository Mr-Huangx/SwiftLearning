//
//  Emoji_ArtAppApp.swift
//  Emoji_ArtApp
//
//  Created by 黄新 on 2025/2/22.
//

import SwiftUI

@main
struct Emoji_ArtAppApp: App {
    @StateObject var defaultDocument = EmojiArtDocument()
    @StateObject var defaultScrollEmojis = ScrollEmoji()
    
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: defaultDocument, scrollEmoji: defaultScrollEmojis)
        }
    }
}
