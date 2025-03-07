//
//  CardView.swift
//  swiftLeaning03
//
//  Created by 黄新 on 2025/2/15.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct CardPreview: PreviewProvider {
    static var previews: some View{
        HStack{
            CardView()
            CardView()
        }
    }
}
