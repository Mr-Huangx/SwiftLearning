//
//  ContentView.swift
//  swiftLeaning03
//
//  Created by 黄新 on 2025/2/15.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Pie(endAngle: .degrees(240))
                .foregroundStyle(.blue)
                .modifier(PieDify(isFaceUp: true))
        }
        
        .padding()
    }
}

#Preview {
    ContentView()
}
