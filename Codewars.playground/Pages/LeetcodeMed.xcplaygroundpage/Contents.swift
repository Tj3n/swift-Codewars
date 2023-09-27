 
import Foundation

// https://leetcode.com/problems/group-anagrams/
func groupAnagrams(_ strs: [String]) -> [[String]] {
    
    // 1 liner
    return Array(strs.reduce(into: [String: [String]]()) { partialResult, s in
        let ss = String(s.sorted())
        partialResult[ss] = (partialResult[ss] ?? []) + [s]
    }.values)
    
    // use sorted string to compare for anagrams
//    var ret = [String: [String]]()
//    
//    for s in strs {
//        let ss = String(s.sorted())
//        ret[ss] = (ret[ss] ?? []) + [s]
//    }
//    return Array(ret.values)
}

groupAnagrams(["eat","tea","tan","ate","nat","bat"]) //[["bat"],["nat","tan"],["ate","eat","tea"]]

// https://leetcode.com/problems/set-matrix-zeroes/
func setZeroes(_ matrix: inout [[Int]]) {
    // o(m+n)? : save the row/col of every cell needs to change by go it's whole row/col then replace them with 0
    let rows = matrix.count
    let cols = matrix.first!.count
    var toUpdates = [(Int, Int)]()
    
    for i in 0..<rows {
        for j in 0..<cols {
            if matrix[i][j] == 0 {
                for m in 0..<rows where m != i {
                    if matrix[m][j] != 0 {
                        toUpdates.append((m, j))
                    }
                }
                for n in 0..<cols where n != j {
                    if matrix[i][n] != 0 {
                        toUpdates.append((i, n))
                    }
                }
            }
        }
    }
    
    toUpdates.forEach({
        matrix[$0.0][$0.1] = 0
    })
}

// [[0,0,0,0],[0,4,5,0],[0,3,1,0]]
var matrix = [[0,1,2,0],[3,4,5,2],[1,3,1,5]]
setZeroes(&matrix)
print(matrix)

// https://leetcode.com/problems/rotate-image/
func rotate(_ matrix: inout [[Int]]) {
    let n = matrix.count
    
    // https://assets.leetcode.com/users/images/9f7d86fb-cde6-4760-8088-b683bb52160f_1597580296.4229963.png
    
    // Transpose: flip x & y axis
    for i in 0..<n {
        for j in i..<n {
            let prev = matrix[i][j]
            let next = matrix[j][i]
            matrix[i][j] = next
            matrix[j][i] = prev
            print(i, j, "=", j, i, "=", prev, next)
        }
    }
    print("==" , matrix)
    
    // Reverse the col
    for i in 0..<n {
        matrix[i] = matrix[i].reversed()
    }
}

//var matrix = [[1,2,3],[4,5,6],[7,8,9]] // [[7,4,1],[8,5,2],[9,6,3]]
//var matrix = [[5,1,9,11],[2,4,8,10],[13,3,6,7],[15,14,12,16]] // [[15,13,2,5],[14,3,4,1],[12,6,8,9],[16,7,10,11]]
//rotate(&matrix)
//print(matrix)

// https://leetcode.com/problems/spiral-matrix/
func spiralOrder(_ matrix: [[Int]]) -> [Int] {
    // O(n)
    let col = matrix.first!.count
    let row = matrix.count
    let total = row*col
    
    var count = 0
    
    var startRow = 0
    var startCol = 0
    
    var endRow = row-1
    var endCol = col-1
    
    var ret = [Int]()

    // goes right down left up, update start/end after each loop
    while count < total {
        print(startRow, startCol, endRow, endCol)
        print("===")
        for i in startCol...endCol {
            print(startRow, i)
            ret.append(matrix[startRow][i])
            count += 1
            if count == total {
                return ret
            }
        }
        startRow += 1
        print("==", count, startRow, endRow)
        
        for i in startRow...endRow {
            print(i, endCol)
            ret.append(matrix[i][endCol])
            count += 1
            if count == total {
                return ret
            }
        }
        endCol -= 1
        print("==")
        for i in (startCol...endCol).reversed() {
            print(endRow, i)
            ret.append(matrix[endRow][i])
            count += 1
            if count == total {
                return ret
            }
        }
        endRow -= 1
        print("==")
        for i in (startRow...endRow).reversed() {
            print(i, startCol)
            ret.append(matrix[i][startCol])
            count += 1
            if count == total {
                return ret
            }
        }
        
        startCol += 1
    }
    print(ret)
    return ret
}

spiralOrder([[1,2,3,4],[5,6,7,8],[9,10,11,12]]) //[1,2,3,4,8,12,11,10,9,5,6,7])

// https://leetcode.com/problems/longest-substring-without-repeating-characters/
func lengthOfLongestSubstring(_ s: String) -> Int {
    // o(n): memorize the current length, if reached index i with matched saved index in dict, then compare for getting max length with current length, and if the current length's lower bound is larger than index then just ignore it, else current length is equal i - index
    var ret = 0
    var cur = 0
    var ss = [Character: Int]()
    let sss = Array(s)

    if s.isEmpty { return 0 }
    
    for i in 1...sss.count {
        let c = sss[i-1]
        
        if let index = ss[c] {
            ret = max(ret, cur)
            cur = min(i-index, cur+1)
            ss[c] = i
        } else {
            ss[c] = i
            cur += 1
        }
    }
    
    return max(ret, cur)
}

//lengthOfLongestSubstring("abcabcbb")
//lengthOfLongestSubstring("pwwkew")
//lengthOfLongestSubstring("bbbb")
//lengthOfLongestSubstring(" ")
//lengthOfLongestSubstring("dvdf")
//lengthOfLongestSubstring("abba")
//lengthOfLongestSubstring("tmmzuxt")

// https://leetcode.com/problems/minimum-size-subarray-sum/
func minSubArrayLen(_ target: Int, _ nums: [Int]) -> Int {
    // O(N): use sliding window, increment sum by r pointer, if sum >= target then try to find the min length by reduce the window from the l side until it reached r then continue
    var l = 0
    var r = 0
    var ret = 0
    var sum = 0
    
    while r < nums.count {
        sum += nums[r]
        
        while sum >= target && l <= r {
            if ret > 0 {
                ret = min(r-l+1, ret)
            } else {
                ret = r-l+1
            }
            sum -= nums[l]
            l += 1
        }
        
        r += 1
    }
    
    return ret
}

minSubArrayLen(7, [2,3,1,2,4,3])
//minSubArrayLen(1, [1,4,4])

// https://leetcode.com/problems/container-with-most-water/
func maxArea(_ height: [Int]) -> Int {
    // O(N): use 2 pointer then calculate max area by x & y axis, also try to find the l & r max height
    var ret = 0
    var l = 1
    var r = height.count
    
    while l < r {
        let area = (r-l) * min(height[l-1], height[r-1])
        if area > ret {
            ret = area
        } else if height[l-1] < height[r-1] {
            l += 1
        } else {
            r -= 1
        }
    }
    
    return ret
}

//maxArea([1,8,6,2,5,4,8,3,7])
maxArea([1,2,4,3])

// https://leetcode.com/problems/two-sum-ii-input-array-is-sorted/
func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
    // O(N): use 2 pointer from left and right, since arr is sorted then if l+r > t then minus r, else increase l
    var l = 0
    var r = numbers.count-1
    
    while l < r {
        if numbers[l] + numbers[r] == target {
            return [l+1, r+1]
        } else if numbers[l] + numbers[r] > target {
            r -= 1
        } else if numbers[l] + numbers[r] < target {
            l += 1
        }
    }
    return []
    
    // O(N): use dictionary/hash map to store value + index, then minus current with target to find the prev index
//    var dict = [Int: Int]()
//    
//    for (index, value) in numbers.enumerated() {
//        if let j = dict[target-value] {
//            return [j+1, index+1]
//        }
//        dict[value] = index
//    }
//    return []
}

twoSum([2,7,11,19], 18)

// https://leetcode.com/problems/reverse-words-in-a-string/
func reverseWords(_ s: String) -> String {
    return s.split(separator: " ").reversed().joined(separator: " ")
}

//reverseWords("a good   example") //"example good a"

// https://leetcode.com/problems/integer-to-roman/
func intToRoman(_ num: Int) -> String {
    let roman = [(1000, "M"), (900, "CM"), (500, "D"), (400, "CD"), (100, "C"),
                 (90, "XC"), (50, "L"), (40, "XL"), (10, "X"), (9, "IX"),
                 (5, "V"), (4, "IV"), (1, "I")]
    
    var ret = ""
    var n = num
    
    // O(N): Just goes from largest number to smallest in the list, subtract after every replace
    for i in roman {
        while n >= i.0 {
            ret.append(i.1)
            n -= i.0
        }
    }
    
    return ret
}

intToRoman(1994) // "MCMXCIV"

// https://leetcode.com/problems/gas-station
func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
    var start = 0
    var sum = 0
    var total = 0
    
    // If gas fell under 0 at anypoint then reset sum and start from next one
    for i in 0..<gas.count {
        let cur = gas[i] - cost[i]
        total += cur
        sum += cur
        if sum < 0 {
            start = i+1
            sum = 0
        }
    }

    // if total gas needed is larger than the route then no starting point
    return total >= 0 ? start : -1
    
    // tle
//    for i in 0..<gas.count {
//        // do a loop from i to (i+count)%count then break if < 0, else if starting
//        var v = 0
//        for j in i..<gas.count+i {
//            v += gas[j%gas.count] - cost[j%gas.count]
//            if v < 0 {
//                break
//            } else if j == i+gas.count-1 {
//                return i
//            }
//        }
//    }
    
//    return -1
}

//canCompleteCircuit([1,2,3,4,5], [3,4,5,1,2]) // 3
canCompleteCircuit([1,2,3,4], [2,2,3,4]) // -1
//canCompleteCircuit([5, 1, 2, 3, 4], [4, 4, 1, 5, 1])

// https://leetcode.com/problems/product-of-array-except-self/
func productExceptSelf(_ nums: [Int]) -> [Int] {
    var ret = Array(repeating: 1, count: nums.count)
    var prodl = 1
    var prodr = 1
    
    for i in 0..<nums.count {
        ret[i] *= prodl
        prodl *= nums[i]
        
        ret[nums.count-i-1] *= prodr
        prodr *= nums[nums.count-i-1]
    }
    
    return ret
}

productExceptSelf([1,2,3,4]) // [24,12,8,6] - [2*3*4, 1*3*4, 1*2*4, 1*2*3]

// https://leetcode.com/problems/h-index
func hIndex(_ citations: [Int]) -> Int {
    // naive
    let sortedCitations = citations.sorted(by: >)
    var hIndex = 0
    
    for (index, citation) in sortedCitations.enumerated() {
        if citation > index {
            hIndex += 1
        }
    }
    
    return hIndex
}

//hIndex([5,4,2,1,1]) // 1
//hIndex([11,15]) // 2
//hIndex([1,3,6,1,5]) // 3
//hIndex([6,5,5,1,6]) // 4 - 4 num >= 5 and 5 num >= 1

// https://leetcode.com/problems/jump-game-ii/
func jump(_ nums: [Int]) -> Int {
    var jumps = 0
    var reached = 0
    var maxReach = 0
    
    for i in 0..<nums.count-1 {
        maxReach = max(maxReach, i + nums[i])
        if i == reached {
            jumps += 1
            reached = maxReach
        }
    }
    
    return jumps
}

//jump([2,3,1,1,4])
//jump([4,1,1,3,1,1,1]) // 2
jump([7,0,9,6,9,6,1,0,7,9,0,1,2,9,0,3]) // 3

// https://leetcode.com/problems/jump-game/
func canJump(_ nums: [Int]) -> Bool {
    var toReach = nums.count
    var maxReach = 0
    for i in 0..<toReach-1 {
        if nums[i] > 0 {
            let reach = nums[i] + i
            maxReach = max(reach, maxReach)
            if maxReach >= toReach-1 {
                return true
            }
        } else if maxReach <= i {
            return false
        }
    }
    
    return maxReach >= toReach-1
}

//canJump([2,3,1,1,4]) // true
//canJump([2,3,0,0,0,0,1,4]) // false
//canJump([0,2,3]) // false

// https://leetcode.com/problems/best-time-to-buy-and-sell-stock-ii/
func maxProfit(_ prices: [Int]) -> Int {
    return (0..<prices.count-1).reduce(into: 0) { partialResult, i in
        let diff = prices[i+1] - prices[i]
        if diff > 0 {
            partialResult += diff
        }
    }
}

maxProfit([7,1,5,3,6,4]) // 7
maxProfit([1,2,3,4,5]) // 4

// https://leetcode.com/problems/rotate-array/
func rotate(_ nums: inout [Int], _ k: Int) {
    if nums.count <= 1 { return }
    // Fast
    let c = nums.count
    nums = Array(nums[c-k%c..<c] + nums[0..<c-k%c])
  
    // Slow
//    for _ in 0..<(k%nums.count) {
//        let n = nums.popLast()
//        nums.insert(n!, at: 0)
//    }
}

var nums = [1,2,3,4,5,6,7] // 3, [5,6,7,1,2,3,4]
rotate(&nums, 3)
print(nums)

// https://leetcode.com/problems/remove-duplicates-from-sorted-array-ii/
func removeDuplicates(_ nums: inout [Int]) -> Int {
    if nums.count <= 2 {
        return nums.count
    }
    
    var i = 0
    var count = 2
    
    while i < nums.count-2 {
        if nums[i] == nums[i+2] {
            nums.remove(at: i)
        } else {
            i += 1
            count += 1
        }
    }
    
    return count
}

//var nums = [0,0,1,1,1,1,2,3,3] // 7, [0,0,1,1,2,3,3,_,_]
//var nums = [1,1,1,2,2,3] // 5, [1, 1, 2, 2, 3]
//var nums = [0, 0]
//removeDuplicates(&nums)
//print(nums)

// https://leetcode.com/problems/number-of-sub-arrays-of-size-k-and-average-greater-than-or-equal-to-threshold/
func numOfSubarrays(_ arr: [Int], _ k: Int, _ threshold: Int) -> Int {
    var ret = 0
    var target = threshold * k
    var l = 0
    var r = 0
    var sum = 0

    // used sliding window keeping length = 3
    while r < arr.count {
        sum += arr[r]
        
        while r - l < k-1 {
            r += 1
            sum += arr[r]
        }
        
        if sum >= target {
            ret += 1
        }
        
        sum -= arr[l]
        r += 1
        l += 1
    }
    
    return ret
}

numOfSubarrays([2,2,2,2,5,5,5,8], 3, 4) // 3
//numOfSubarrays([1], 1, 1)

// https://leetcode.com/problems/3sum
func threeSum(_ nums: [Int]) -> [[Int]] {
    let arr = nums.sorted()
    var ret = [[Int]]()
    print(arr)
    for i in 0..<arr.count {
        var j = i+1
        var k = arr.count-1
        
        while j<k {
            print(arr[i],arr[j],arr[k])
            if arr[i] + arr[j] + arr[k] == 0 {
                ret.append([arr[i], arr[j], arr[k]])
                j += 1
                k -= 1
            } else {
                // find pair that equal -arr[i]
                if arr[j] + arr[k] < -arr[i] {
                    j += 1
                } else {
                    k -= 1
                }
            }
        }
    }
    
    return Array(Set(ret))
}

//threeSum([-1,0,1,2,-1,-4])
//threeSum([3,0,-2,-1,1,2]) // [[-2,-1,3],[-2,0,2],[-1,0,1]]
//threeSum([-1,0,1,2,-1,-4]) // [[-1,-1,2],[-1,0,1]]
//Explanation:
//nums[0] + nums[1] + nums[2] = (-1) + 0 + 1 = 0.
//nums[1] + nums[2] + nums[4] = 0 + 1 + (-1) = 0.
//nums[0] + nums[3] + nums[4] = (-1) + 2 + (-1) = 0.
//The distinct triplets are [-1,0,1] and [-1,-1,2].
//Notice that the order of the output and the order of the triplets does not matter.

// https://leetcode.com/problems/kth-largest-element-in-an-array/
func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
    return nums.sorted(by: >)[k-1]
}

//findKthLargest([3,2,1,5,6,4], 2) // 5

// https://leetcode.com/problems/longest-consecutive-sequence
func longestConsecutive(_ nums: [Int]) -> Int {
    var s = Set(nums)
    var ret = 0
    
    for i in s {
        if s.contains(i-1) {
            continue
        }
        
        var c = 1
        while s.contains(i+c) {
            c += 1
        }
        if c > ret {
            ret = c
        }
    }
    
    return ret
}

//longestConsecutive([100,4,200,1,3,2]) // [1,2,3,4] = 4

// https://leetcode.com/problems/next-permutation/ ❌
func nextPermutation(_ nums: inout [Int]) {
//    Find the highest index i such that arr[i] < arr[i+1]. If no such index exists, the permutation is the last permutation.
//    Find the highest index j > i such that arr[j] > arr[i]. Such a j must exist, since i+1 is such an index.
//    Swap arr[i] with arr[j].
//    Reverse the order of all of the elements after index i till the last element.
    
    var i = nums.count - 2
    while i >= 0 && nums[i] >= nums[i + 1] {
        i -= 1
    }
    if i >= 0 {
        var j = nums.count - 1
        while j >= 0 && nums[j] <= nums[i] {
            j -= 1
        }
        print(nums[i], nums[j])
        nums.swapAt(i, j)
    }
    nums[(i + 1)...].reverse()
}

//var nums = [4,3,2,5,4,3,1] // [4,3,3,1,2,4,5]
//var nums = [3,1,4,2]
//nextPermutation(&nums)
//print(nums)

// https://leetcode.com/problems/search-in-rotated-sorted-array/
func search(_ nums: [Int], _ target: Int) -> Int {
    var l = 0
    var r = nums.count-1
    while l <= r {
        let m = nums.index(l, offsetBy: nums.distance(from: l, to: r)/2)
        print(nums[l], nums[m], nums[r])
        if target == nums[m] {
            return m
        }
        
        if nums[m] > nums[r] {
            // pivot in the right, means left is sorted
            if target < nums[m] && target >= nums[l] {
                // target in the left half, set right bound to mid - 1 to move to left half
                r = m-1
            } else {
                // target in the right half
                l = m+1
            }
        } else {
            //pivot in the left
            if target > nums[m] && target <= nums[r] {
                // target in the right half
                l = m+1
            } else {
                // target in the left half
                r = m-1
            }
        }
    }

    return -1
}

search([3,5,1], 3)
//search([4,5,6,7,0,1,2], 0) // 4
//search([7,0,1,2,4,5,6], 0) // 1

// https://leetcode.com/problems/find-first-and-last-position-of-element-in-sorted-array/
func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
    // A bit faster solution
    func binarySearch(_ nums: [Int], _ target: Double) -> [Int] {
        var l = 0
        var r = nums.count - 1
        while l <= r {
            var m = (l + r) / 2
            if Double(nums[m]) < target {
                l = m+1
            } else {
                r = m-1
            }
        }
        return [l, r]
    }
    
    let l = binarySearch(nums, Double(target)-0.1)
    let r = binarySearch(nums, Double(target)+0.1)
    
    if (l.first != r.first) {
        return [l.first!, r.last!]
    }
    return [-1, -1]
    
    // binary search then expand both ways
//    var l = 0
//    var r = nums.count - 1
//    var retl = -1
//    var retr = -1
//    while l <= r {
//        let m = nums.index(l, offsetBy: nums.distance(from: l, to: r)/2)
//        print(nums[l], nums[m], nums[r])
//        if target == nums[m] {
//            var i = m
//            var j = m
//            while retl == -1 || retr == -1 {
//                i -= 1
//                if (i < 0 || nums[i] != target) && retl == -1 {
//                    retl = i+1
//                }
//
//                j += 1
//                if (j >= nums.count || nums[j] != target) && retr == -1 {
//                    retr = j-1
//                }
//            }
//        }
//
//        if target > nums[m] {
//            l = m+1
//        } else {
//            r = m-1
//        }
//    }
    
//    return [retl, retr]
}

searchRange([1,1], 1)
//searchRange([5,7,7,8,8,10], 8) // [3,4]

// https://leetcode.com/problems/combination-sum/ ❌
func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
    func dfs(_ candidates: [Int], _ target: Int, _ cur: inout [Int],  _ ret: inout [[Int]], _ index: Int) {
        print(target, cur, index)
        if target == 0 {
            ret.append(cur)
            return
        }
        
        for i in index..<candidates.count {
            let num = candidates[i]
            if target - num < 0 {
                return
            }
            
            cur.append(num)
            dfs(candidates, target - num, &cur, &ret, i)
            cur.popLast()
        }
    }
    
    var ret = [[Int]]()
    var cur = [Int]()
    dfs(candidates.sorted(), target, &cur, &ret, 0)
    return ret
}

//combinationSum([2,3,5], 8) // [[2,2,2,2],[2,3,3],[3,5]]
//combinationSum([8,7,4,3], 11) // [[3,4,4],[4,7],[3,8]]
combinationSum([7,3,2], 18) // [[7,7,2,2],[7,3,3,3,2],[7,3,2,2,2,2],[3,3,3,3,3,3],[3,3,3,3,2,2,2],[3,3,2,2,2,2,2,2],[2,2,2,2,2,2,2,2,2]]

// https://leetcode.com/problems/valid-sudoku/ ❎
func isValidSudoku(_ board: [[Character]]) -> Bool {
    var box = [Int: Set<Character>]()
    
    for i in 0..<9 {
        var row = Set<Character>()
        var col = Set<Character>()
        for j in 0..<9 {
//            print(i, j)
            let c = board[i][j]
            let d = board[j][i]
            
            if d != "." && col.contains(d) {
                return false
            } else {
                col.insert(d)
            }
            
            if c != "." {
                if row.contains(c) {
                    return false
                } else {
                    row.insert(c)
                }
                
                // Get the index for the box (0, 1, 2) * 3 times then compare it in a dictionary
                let index = (i/3)*3 + (j/3)
                if let boxSet = box[index] {
                    if boxSet.contains(c) {
                        return false
                    }
                    box[index]?.insert(c)
                } else {
                    box[index] = [c]
                }
            }
        }
    }
    print(box)
    return true
}

isValidSudoku([["5","3",".",".","7",".",".",".","."]
               ,["6",".",".","1","9","5",".",".","."]
               ,[".","9","8",".",".",".",".","6","."]
               ,["8",".",".",".","6",".",".",".","3"]
               ,["4",".",".","8",".","3",".",".","1"]
               ,["7",".",".",".","2",".",".",".","6"]
               ,[".","6",".",".",".",".","2","8","."]
               ,[".",".",".","4","1","9",".",".","5"]
               ,[".",".",".",".","8",".",".","7","9"]])
//: [Next](@next)
