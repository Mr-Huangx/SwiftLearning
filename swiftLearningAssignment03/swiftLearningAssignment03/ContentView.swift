//
//  ContentView.swift
//  swiftLeaningAssignment03
//
//  Created by 黄新 on 2025/2/11.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel = ViewModel(numberOfEmojis: 20)
    
    var body: some View {
        VStack{
            aspectVGrid()
            
            Spacer()
            controlBar
                .frame(height: 40)
        }
        .padding()
    }
    
    @ViewBuilder
    var cards: some View{
        ForEach (viewModel.cards) {
            card in
            CardView(card: card)
        }
    }
    
    var controlBar: some View{
        HStack{
            Button("deal cards"){
                viewModel.dealCards()
            }
            
            Spacer()
            
            Button("newe Game"){
                viewModel.newGame()
            }
        }
    }
    
    func aspectVGrid() -> some View{
        AspectVGrid(viewModel.cards, aspectRatio: 2/3){
            card in
            CardView(card: card)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
    }
}


struct CardView: View{
    var card: GameModel<String>.Card
    
    var body: some View{
        let base = RoundedRectangle(cornerRadius: 12)
        ZStack{
            base.stroke(lineWidth: 4)
            Text(card.content)
                .scaleEffect(1.5)
        }
        .foregroundStyle(card.isChoosed ? .blue : .black)
//        .opacity(card.isMatch ? 0 : 1)
    }
}

#Preview {
    ContentView()
}
