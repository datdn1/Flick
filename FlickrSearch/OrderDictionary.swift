//
//  OrderDictionary.swift
//  FlickrSearch
//
//  Created by datdn1 on 12/7/15.
//  Copyright © 2015 Razeware. All rights reserved.
//

import Foundation

struct OrderedDictionary<KeyType: Hashable, ValueType> {
    
    typealias ArrayType = [KeyType]
    typealias DictionaryType = [KeyType: ValueType]
    
    var array = ArrayType()
    var dictionary = DictionaryType()
    
    // mutating can change variable of struct
    mutating func insert(value: ValueType, forKey key:KeyType, atIndex index:Int) -> ValueType? {
        var adjustedIndex = index
        
        let existingValue = self.dictionary[key]
        if existingValue != nil {
            let existingIndex = self.array.indexOf({ (keyElement: KeyType) -> Bool in
                return keyElement == key
            })
            if existingIndex < index {
                adjustedIndex--
            }
            
            self.array.removeAtIndex(existingIndex!)
        }
        self.array.insert(key, atIndex: adjustedIndex)
        self.dictionary[key] = value
        return existingValue
    }
    
    mutating func removeAtIndex(index: Int) -> (KeyType, ValueType) {
        precondition(index < self.array.count, "Index out-of-bound")
        
        let key = self.array.removeAtIndex(index)
        let value = self.dictionary.removeValueForKey(key)!
        return (key, value)
    }
    
    var count:Int {
        return self.array.count
    }
    
    subscript(key: KeyType) -> ValueType? {
        get {
            return self.dictionary[key]
        }
        set {
            if let _ = self.array.indexOf(key) {
                
            }
            else {
                self.array.append(key)
            }
            self.dictionary[key] = newValue
        }
    }
    
    subscript(index: Int) -> (KeyType, ValueType) {
        get {
            precondition(index < self.array.count, "Index out-of-bound")
            let key = self.array[index]
            let value = self.dictionary[key]!
            return (key, value)
        }
        set {
            precondition(index < self.array.count, "Index out-of-bound")
            let (key, value) = newValue
            self.array[index] = key
            self.dictionary[key] = value
        }
    }
}