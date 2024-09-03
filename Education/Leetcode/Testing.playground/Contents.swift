

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


func getThreeBiggest(arr: [Int]) -> [Int] {
    guard !arr.isEmpty else { return []}
    var ans = Array(repeating: -1, count: 3)
    
    for n in arr {
        if n > ans[2] {
            let big = ans[2]
            let mid = ans[1]
            ans[2] = n
            ans[1] = big
            ans[0] = mid
        }
        else if n > ans[1] {
            let mid = ans[1]
            ans[1] = n
            
        }
        else if n > ans[1] {
            ans[0] = n
        }
    }
    
    return ans
}

let ans = getThreeBiggest(arr: [4,23,1,6,2,8,2])
print(ans)
 
