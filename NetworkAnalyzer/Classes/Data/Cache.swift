//
//  Cache.swift
//  NetworkAnalyzer
//
//  Created by Dafle on 28/09/21.
//

import Foundation

enum CacheKey: String {
    case networkEvents
}

protocol CacheContract {
    func set<T: Codable>(_ data: T, forKey: CacheKey)
    func get<T: Codable>(forKey: CacheKey) -> T?
    func remove(forKey: CacheKey)
}

class Cache: CacheContract {
    
    static let shared = Cache()

    func set<T: Codable>(_ data: T, forKey: CacheKey) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: forKey.rawValue)
        }
    }

    func get<T: Codable>(forKey: CacheKey) -> T? {
        if let savedData = UserDefaults.standard.object(forKey: forKey.rawValue) as? Data {
            let decoder = JSONDecoder()
            if let item = try? decoder.decode(T.self, from: savedData) {
                return item
            }
        }
        return nil
    }
    
    func remove(forKey: CacheKey) {
        UserDefaults.standard.removeObject(forKey: forKey.rawValue)
    }
}
