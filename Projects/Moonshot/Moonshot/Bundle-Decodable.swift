//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by 黄新 on 2025/3/27.
//

import Foundation

extension Bundle{
    func decode<T: Codable>(_ file: String) -> T{
        
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("在bundle中加载\(file)出错")
        }
        
        guard let data = try? Data(contentsOf: url) else{
            fatalError("从bundle中加载数据出错")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' – \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON.")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}
