//
//  swiftLeaningAssignment02App.swift
//  swiftLeaningAssignment02
//
//  Created by 黄新 on 2025/2/8.
//

import SwiftUI

@main
struct swiftLeaningAssignment02App: App {
    let viewModel = GameViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel)
        }
    }
}
