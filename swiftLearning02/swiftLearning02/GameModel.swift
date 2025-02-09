//
//  GameModel.swift
//  swiftLearning02
//
//  Created by 黄新 on 2025/2/7.
//

import Foundation

struct GameModel<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    private var existCardFaceUp: Bool = false
    private var whichOneIsFaceUp: Int = 0
    
    var indexOfTheOneAndFacedUpCard: Int? {
        get {
            let faceUpCardIndices = cards.indices.filter{ index in cards[index].isFaceUp}
            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
        }
        set {
            cards.indices.forEach{ cards[$0].isFaceUp = (newValue == $0) }
        }
    }
    
    init(_ numberOfCards: Int, cardFactory: (Int) -> CardContent) {
        cards = []
        
        for index in 0 ..< max(2, numberOfCards){
            let content = cardFactory(index)
            cards.append(Card(isFaceUp: false, content: content, isMatched: false, id: "\(index)a"))
            cards.append(Card(isFaceUp: false, content: content, isMatched: false, id: "\(index)b"))
        }
    }
    
    mutating func shuffleCards(){
        cards.shuffle()
    }
    
    mutating func choose(_ index: Int){
        cards[index].isFaceUp.toggle()
    }
    
    
    
    mutating func choose(_ card: Card){
        if let index = cardIndex(card){
            if !cards[index].isFaceUp && !cards[index].isMatched{
                if let potentialMatchIndex = indexOfTheOneAndFacedUpCard{
                    if cards[potentialMatchIndex].content == cards[index].content{
                        cards[index].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                } else {
                    indexOfTheOneAndFacedUpCard = index
                }
                cards[index].isFaceUp = true
            }
        }
    }
    
    func cardIndex(_ targetCard: GameModel<CardContent>.Card) -> Int?{
        for index in 0..<cards.count{
            if cards[index].id == targetCard.id{
                return index
            }
        }
        return nil
    }
    
    struct Card: Equatable, Identifiable{
        static func == (lhs: GameModel<CardContent>.Card, rhs: GameModel<CardContent>.Card) -> Bool {
            if lhs.isFaceUp == rhs.isFaceUp && lhs.content == rhs.content && lhs.isMatched && rhs.isMatched{
                return true
            }
            return false
        }
        
        var isFaceUp: Bool
        var content: CardContent
        var isMatched: Bool
        var id: String
    }
}
