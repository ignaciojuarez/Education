
// -----------------------------------------

func ThreeLargestNumbers(arr: [Int]) -> [Int] {
    guard !arr.isEmpty else { return []}
    var ans = Array(repeating: -1, count: 3)
    
    for n in arr {
        var indexToInsert = -1
        
        if n > ans[2] {
            indexToInsert = 2
        }
        else if n > ans[1] {
            indexToInsert = 1
        }
        else if n > ans[0] {
            indexToInsert = 0
        }
        else { continue }

        // [3,8,9] <- 9
        var current = indexToInsert
        while current > 0 {
            let temp = ans[current - 1]
            ans[current - 1] = ans[indexToInsert]
            current -= 1
            ans[indexToInsert] = temp
        }
        ans[indexToInsert] = n
    }
    
    return ans
}

let ans = ThreeLargestNumbers(arr: [4,23,1,6,2,8,2])
print(ans)

// -----------------------------------------

// given an N * M, return all elements of the matrix in spiral order

// input: [[1,2,3], [4,5,6], [7,8,9]]
// output: [1,2,3,6,9,8,7,4,5]

let matrix = [[1,2,3], [4,5,6], [7,8,9]]
print(spriralMatrix(matrix: matrix))

func spriralMatrix(matrix: [[Int]]) -> [Int] {
    var ans: [Int] = []
    let totalItems = matrix.count * matrix[0].count
    
    var left = 0
    var right = matrix[0].count - 1
    var top = 0
    var bottom = matrix.count - 1
    
    while ans.count < totalItems {
        // left to right
        for col in stride(from: left, through: right, by: 1) {
            ans.append(matrix[top][col])
        }
        top += 1
        
        // (top right) to (bottom right)
        for row in stride(from: top, through: bottom, by: 1) {
            ans.append(matrix[row][right])
        }
        right -= 1
        
        // (bottom right) to (bottom left)
        for col in stride(from: right, through: left, by: -1) {
            ans.append(matrix[bottom][col])
        }
        bottom -= 1
        
        // (bottom left) to (top left)
        for row in stride(from: bottom, through: top, by: -1) {
            ans.append(matrix[row][left])
        }
        left += 1
    }
    return ans
}

func canPlaceFlowers(_ flowerbed: [Int], _ n: Int) -> Bool {
    var flowerbed = flowerbed
    var placed = 0
    
    for (idx, plot) in flowerbed.enumerated() where plot != 1 {
        let prevIdx = (idx - 1)
        let nextIdx = (idx + 1)
        if prevIdx >= 0, flowerbed[prevIdx] != 0 { continue }
        if nextIdx < flowerbed.count, flowerbed[nextIdx] != 0 { continue }
        flowerbed[idx] = 1
        placed += 1
    }
    return placed >= n
}

func wordPattern(_ pattern: String, _ s: String) -> Bool {
    var map: [Character: String] = [:] //a:dog
    var words = s.split(separator: " ")
    var wordsSet = Set(words)
    var patternArr = Array(pattern)
    var patternIndex = 0
    
    guard patternArr.count == words.count else {return false}
    
    for word in words {
        if map[patternArr[patternIndex]] != String(word) && map[patternArr[patternIndex]] != nil {
            return false
        }
        else if map[patternArr[patternIndex]] == nil {
            map[patternArr[patternIndex]] = String(word)
        }
        patternIndex += 1
    }
    return map.values.count == wordsSet.count
}
