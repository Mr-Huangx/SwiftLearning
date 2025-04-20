//
//  ContentView.swift
//  WeSplit
//
//  Created by 黄新 on 2025/3/13.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    let tipPercentages = [10, 15, 20, 25, 0]
    @FocusState private var amountIsFocused: Bool
    
    var totalPerPerson: Double{
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("总金额") {
                    TextField("金额", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }

                Picker("人数", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) 人")
                        }
                    }
                .pickerStyle(.navigationLink)
                
                Section("小费") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("活动收款") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
            }
            .navigationTitle("活动收款")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if amountIsFocused{
                        Button("完成") {
                            amountIsFocused = false
                        }
                    }
                        
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
