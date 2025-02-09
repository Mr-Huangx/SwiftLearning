//
//  GameModelView.swift
//  swiftLeaningAssignment02
//
//  Created by 黄新 on 2025/2/8.
//

import Foundation

class GameViewModel: ObservableObject{
    @Published var model: GameModel<String>
    
    static let emojis = [
        ["😀", "😁", "😂", "🤣", "😃", "😄", "😅", "😆", "😉", "😊", "😋", "😎"],
        ["🥰", "😍", "🤩", "😘", "😗", "😚", "😙", "🥲", "🙂", "🤗", "🤭", "🥳"],
        ["😜", "😝", "😛", "🤑", "🤔", "🤨", "😐", "😑", "😶", "🙄", "😏", "😒"],
        ["🙃", "🫠", "🥺", "😢", "😭", "😤", "😠", "😡", "🤬", "🤯", "😳", "🥵"],
        ["🥶", "😱", "😨", "😰", "😥", "😓", "🤒", "🤕", "🤢", "🤮", "🤧", "😷"],
        ["👻", "💀", "☠️", "👽", "👾", "🤖", "🎃", "😺", "😸", "😹", "😻", "😼"]
    ]
    
    // 默认初始主题
    static var currentTheme: Int = 0
    
    init() {
        self.model = GameModel(10, cardFactory: GameViewModel.cardFactory)
    }
    
    var cards: [GameModel<String>.Card] { model.cards }
    
    static func cardFactory(index: Int) -> String{
        let themeId = GameViewModel.currentTheme
        
        if GameViewModel.emojis[themeId].indices.contains(index){
            return GameViewModel.emojis[themeId][index]
        } else {
            return "!"
        }
    }
    
    // 切换主题
    func changeTheme(){
        GameViewModel.currentTheme = (GameViewModel.currentTheme + 1) % 6
    }
    
    // 切换主题
    func switchTheme(){
        GameViewModel.currentTheme = (GameViewModel.currentTheme + 1) % 6
        
        self.model = GameModel(10, cardFactory: GameViewModel.cardFactory)
        print("切换主题成功，themeID: (\(GameViewModel.currentTheme))")
        
        // 将顺序打乱
        shuffle()
    }
    
    // 将内容进行刷新
    func shuffle(){
        model.shuffle()
    }
    
    // 增加一个emoji card
    func addCards(){
        let themeId = GameViewModel.currentTheme
        let addIndex = model.cards.count / 2
        var content = "!"
        if GameViewModel.emojis[themeId].indices.contains(addIndex){
            content = GameViewModel.emojis[themeId][addIndex]
        }
        model.addCards(content, index: addIndex)
    }
    
    //移除一个emoji card
    func removeCards(){
        model.removeCards()
    }
    
    // 选择对应的card进行反面
    func choose(_ card: GameModel<String>.Card){
        model.choose(card)
    }
}
