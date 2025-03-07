//
//  GameModel.swift
//  swiftLeaningAssignment02
//
//  Created by 黄新 on 2025/2/8.
//

struct GameModel<ContentType> where ContentType : Equatable{
    var cards: [Card]
    
    init(_ number: Int, cardFactory: (Int) -> ContentType){
        cards = []
        for i in 0..<number{
            let content = cardFactory(i)
            cards.append(Card(content: content, id: "\(i)a"))
            cards.append(Card(content: content, id: "\(i)b"))
        }
    }
    
    mutating func shuffle(){
        cards.shuffle()
    }
    
    // 增加一个card
    mutating func addCards(_ content: ContentType, index: Int){
        cards.append(Card(content: content, id: "\(index)a"))
        cards.append(Card(content: content, id: "\(index)b"))
    }
    
    mutating func removeCards(){
        print("remove")
    }
    
    struct Card: Equatable, Identifiable{
        var id: String
        var content: ContentType
        var isFaceUp: Bool
        var isMatched: Bool
        
        static func == (lhs: Card, rhs: Card) -> Bool {
            return lhs.content == rhs.content &&
            lhs.isMatched == rhs.isMatched &&
            lhs.isFaceUp == rhs.isFaceUp
        }
        
        init(content: ContentType, id: String) {
            self.content = content
            self.id = id
            self.isMatched = false
            self.isFaceUp = false
        }
    }
    
    var onlyFaceUpCard: Int? {
        get {
            let faceUpCardIndex = cards.indices.filter{ index in cards[index].isFaceUp }
            return faceUpCardIndex.count == 1 ? faceUpCardIndex.first : nil
        }
        set {
            cards.indices.forEach { index in
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func choose(_ card: Card){
        if let index = cardIndex(of: card){
            if !cards[index].isFaceUp && !cards[index].isMatched{
                if let facedCardIndex = onlyFaceUpCard {
                    if cards[facedCardIndex].content == cards[index].content{
                        cards[index].isMatched = true
                        cards[facedCardIndex].isMatched = true
                    }
                } else {
                    onlyFaceUpCard = index
                }
                cards[index].isFaceUp = true
            }
        }
    }
    
    func cardIndex(of card: Card) -> Int? {
        for index in 0..<cards.count {
            if cards[index].id == card.id{
                return index
            }
        }
        
        return nil
    }
}
