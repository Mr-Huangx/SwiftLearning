//
//  File.swift
//  swiftLeaning03
//
//  Created by 黄新 on 2025/2/17.
//

import SwiftUI
import CoreGraphics


struct Pie: Shape{
    var startAngle: Angle = .zero
    let endAngle: Angle
    let clockwise: Bool = true
    
    func path(in rect: CGRect) -> Path {
        let startAngle = self.startAngle - .degrees(90)
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(
            x: center.x + radius * (cos(startAngle.radians)),
            y: center.y + radius * (sin(startAngle.radians))
        )
        
        var p = Path()
        
        p.move(to: center)
        p.addLine(to: start)
        
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: !clockwise
        )
        
        p.addLine(to: center)
        
        return p
    }
}

struct PieDify: ViewModifier{
    var isFaceUp: Bool
    func body(content: Content) -> some View {
        ZStack{
            if isFaceUp{
                content.overlay {
                    Text("🤖")
                }
            } else{
                content.overlay {
                    Text("👾")
                }
            }
        }
    }
}
