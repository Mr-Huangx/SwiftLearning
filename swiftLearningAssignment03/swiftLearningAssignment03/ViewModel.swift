//
//  File.swift
//  swiftLeaningAssignment03
//
//  Created by 黄新 on 2025/2/11.
//

import Foundation

class ViewModel: ObservableObject{
    @Published var model: GameModel<String>
    
    var cards: [GameModel<String>.Card]{
        model.cards
    }
    
    static var emojis = [
        "😀", "😁", "🥹", "😅", "😂", "🤣", "😜",
        "🥰", "😘", "😗", "😋", "😛", "😜", "🤪",
        "🤓", "👻", "💀", "☠️", "👽", "👾", "🤖",
        "🎃", "😺", "😸", "😹", "😻", "😼", "🥵",
        "🥶", "😱", "😨", "😰", "😥", "😓", "🤒",
        "🤕", "🤢", "🤮", "🤧", "😷", "🤯", "😳",
        "🙃", "🫠", "🥺", "😢", "😭", "😤", "😠"
    ]
    
    init(){
        self.model = GameModel<String>(numberOfEmojis: 0){
            index -> String? in
            if ViewModel.emojis.indices.contains(index) {
                return ViewModel.emojis[index]
            } else  {
                return nil
            }
        }
    }
    
    init(numberOfEmojis: Int) {
        self.model = GameModel<String>(numberOfEmojis: numberOfEmojis){
            index -> String? in
            if ViewModel.emojis.indices.contains(index) {
                return ViewModel.emojis[index]
            } else  {
                return nil
            }
        }
    }
    
    func choose(_ card: GameModel<String>.Card){
        model.choose(card)
    }
    
    func dealCards(){
        model.dealCards()
    }
    
    func newGame(){
        self.model = GameModel<String>(numberOfEmojis: 20){
            index -> String? in
            if ViewModel.emojis.indices.contains(index) {
                return ViewModel.emojis[index]
            } else  {
                return nil
            }
        }
    }
    
}
