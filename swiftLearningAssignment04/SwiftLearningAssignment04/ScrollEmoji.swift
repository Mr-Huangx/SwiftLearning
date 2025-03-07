//
//  ScrollEmoji.swift
//  Emoji_ArtApp
//
//  Created by 黄新 on 2025/3/2.
//

import Foundation

class ScrollEmoji: ObservableObject{
    @Published private var emojiModel: ScrollEmojiModal
    
    var emojis: String {
        emojiModel.emojis
    }
    
    init(){
        emojiModel = ScrollEmojiModal(emojis: "👻🍎😃🤪☹️🤯🐶🐭🦁🐵🦆🐝🐢🐄🐖🌲🌴🌵🍄🌞🌎🔥🌈🌧️🌨️☁️⛄️⛳️🚗🚙🚓🚲🛺🏍️🚘✈️🛩️🚀🚁🏰🏠❤️💤⛵️")
    }
    
    func removeEmoji(_ emoji: String){
        emojiModel.removeEmoji(emoji)
        
    }
}

struct ScrollEmojiModal{
    private(set) var emojis: String
    
    init(emojis: String) {
        self.emojis = emojis
    }
    
    mutating func removeEmoji(_ emoji: String){
        emojis = emojis.replacingOccurrences(of: emoji, with: "")
    }
}
