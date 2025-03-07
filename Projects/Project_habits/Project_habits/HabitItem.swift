//
//  HabitItem.swift
//  Project_habits
//
//  Created by 黄新 on 2025/3/4.
//

import Foundation
import SwiftUI

//闭包函数，持有UUid值，然后实现不断自增
func _generateUUId() -> () -> Int{
    var id = 0
    
    return {
        id += 1
        return id
    }
}

//闭包函数，持有id，实现不断自增
func _generateId() -> () -> Int{
    var id = 0
    
    return {
        id += 1
        return id
    }
}
let generateId = _generateId()
let generateUUId = _generateUUId()

public struct HabitItem: Identifiable, Hashable{
    public var id: Int = 0
    var name: String = ""
    var iconName: String = IconNameArray[0]
    var theme: Color = UserColorArray[0]
    var uuid: Int = 0
    var checkList: [Bool] = [false, false, false, false, false, false, false]
    
    init(){
        
    }
    
    init(name: String, iconName: String ,theme: Color) {
        self.id = generateId()
        self.name = name
        self.iconName = iconName
        self.theme = theme
        self.uuid = generateUUId()
    }
}


// iconName的默认值集合
public let IconNameArray: [String] = [
    "alarm",
    "book",
    "pencil",
    "desktopcomputer",
    "gamecontroller",
    "sportscourt",
    "lightbulb"
]

//UserColorArray的默认集合
public let UserColorArray = [
  Color(red:75 / 255, green:166 / 255, blue: 239 / 255),
  Color(red:161 / 255, green:206 / 255, blue: 97 / 255),
  Color(red:248 / 255, green:214 / 255, blue: 80 / 255),
  Color(red:243 / 255, green:176 / 255, blue: 74 / 255),
  Color(red:238 / 255, green:140 / 255, blue: 111 / 255),
  Color(red:237 / 255, green:113 / 255, blue: 165 / 255),
  Color(red:207 / 255, green:102 / 255, blue: 247 / 255),
  Color(red:77 / 255, green:110 / 255, blue: 247 / 255),
  Color(red:236 / 255, green:107 / 255, blue: 102 / 255)
]
