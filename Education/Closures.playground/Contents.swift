import UIKit



// -----------------------------------

struct Student {
    var name: String
    var score: Int
}

var students: [Student] = []

var topStudentFilter: (Student) -> (Bool) = { student in
    return student.score > 80
}

var topStudents = students.filter { $0.score > 80 }
var topSortedStudents = topStudents.sorted { $0.score < $1.score }

// -----------------------------------
// when using 'in' in closures, the value is saved
// without 'in' = Juarez

var name = "Ignacio"

let closure = { [name] in
    print(name)
}

name = "Juarez"

closure()

// -----------------------------------

func execute() -> (Int) -> Int {
    var input = 0
    
    return { output in
        input = input + output
        return input
    }
}

let op = execute()
let a = op(5)
let b = op(10)
let c = op(15) // ans = 30

// -----------------------------------

let multiply: (Int, Int) -> Int = {
    $0 * $1
}

// -----------------------------------

func filterArray(_ array: [Int], condition: ((Int) -> Bool)) -> [Int] {
    var filteredArray = [Int]()
    
    for value in array {
        if condition(value) {
            filteredArray.append(value)
        }
    }
    return filteredArray
}

var arr: [Int] = [1,2,3,4,5,6,88]
arr = filterArray(arr){ $0 > 5 }
print(arr)

// -----------------------------------

func createTheClosureTimer(start: Int) -> (() -> Int) {
    var currentCount = start
    
    let closure: () -> Int = {
        if currentCount > 0 {currentCount -= 1}
        return currentCount
    }
    return closure
}
// Create a countdown from 5
let timerClosure = createTheClosureTimer(start: 5)

print(timerClosure())  // 4
print(timerClosure())  // 3
print(timerClosure())  // 2
