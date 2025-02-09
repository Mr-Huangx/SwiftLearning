//
//  EmojiMemoryGameViewModel.swift
//  swiftLearning02
//
//  Created by 黄新 on 2025/2/7.
//

import Foundation

class EmojiMemoryGameViewModel: ObservableObject{
    @Published var model: GameModel<String>
    
    var cards:[GameModel<String>.Card]{
        model.cards
    }
    
    static var emojis = ["😀", "😁", "🥹", "😅", "😂", "🤣", "😜",
                         "🥰", "😘", "😗", "😋", "😛", "😜", "🤪",
                         "🤓"]
    
    init(_ numberOfCards: Int) {
        // 创建游戏需要的数据
        model = GameModel<String>(numberOfCards, cardFactory: {
            (index: Int) -> String in
            if EmojiMemoryGameViewModel.emojis.indices.contains(index){
                return EmojiMemoryGameViewModel.emojis[index]
            } else {
                return "❗️"
            }
        })
        
        // 打乱顺序
        shuffle()
    }
    
    func shuffle(){
        model.shuffleCards()
    }
    
    func choose(_ index: Int){
        model.choose(index)
    }
    
    func choose(_ card: GameModel<String>.Card){
        model.choose(card)
    }
}
