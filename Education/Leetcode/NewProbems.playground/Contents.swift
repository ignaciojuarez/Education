

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
