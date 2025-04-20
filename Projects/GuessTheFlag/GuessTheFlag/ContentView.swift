//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by 黄新 on 2025/3/19.
//

import SwiftUI

struct ContentView: View {

    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.5),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            
            VStack{
                Spacer()
                
                Text("请猜测国旗")
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(.white)
                
                Spacer()
                
                VStack(spacing: 15){
                    VStack{
                        Text("请选择以下国家的国旗")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                            
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }

                    
                    ForEach(0..<3) { number in
                        Button{
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                        .alert(scoreTitle, isPresented: $showingScore) {
                            Button("继续游戏"){
                                askQuestion()
                            }
                        } message: {
                            if scoreTitle == "回答正确" {
                                Text("得分加1")
                            } else {
                                Text("得分减1")
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                
                Text("最终得分: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            
        }
        
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "回答正确"
            score += 1
        } else {
            scoreTitle = "回答错误"
            score -= 1
        }

        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
