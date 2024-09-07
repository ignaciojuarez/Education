

var word = "rar"
var target = 7
var numbersArray = [1,2,3,4,5,6,7,8]

func twoSum(numbers: [Int], target: Int) -> [Int] {
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

//print(twoSum(numbers: numbersArray, target: target))

func isPalindrome(str: String) -> Bool {
    str == reverse(str: word)
}

func reverse(str: String) -> String {
    return String(str.reversed())
}


//print(isPalindrome(str: word))
 
