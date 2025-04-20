//
//  ContentView.swift
//  Bookworm
//
//  Created by 黄新 on 2025/4/4.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""

    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Book.title, order: .reverse) var books: [Book]

    @State private var showingAddScreen = false
    
    var body: some View{
        NavigationStack{
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)

                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .navigationDestination(for: Book.self) { book in
                        DetailView(book: book)
                    }
                }
                .onDelete(perform: deleteBooks)
                
            }
            .toolbar {
                Button("Add") {
                    let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                    let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]

                    let chosenFirstName = firstNames.randomElement()!
                    let chosenLastName = lastNames.randomElement()!

                    // more code to come
                    let student = Student(id: UUID(), name: "\(chosenFirstName) \(chosenLastName)")
                    
                    modelContext.insert(student)

                }
            }
            
        }
        
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            // find this book in our query
            let book = books[offset]
            
            // delete it from the context
            modelContext.delete(book)
        }
    }
}



#Preview {
    ContentView()
}
