//
//  AddView.swift
//  iExpense
//
//  Created by 黄新 on 2025/3/26.
//

import SwiftUI

struct AddView: View {
    var expenses: Expenses
    
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var type = "个人"
    @State private var amount = 0.0

        let types = ["公司", "个人"]

        var body: some View {
            NavigationStack {
                Form {
                    TextField("名称", text: $name)

                    Picker("账单类型", selection: $type) {
                        ForEach(types, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.inline)

                    TextField("总金额", value: $amount, format: .currency(code: "CH-ZN"))
                        .keyboardType(.decimalPad)
                }
                .navigationTitle("添加新的账单")
                .toolbar {
                    Button("保存") {
                        let item = ExpenseItem(name: name, type: type, amount: amount)
                        expenses.items.append(item)
                        dismiss()
                    }
                }
            }
        }
}
