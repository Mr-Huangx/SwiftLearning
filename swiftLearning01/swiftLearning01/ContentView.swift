//
//  ContentView.swift
//  swiftLearning01
//
//  Created by 黄新 on 2025/2/5.
//

import SwiftUI

struct ContentView: View {
    let array = ["😀", "😁", "🥹", "😅", "😂", "🤣", "😜"]
    @State var cardCount: Int = 4
    
    var body: some View {
        VStack{
            ScrollView{
                cards()
            }
            Spacer()
            cardAdjusters()
        }
        .padding()
    }
    
    func cards() -> some View{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 60, maximum: 120)), GridItem(), GridItem()]) {
            ForEach(0..<cardCount, id: \.self){
                index in
                Card(content: array[index])
                    .aspectRatio(2/3,contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
        .font(.largeTitle)
    }
    
    func cardAdjusters() -> some View {
        HStack{
            addCardView()
            Spacer()
            removeCardView()
        }
    }
    
    func removeCardView() -> some View {
        Button(action: {
            cardCount -= 1
        }) {
            Image(systemName: "globe")
                .imageScale(.medium)
            Text("remove a card")
        }
        .disabled(cardCount == 1)
    }
    
    func addCardView() -> some View {
        Button(action: {
            cardCount += 1
        }) {
            Image(systemName: "globe")
                .imageScale(.medium)
            Text("add a card")
        }
        .disabled(cardCount >= array.count)
    }
}

struct Card: View{
    let content: String
    @State var isFaceUp: Bool = false
    
    var body: some View{
        let base = RoundedRectangle(cornerRadius: 12)
        ZStack{
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content)
            }
            
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
            print("toggled isFaceUp is :\(isFaceUp)")
        }
    }
}

#Preview {
    ContentView()
}
