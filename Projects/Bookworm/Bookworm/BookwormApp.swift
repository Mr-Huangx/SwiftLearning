//
//  BookwormApp.swift
//  Bookworm
//
//  Created by 黄新 on 2025/4/4.
//

import SwiftUI
import SwiftData

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
        
    }
}
