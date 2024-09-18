import Foundation

// MARK: - Linked List

class Node {
    var val: Int
    var next: Node?
    
    init(_ val: Int, _ next: Node? = nil) {
        self.val = val
        self.next = next
    }
}

class LinkedList {
    var head: Node
    var tail: Node
    
    init() {
        head = Node(-1)
        tail = head
    }

    func addToHead(_ val: Int) {
        let newNode = Node(val)
        newNode.next = head
        head = newNode
    }
    
    func addToTail(_ val: Int) {
        let newNode = Node(val)
        tail.next = newNode
        tail = tail.next!
    }
    
    func printLinkedList(){
        var toPrint: String = ""
        var curr = head
        while curr.next != nil {
            toPrint += "[\(String(curr.val))]"
            curr = curr.next!
        }
        print(toPrint)
    }
}

var myList = LinkedList()
myList.addToHead(10)
myList.addToHead(8)
myList.addToHead(6)
myList.addToHead(7)
myList.printLinkedList()

// MARK: - Reverse Linked List

func reverseList(_ head: Node?) -> Node? {
    var curr = head
    var prev: Node?
    
    while curr != nil {
        let temp = curr!.next
        curr!.next = prev
        prev = curr
        curr = temp
    }
    return prev
}

myList.head = reverseList(myList.head)!
