import UIKit
import Foundation

//let parts = String.split(separator: ":")

struct Stack<E> {
    
    private var array: [E] = []
    
    mutating func add(_ val: E) {
        self.array.append(val)
    }
    
    mutating func pop() -> E? {
        guard !self.array.isEmpty else {return nil}
        
        return self.array.removeLast()
    }
    
    mutating func peak() -> E? {
        guard !self.array.isEmpty else {return nil}
        
        return self.array.last!
    }
    
    mutating func printMe() {
        print(self.array)
    }
}

var myStack = Stack<Int>()
myStack.add(1)
myStack.add(2)
print(myStack.peak())
myStack.printMe()
myStack.pop()
myStack.printMe()
