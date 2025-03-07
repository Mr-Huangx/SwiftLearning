//
//  GameModel.swift
//  swiftLeaningAssignment03
//
//  Created by 黄新 on 2025/2/11.
//

import Foundation

struct GameModel<CardContentType: Equatable>{
    private(set) var cards: [Card]
    private(set) var cardFactory: (Int) -> CardContentType?
    private var totalCardsIndex: Int
    init(numberOfEmojis: Int, cardFactory: @escaping (Int) -> CardContentType?){
        self.cards = []
        self.totalCardsIndex = 0
        self.cardFactory = cardFactory
        
        for index in 0..<numberOfEmojis{
            if let content = cardFactory(index){
                self.cards.append(Card(isChoosed: false, content: content, isMatch: false, id: "\(index)a"))
                self.cards.append(Card(isChoosed: false, content: content, isMatch: false, id: "\(index)b"))
                self.cards.append(Card(isChoosed: false, content: content, isMatch: false, id: "\(index)c"))
                self.totalCardsIndex += 3
            }
        }
        
    }
    
    mutating func choose(_ card: Card){
        matchGame()
        if let index = cardIndex(card){
            cards[index].isChoosed.toggle()
        }
    }
    
    mutating func matchGame(){
        let choosedIndex = cards.indices.filter{
            index in
            return cards[index].isChoosed
        }
        
        if choosedIndex.count == 3{
            let cardOne = choosedIndex[0]
            let cardTwo = choosedIndex[1]
            let cardThree = choosedIndex[2]
            if (cards[cardOne].content == cards[cardTwo].content) && (cards[cardOne].content == cards[cardThree].content){
                cards.remove(at: cardThree)
                cards.remove(at: cardTwo)
                cards.remove(at: cardOne)
            }
            
            // 将所有的选择清空
            cards.indices.forEach { index in
                cards[index].isChoosed = false
            }
        }
    }
    
    mutating func dealCards(){
        // 处理卡片按钮
        let choosedIndex = cards.indices.filter{
            index in
            return cards[index].isChoosed
        }
        
        var flag = false
        if choosedIndex.count == 3{
            let cardOne = choosedIndex[0]
            let cardTwo = choosedIndex[1]
            let cardThree = choosedIndex[2]
            if (cards[cardOne].content == cards[cardTwo].content) && (cards[cardOne].content == cards[cardThree].content){
                cards.remove(at: cardThree)
                cards.remove(at: cardTwo)
                cards.remove(at: cardOne)
                flag = true
            }
            // 将所有的选择清空
            cards.indices.forEach { index in
                cards[index].isChoosed = false
            }
        }
        
        if !flag {
            // 将所有的选择清空
            cards.indices.forEach { index in
                cards[index].isChoosed = false
            }
            
            // 同时增加三张图片
            let index = self.totalCardsIndex / 3
            print("index : \(index)")
            if let content = cardFactory(index){
                self.cards.append(Card(isChoosed: false, content: content, isMatch: false, id: "\(index)a"))
                self.cards.append(Card(isChoosed: false, content: content, isMatch: false, id: "\(index)b"))
                self.cards.append(Card(isChoosed: false, content: content, isMatch: false, id: "\(index)c"))
                self.totalCardsIndex += 3
                print("增加三张图片")
            }
            
        }
    }
    
    
    func cardIndex(_ card: Card) -> Int?{
        for i in 0..<cards.count{
            if card.id == cards[i].id{
                return i
            }
        }
        return nil
    }
    
    struct Card: Identifiable{
        var isChoosed: Bool
        var content: CardContentType
        var isMatch: Bool
        var id: String
    }
}
