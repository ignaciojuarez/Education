//
//  Testing.swift
//  Education
//
//  Created by Ignacio Juarez on 9/5/24.
//

import Foundation

public struct Testing {
    //var target = 7
    //var numbersArray = [1,2,3,4,5,6,7,8]
    
    public func twoSum(numbers: [Int], target: Int) -> [Int] {
        var dict: [Int:Int] = [:] // [lookingValue:index of the one looking]
        // [6:0]
        for (index, val) in numbers.enumerated() {
            
            if let lookingIndex = dict[val] {
                return [index, lookingIndex]
            }
            
            dict[target - val] = index
        }
        
        return []
    }
}

