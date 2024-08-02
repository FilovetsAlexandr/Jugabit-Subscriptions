//
//  FileManagerHelper.swift
//  Jugabit-Subscriptions
//
//  Created by Alexandr Filovets on 1.08.24.
//

import Foundation

struct FileManagerHelper {
    static let fileName = "subscriptions.json"
    
    static func saveSubscriptions(_ subscriptions: [Subscription]) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(subscriptions) {
            let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
            try? data.write(to: fileURL)
        }
    }
    
    static func loadSubscriptions() -> [Subscription] {
        let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
        if let data = try? Data(contentsOf: fileURL) {
            let decoder = JSONDecoder()
            if let subscriptions = try? decoder.decode([Subscription].self, from: data) {
                return subscriptions
            }
        }
        return []
    }
    
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

