//
//  ContentView.swift
//  iExpense
//
//  Created by 黄新 on 2025/3/25.
//

import SwiftUI

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items, id: \.id) { item in
                    HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }

                            Spacer()
                            Text(item.amount, format: .currency(code: "CH-ZN"))
                        }
                }
                .onDelete { index in
                    expenses.items.remove(atOffsets: index)
                }
            }
            .navigationTitle("账单")
            .toolbar {
                Button("添加", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            // show an AddView here
            AddView(expenses: expenses)
        }
    }
        
    
}

@Observable
class Expenses {
    var items = [ExpenseItem](){
        didSet{
            if let encoded = try? JSONEncoder().encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init(){
        if let data = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: data){
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}

struct ExpenseItem: Identifiable, Codable{
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}


#Preview {
    ContentView()
}
