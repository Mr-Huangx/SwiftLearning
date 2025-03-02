//
//  FlyCard.swift
//  swiftLeaning03
//
//  Created by 黄新 on 2025/2/21.
//

import SwiftUI

struct FlyCard: View {
    let number: Int
    
    @State private var offset: CGFloat = 0
    
    
    var body: some View {
        if number != 0{
            Text(number, format: .number.sign(strategy: .always()))
                .font(.largeTitle)
                .shadow(color: .black, radius: 1.5, x: 1, y: 1)
                .offset(x: 0, y: offset)
                .opacity(offset != 0 ? 0 : 1)
                .onAppear(){
                    withAnimation {
                        offset = number < 0 ? 200 : -200
                    }

                }
                .onDisappear(){
                    offset = 0
                }
        }
    }
}

#Preview {
    FlyCard(number: 2)
}
