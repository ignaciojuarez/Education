import UIKit


// compactMap. filter nil
let nilNumbers: [Int?] = [1,2,nil,3,4,nil,5,6,67,nil,8,9]
let filteredNumbers = nilNumbers.compactMap{$0}

// .flatMap Make aeeays into one
let arrayOFArrays: [[Int]] = [[1,2,3], [3,4,5], [6,7,8]]
let singleArray = arrayOFArrays.flatMap{$0}

