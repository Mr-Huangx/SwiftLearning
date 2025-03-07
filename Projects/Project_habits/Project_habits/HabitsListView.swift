//
//  HabitsListView.swift
//  Project_habits
//
//  Created by 黄新 on 2025/3/4.
//

import SwiftUI

struct HabitsListView: View {
    @ObservedObject var habit: Habit
    @State var sheetVisible : Bool = false
    @State private var isNavigating = true // 新增按钮的现实状态
    
    var body: some View {
        ZStack{
            HabitListView(habit: habit, isNavigating: $isNavigating)
            AddButtonView(){
                self.sheetVisible = true
            }
            .offset(x: UIScreen.main.bounds.width / 2 - 60, y : UIScreen.main.bounds.height / 2 - 100)
            .opacity(isNavigating ? 1 : 0)
        }
        .sheet(isPresented: $sheetVisible) {
            // 如果点击的是添加按钮
            AddHabitView(onDissmiss: {
                self.sheetVisible = false
            }, onSumit: {
                habitItem in
                self.habit.addItem(habitItem)
                self.sheetVisible = false
            })
        }
    }
    
    init(habit: Habit) {
        self.habit = habit
    }
    
    init(){
        habit = Habit()
        
        let array = ["起床", "阅读", "书写", "工作", "娱乐", "运动", "冥想"]
        for index in array.indices{
            habit.addItem(name: array[index], iconName: IconNameArray[index], theme: UserColorArray[index])
        }
    }
}

struct HabitListView: View{
    @ObservedObject var habit : Habit
    @Binding var isNavigating: Bool
    @State private var navigationPath: [HabitItem] = []
    
    var body: some View{
        NavigationStack(path: $navigationPath){
            ScrollView{
                ForEach(habit.habits){
                    habit in
                    NavigationLink(value: habit){
                        HabitView(habit)
                    }
                    .padding(.vertical, 5)
                }
            }
            .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
            .navigationDestination(for: HabitItem.self) { habitItem in
                if let index = habit.habits.firstIndex(where: { $0.id == habitItem.id }){
                    HabitDetailView(habit: $habit.habits[index]){
                        targetHabit in
                        habit.habits.removeAll(where: {
                            $0.id == targetHabit.id
                        })
                    }
                }
                
            }
            .onChange(of: navigationPath, { oldValue, newValue in
                isNavigating = navigationPath.isEmpty
            })
            .navigationTitle("本周概况")
        }
        
        
    }
}

struct HabitDetailView: View{
    @Binding var habit: HabitItem
    
    var onDelete: (HabitItem) -> Void
    
    @Environment(\.dismiss) var dismiss
    
    static let DAYS: [String] = [
        "周一",
        "周二",
        "周三",
        "周四",
        "周五",
        "周六",
        "周日"
    ]
    
    var body: some View{
        VStack(alignment: .leading, spacing: 20){
            HStack{
                Image(systemName: habit.iconName)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.blue)
                
                Text(habit.name)
                
                Spacer()
            }
            .padding(.bottom, 20)
            
            Text("完成统计")
                .font(.title)
                .bold()
            
            ForEach(HabitDetailView.DAYS.indices){
                index in
                let day = HabitDetailView.DAYS[index]

                Toggle(isOn: self.$habit.checkList[index]) {
                    Text(day)
                }
            }
            
            Spacer()
            
            VStack(alignment: .center){
                Button{
                    onDelete(habit)
                    dismiss()
                } label: {
                    Text("删除")
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
                .padding()
                .foregroundStyle(.white)
                .background(.red)
                .cornerRadius(10)
                
            }
        }
        .padding(20)
        
    }
    
}

struct HabitView: View{
    var habit: HabitItem
    
    var body: some View{
        Group{
            HStack{
                Rectangle()
                    .fill(habit.theme)
                    .frame(width: 10)
                
                Image(systemName: habit.iconName)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(habit.theme)
                    .padding(.trailing, 10)
                
                Text(habit.name)
                    .font(Font.system(size: 20))
                    .foregroundStyle(.black)
                
                Spacer(minLength: 10)
                
                completeDay
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
            .frame(height: 85)
            .background(Color(red: 241 / 255, green: 243 / 255, blue: 246 / 255))
            .cornerRadius(10)
        }
    }
    
    var completeDay: some View{
        HStack(spacing: 5){
            ForEach(0..<7) {
                index in
                Image(systemName: habit.checkList[index] ? "checkmark.circle" : "circle")
                    .resizable()
                    .frame(width: 18, height: 18, alignment: .center)
                    .foregroundStyle(habit.theme)
            }
        }
    }
    
    init(_ habit: HabitItem) {
        self.habit = habit
    }
    
    init(){
        habit = HabitItem()
    }
}

struct AddButtonView: View{
    var onPressedAddButton: () -> Void
    
    var body: some View{
        Button {
            onPressedAddButton()
        } label: {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundStyle(.blue)
        }
    }
}

struct AddHabitView: View{
    @State private var newItemTitle: String = ""
    
    @State var selectedColorIndex : Int = 0
    @State var selectIconIndex : Int = 0
    
    var onDissmiss: () -> Void
    var onSumit: (HabitItem) -> Void
    
    var body: some View{
        VStack{
            HStack {
                Button(
                    action: {
                        self.onDissmiss()
                    }) {
                        Text(
                            "取消"
                        )
                    }.padding(
                        20
                    )
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 20){
                Text("习惯名称").font(.system(size: 28))
                
                TextField("习惯名称", text: self.$newItemTitle){
                    print(self.newItemTitle)
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 30)
                
                Text("图标").font(.system(size: 28))
                
                HStack(spacing: 10){
                    ForEach(0 ..< IconNameArray.count){
                        index in
                        Button (action:{
                            self.selectIconIndex = index
                        }){
                            Image(systemName: IconNameArray[index])
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(3)
                                .foregroundColor(index == self.selectIconIndex ? .orange : .blue)
                        }
                    }
                }
                .padding(.bottom, 30)
                
                Text("主题色").font(.system(size: 28))
                
                HStack(spacing: 4) {
                    ForEach(0 ..< UserColorArray.count){
                        index in
                        Button(action:{
                            self.selectedColorIndex = index
                        }) {
                            ZStack{
                                Image(systemName: "circle.fill")
                                    .resizable()
                                    .frame(width: 36, height: 36)
                                    .foregroundStyle(self.selectedColorIndex == index ? .orange : .white)
                                
                                Image(systemName: "circle.fill")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(UserColorArray[index])
                            }
                        }
                    }
                }
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
            
            
            Spacer()
            
            VStack{
                Button {
                    if !newItemTitle.isEmpty {
                        let iconNAme = IconNameArray[selectIconIndex]
                        let theme = UserColorArray[selectedColorIndex]
                        let habitItem = HabitItem(name: newItemTitle, iconName: iconNAme, theme: theme)
                        self.onSumit(habitItem)
                        print("完成新增")
                    }
                } label: {
                    Text("新增")
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
                .accentColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
            }
            .padding(.leading, 20).padding(.trailing, 20)
            
        }
        .onAppear(){
            print("current UI size: \(UIScreen.main.bounds.width)")
        }
    }
}

#Preview {
    HabitsListView()
}
