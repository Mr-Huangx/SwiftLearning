//
//  Animination.swift
//  swiftLeaning03
//
//  Created by 黄新 on 2025/2/20.
//

import SwiftUI

struct Animination: View {
    @State private var offsetX: CGFloat = 150
    var body: some View {
        VStack {
            VStack {
                Text(".default（默认）")
                Rectangle()
                    .frame(width: 30, height: 30)
                    .offset(x: offsetX)
                    .foregroundColor(Color.pink)
                    /* 如果是`nil`就是无动画 */
//                    .animation(.default, value: offsetX)
                
                Text(".linear（匀速）")
                Rectangle()
                    .frame(width: 30, height: 30)
                    .offset(x: offsetX)
                    .foregroundColor(Color.pink)
//                    .animation(.linear, value: offsetX)
                
                Text(".easeIn（开头缓慢，逐渐加速）")
                Rectangle()
                    .frame(width: 30, height: 30)
                    .offset(x: offsetX)
                    .foregroundColor(Color.pink)
//                    .animation(.easeIn, value: offsetX)
                
                Text(".easeOut（结尾逐渐减速，缓慢结束）")
                Rectangle()
                    .frame(width: 30, height: 30)
                    .offset(x: offsetX)
                    .foregroundColor(Color.pink)
//                    .animation(.easeOut, value: offsetX)
                
                Text(".easeInOut（缓出缓进，上面的融合体）")
                Rectangle()
                    .frame(width: 30, height: 30)
                    .offset(x: offsetX)
                    .foregroundColor(Color.pink)
//                    .animation(.easeInOut, value: offsetX)
            }
            
            Button(action: {
                withAnimation {
                    offsetX = -150
                }
            }, label: {
                Text("开始运动")
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(lineWidth: 3)
                    )
            })
            
            Button(action: {
                withAnimation(.linear(duration: 2)) {
                    offsetX = 150
                }
            }, label: {
                Text("重置")
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(lineWidth: 3)
                    )
            })
        }
    }
}

#Preview {
    Animination()
}
