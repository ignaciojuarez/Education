import UIKit

// MARK: .compactMap{$0} - (array, removes nil)
let nilNumbers: [Int?] = [1,2,nil,3,4,nil,5,6,67,nil,8,9]
let filteredNumbers = nilNumbers.compactMap{$0}

// MARK: .flatMap{$0} - ([[Int]] -> [Int] and removes nil)
let arrayOFArrays: [[Int]] = [[1,2,3], [3,4,5], [6,7,8]]
let singleArray = arrayOFArrays.flatMap{$0}

// MARK: .map - {$0.something or *2}
struct Person {
    let name: String
    let age: Int
}
let people = [
    Person(name: "Alice", age: 24),
    Person(name: "Bob", age: 30),
]
let names = people.map { $0.name }
print(names)  // Output: ["Alice", "Bob"]

// MARK: .filter - {$0 % 2 == 0}
let numbers = [1, 2, 3, 4, 5]
let evenNumbers = numbers.filter { $0 % 2 == 0 }
print(evenNumbers)  // Output: [2, 4]


