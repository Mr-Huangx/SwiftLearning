//
//  SwiftUIView.swift
//  swiftLeaningAssignment03
//
//  Created by 黄新 on 2025/2/11.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    let items: [Item]
    var aspectRatio: CGFloat = 1
    let content: (Item) -> ItemView
    
    init(_ items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        let spacing = CGFloat(15)
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(
                count: items.count,
                size: geometry.size,
                atAspectRatio: aspectRatio,
                columnSpacing: spacing,
                rowSpacing: spacing
            )
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: spacing)], spacing: spacing) {
                ForEach(items) { item in
                    content(item)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
            
        }
    }
    
    private func gridItemWidthThatFits(
        count: Int,
        size: CGSize,
        atAspectRatio aspectRatio: CGFloat,
        columnSpacing: CGFloat,
        rowSpacing: CGFloat
    ) -> CGFloat {
        let count = CGFloat(count)
        var columnCount = 1.0
        repeat {
            let width = (size.width - ( columnCount - 1) * columnSpacing) / columnCount
            let height = width / aspectRatio
            let rowCount = (count / columnCount).rounded(.up)
            
            if (rowCount * height + (rowCount - 1) * rowSpacing) < size.height {
                return ((size.width - (columnCount - 1) * columnSpacing) / columnCount).rounded(.down)
            }
            columnCount += 1
        } while columnCount < count
        return min(size.width / count, size.height * aspectRatio).rounded(.down)
    }
}
