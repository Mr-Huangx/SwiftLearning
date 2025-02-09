//
//  ContentView.swift
//  swiftLearning02
//
//  Created by 黄新 on 2025/2/7.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGameViewModel
    
    var body: some View {
        VStack(spacing: 12) {
            ScrollView{
                cards()
                    .animation(.default, value: viewModel.cards)
            }
            Button("shuffle"){
                viewModel.shuffle()
            }
        }
        .padding()
    }
    
    func cards() -> some View{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85))], spacing: 12) {
            ForEach(viewModel.cards){
                card in
                VStack(spacing: 0){
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                    Text(card.id)
                }
                
            }
        }
        .foregroundColor(.orange)
    }
    
    init(_ viewModel: EmojiMemoryGameViewModel) {
        self.viewModel = viewModel
    }
}

struct CardView: View{
    var card: GameModel<String>.Card
    
    var body: some View{
        let base = RoundedRectangle(cornerRadius: 12)
        ZStack{
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
            }
            .opacity(card.isFaceUp ? 0 : 1)
            base.fill().opacity(card.isFaceUp ? 1 : 0)
        }
    }
}

#Preview {
    var viewModel = EmojiMemoryGameViewModel(12)
    ContentView(viewModel)
}
