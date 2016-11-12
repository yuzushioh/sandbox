//
//  UserDefaultsManager.swift
//  YourName
//
//  Created by yuzushioh on 11/8/16.
//  Copyright © 2016 yuzushioh. All rights reserved.
//

import Foundation

class UserDefaultsManager {
    static let userDefaults = UserDefaults.standard
    
    static func get(diaryOf day: Int) -> String? {
        return userDefaults.string(forKey: "diary\(day)")
    }
    
    static func get(titleOf day: Int) -> String? {
        return userDefaults.string(forKey: "title\(day)")
    }
    
    static func add(diary: String, forDay day: Int) {
        userDefaults.setValue(diary, forKey: "diary\(day)")
    }
    
    static func add(title: String, forDay day: Int) {
        userDefaults.setValue(title, forKey: "title\(day)")
    }
}
