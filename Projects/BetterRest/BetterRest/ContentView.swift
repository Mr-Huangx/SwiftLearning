//
//  ContentView.swift
//  BetterRest
//
//  Created by 黄新 on 2025/3/21.
//

import SwiftUI
import CoreML

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        
        NavigationStack {
            Form {
                VStack(alignment: .leading, spacing: 0) {
                    Text("请问您想起床时间?")
                        .font(.headline)

                    DatePicker("起床时间", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .padding()
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("预期睡眠时长")
                        .font(.headline)

                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                        .padding()
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("每天喝多少杯咖啡")
                        .font(.headline)

                    Stepper("\(coffeeAmount) cup(s)", value: $coffeeAmount, in: 1...20)
                        .padding()
                }
                
                
                
                
            }
            .navigationTitle("最佳睡眠时间")
            .toolbar{
                Button("计算最佳睡眠时间", action: calculateBedtime)
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("完成") { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    func exampleDates() {
        let tomorrow = Date.now.addingTimeInterval(86400)
        let range = Date.now...tomorrow
    }
    
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
        
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            
            showingAlert = true
            
            alertTitle = "你理想的睡眠时间是…"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            // something went wrong!
            
            alertTitle = "错误"
            alertMessage = "对不起，在计算您的睡眠时间时出现错误."
        }
    }
    
    static var defaultWakeTime: Date{
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
}

#Preview {
    ContentView()
}
