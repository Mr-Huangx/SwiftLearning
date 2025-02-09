//
//  ContentView.swift
//  swiftLeaningAssignment02
//
//  Created by 黄新 on 2025/2/8.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        VStack{
            Cards
                .animation(.default, value: viewModel.cards)
        }
        .padding()
        
        Spacer()
        ControlBar
    }
    
    var Cards: some View{
        ScrollView{
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 85))], spacing: 12) {
                ForEach(viewModel.cards){
                    card in
                    VStack{
                        CardView(card: card)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                    
                }
            }
        }
    }
    
    var ControlBar: some View{
        HStack(){
            Spacer()
            SwitchButton
            Spacer()
            ShuffleButton
            Spacer()
            AddButton
            Spacer()
            RemoveButton
            Spacer()
        }
    }
    
    var SwitchButton: some View{
        Button("切换主题"){
            viewModel.switchTheme()
        }
    }
    
    var ShuffleButton: some View{
        Button("打乱顺序"){
            viewModel.shuffle()
        }
    }
    
    var AddButton: some View{
        Button("add cards"){
            viewModel.addCards()
        }
    }
    
    var RemoveButton: some View{
        Button("remove cards"){
            viewModel.removeCards()
        }
    }
    
    init(_ viewModel: GameViewModel) {
        self.viewModel = viewModel
        viewModel.shuffle()
    }
}

struct CardView: View{
    var card: GameModel<String>.Card
    
    var body: some View{
        let base = RoundedRectangle(cornerRadius: 12)
        
        ZStack{
            Group{
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            
            base.fill(.orange).opacity(card.isFaceUp || card.isMatched ? 0 : 1)
        }
        .foregroundStyle(.orange)
        .font(.largeTitle)
        .aspectRatio(2/3, contentMode: .fit)
    }
}

#Preview {
    let viewModel = GameViewModel()
    ContentView(viewModel)
}
