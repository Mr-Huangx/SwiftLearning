//
//  ContentView.swift
//  WordScramble
//
//  Created by 黄新 on 2025/3/23.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationStack{
            List{
                Section{
                    TextField("enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                        .onSubmit {
                            addNewWord()
                        }
                        .onAppear(perform: startGame)
                        .alert(errorTitle, isPresented: $showingError) {
                            Button("OK") { }
                        } message: {
                            Text(errorMessage)
                        }
                }
                
                Section("已使用过的单词"){
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                                Image(systemName: "\(word.count).circle")
                                Text(word)
                            }
                    }
                }
            }
            .navigationTitle(rootWord)
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "已经存在该单词", message: "请重新填写")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "单词错误", message: "你不可能通过'\(rootWord)'填写出您的单词!")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "无法识别", message: "不存在该单词!")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        
        newWord = ""
        
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startWordsURL){
                let allWords = startWords.components(separatedBy: "\n")
                
                rootWord = allWords.randomElement() ?? "silkworm"
                
                return
            }
        }
        
        fatalError("无法加载start.txt文件")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool{
        var temp = rootWord
        
        for letter in word{
            if let pos = temp.firstIndex(of: letter){
                temp.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String){
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

#Preview {
    ContentView()
}
