//
//  Habit.swift
//  Project_habits
//
//  Created by 黄新 on 2025/3/4.
//

import Foundation
import SwiftUI

class Habit: ObservableObject {
    @Published var habits: [HabitItem]
    
    init(habits: [HabitItem]) {
        self.habits = habits
    }
    
    init(){
        habits = []
    }
    
    func addItem(name: String, iconName: String ,theme: Color){
        habits.append(HabitItem(
            name: name,
            iconName: iconName,
            theme: theme
        ))
    }
    
    func addItem(_ item: HabitItem){
        habits.append(item)
    }
    
    
}
