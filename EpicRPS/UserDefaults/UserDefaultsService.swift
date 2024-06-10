//
//  UserDefaultsService.swift
//

import Foundation

final class UserDefaultsService {
    
    static let shared = UserDefaultsService()
    
    private init() {}
    
    private let defaults = UserDefaults.standard
    
    func saveStructs<T: Codable>(structs: T, forKey key: String) {
        if let encoded = try? JSONEncoder().encode(structs) {
            defaults.set(encoded, forKey: key)
        }
    }

    func getStructs<T: Codable>(forKey key: String) -> T? {
        if let saveData = defaults.data(forKey: key) {
            if let decoded = try? JSONDecoder().decode(T.self, from: saveData) {
                return decoded
            }
        }
        return nil
    }
    
    func removeData(forKey key: String) {
        defaults.removeObject(forKey: key)
    }
}

