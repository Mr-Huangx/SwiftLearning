//
//  DragDrop.swift
//  Emoji_ArtApp
//
//  Created by 黄新 on 2025/2/26.
//

import SwiftUI

struct DragDrop: View {
    let name = "huangxin"
    @State var url: URL?
    var body: some View {
        AsyncImage(url: url)
            .id(url?.absoluteString ?? UUID().uuidString)
            .dropDestination(for: URL.self){
                urls, location in
                return drop(urls)
            }
        
        Text(name)
            .contentShape(.dragPreview, RoundedRectangle(cornerRadius: 7))
            .draggable(name) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 300, height: 300)
                        .foregroundStyle(.yellow.gradient)
                    Text("Drop \(name)")
                        .font(.title)
                        .foregroundStyle(.red)
                }
            }
        Button("打印url"){
            if let currentUrl = url{
                if let queryItems = URLComponents(url: currentUrl, resolvingAgainstBaseURL: true)?.queryItems {
                    for queryItem in queryItems {
                        print("queryItem : \(queryItem) \n")
                        if let value = queryItem.value, value.hasPrefix("http"), let imgurl = URL(string: value) {
                            print(imgurl)
                        }
                    }
                }

                
            } else{
                print("当前url为空")
            }
        }
    }
    
    func drop(_ urls: [URL] ) -> Bool{
        if let url = urls.first{
            print("\(url)")
//            if let imageData = url.dataSchemeImageData {
//                print("设置url失败")
//            } else {
//                self.url = (url.imageURL)
//            }
            self.url = url
            return true
        }
        return false
        
    }
}

#Preview {
    DragDrop()
}
