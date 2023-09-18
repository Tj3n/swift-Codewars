//: [Previous](@previous)

import Foundation

// https://leetcode.com/problems/longest-valid-parentheses/
func longestValidParentheses(_ s: String) -> Int {
    // Push all "(" in a stack with their index,
    // then when meet ")", pop the stack until find coressponding "(" and replace the range of "("...")" with 1
    // then return the longest subarray of 1
    var rets = Array.init(repeating: 0, count: s.count)
    var stack = [(Int, String.Element)]()
    for (i, c) in s.enumerated() {
        if stack.isEmpty || c == "(" {
            stack.append((i, c))
        } else {
//            print(stack)
            if let last = stack.last, last.1 == "(" {
                rets.replaceSubrange(last.0...i, with: Array(repeating: 1, count: i-last.0+1))
            }
            stack.popLast()
        }
    }
    
    var ret = 0
    var count = 0
    for i in rets {
        if i == 1 {
            count += 1
            ret = max(count, ret)
        } else {
            count = 0
        }
    }
    
//    print(rets)
    return ret
}

longestValidParentheses("()))()()))") // 4
//longestValidParentheses("()(())") // 6

// https://leetcode.com/problems/next-permutation/
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
var nums = [3,1,4,2]
nextPermutation(&nums)
print(nums)

// https://leetcode.com/problems/substring-with-concatenation-of-all-words/
func findSubstring(_ s: String, _ words: [String]) -> [Int] {
    let l = words.first!.count
    let length = words.count * l
    if s.count - length < 0 {
        return []
    }
    
    var arr = Array(s)
    var ret = [Int]()
    let w = words.reduce(into: [String: Int]()) { partialResult, w in
        let c = words.filter({ $0 == w }).count
        partialResult[w] = c
    }
    
    var ww = w
    for i in 0...s.count-length {
        let ss = arr[i..<i+l].map({ String($0) }).joined()
        if let _ = ww[ss] {
            // Start checking the rest
            var n = i
            for _ in 0..<words.count {
                print(n, n+l, arr.count, words.count)
                let v = arr[n..<n+l].map({ String($0) }).joined()
                if let c = ww[v] {
                    ww[v] = c - 1
                    if c - 1 <= 0 {
                        ww.removeValue(forKey: v)
                    }
                    n += l
                } else {
                    ww = w
                    break
                }
            }
            
            if ww.isEmpty {
                ret.append(i)
                ww = w
            }
        } else {
            ww = w
        }
    }
    
    // time limit exceeded
//    let w = Set(permutations(of: words).map({ $0.joined() }))
//    for i in 0...s.count-length {
//        if w.contains(arr[i..<i+length].map({ String($0) }).joined()) {
//            ret.append(i)
//        }
//    }
    
    return ret
}

func permutations(of array: [String]) -> [[String]] {
    guard array.count > 1 else { return [array] }
    
    var perms = [[String]]()
    for i in 0 ..< array.count {
        let remaining = array.enumerated().filter { $0.offset != i }.map({ $0.element })
        let permutationsOfRemaining = permutations(of: remaining)

        for perm in permutationsOfRemaining {
            perms.append([array[i]] + perm)
        }
      }

    return perms
}

findSubstring("aaa", ["a", "a"])
//findSubstring("wordgoodgoodgoodbestword", ["word","good","best","good"]) // [8]
//findSubstring("barfoofoobarthefoobarman", ["bar","foo","the"]) // [6, 9, 12]

// https://leetcode.com/problems/find-the-index-of-the-first-occurrence-in-a-string/
func strStr(_ haystack: String, _ needle: String) -> Int {
//    guard let i = haystack.firstRange(of: needle) else {
//        return -1
//    }
//    return haystack.distance(from: haystack.startIndex, to: i.lowerBound)
    
    if needle.count > haystack.count || haystack.count == 0 {
        return -1
    }
    
    let arr = Array(haystack)
    
    for i in 0..<haystack.count {
        if i+needle.count <= arr.count &&
            arr[i] == needle.first! &&
            arr[i..<i+needle.count].map({ String($0) }).joined() == needle {
            return i
        }
    }
    return -1
}

strStr("mississipi", "issip")

// https://leetcode.com/problems/climbing-stairs/
func climbStairs(_ n: Int) -> Int {
    if n == 1 {
        return 1
    } else if n == 2 {
        return 2
    } else if n > 45 {
        return 0
    }
    
    var d = [1: 1, 2: 2]
    
    // x=n-1 + n-2, n=3 -> x=n(1)+n(2) == 3
    var k = 3
    var ret = 0
    while k <= n {
        ret = d[k-1]! + d[k-2]!
        d[k] = ret
        k += 1
    }
    
    return ret
}

//climbStairs(4) // 5

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

// https://leetcode.com/problems/kth-largest-element-in-an-array/
func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
    return nums.sorted(by: >)[k-1]
}

//findKthLargest([3,2,1,5,6,4], 2) // 5

// https://leetcode.com/problems/longest-common-prefix/
func longestCommonPrefix(_ strs: [String]) -> String {
    if strs.count == 1 {
        return strs.first!
    }

    var test = strs.first!
    var ret = ""
    for i in 0...test.count {
        var match = 0
        for s in strs.suffix(from: 1) {
            if s.prefix(i) == test.prefix(i) {
                match += 1
            } else {
                break
            }
        }
    
        if match == strs.count-1 {
            ret = String(test.prefix(i))
        } else {
            return ret
        }
    }

    return ret
}

//longestCommonPrefix(["flower","flow","flight"]) // fl
//longestCommonPrefix(["flower","flower","flower","flower"])

// https://leetcode.com/problems/remove-duplicates-from-sorted-array/
func removeDuplicates(_ nums: inout [Int]) -> Int {
    var test: Int
    for i in 0..<nums.count-1 {
        if i >= nums.count-1 {
            break
        }
        
        test = nums[i]
        
        var j = 1
        while i+j < nums.count && test == nums[i+j] {
            j+=1
        }
        
        if j > 1 {
            nums.removeSubrange(i..<i+j-1)
        }
    }
    
    return nums.count
}

//var nums = [0,0,1,1,1,2,2,3,3,4]
//var nums = [1,1,1]
//removeDuplicates(&nums) // 5, nums = [0,1,2,3,4,_,_,_,_,_]
//print(nums)

// https://leetcode.com/problems/valid-anagram/
func isAnagram(_ s: String, _ t: String) -> Bool {
    // return s.sorted() == t.sorted()
    
    var dict = [Character: Int]() // char: count
    
    for i in Array(s) {
        dict[i] = dict[i] != nil ? dict[i]!+1 : 1
    }
    
    for j in Array(t) {
        if let c = dict[j], c > 0 {
            if c == 1 {
                dict.removeValue(forKey: j)
            } else {
                dict[j] = c - 1
            }
        } else {
            return false
        }
    }
    
    return dict.isEmpty
}

//isAnagram("anagram", "nagaram") // true

// https://leetcode.com/problems/valid-palindrome/
func isPalindrome(_ s: String) -> Bool {
    let ss = Array(s.lowercased().unicodeScalars.filter({ CharacterSet.alphanumerics.contains($0) }))
    for i in 0..<ss.count/2 {
        if ss[i] != ss[ss.count-i-1] {
            return false
        }
    }
    
    return true
}

//isPalindrome("A man, a plan, a canal: Panama") // true

// https://leetcode.com/problems/merge-sorted-array/
func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
    var ret = nums1.prefix(upTo: m)
    ret.append(contentsOf: nums2.prefix(upTo: n))
    nums1 = ret.sorted()
}

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

// https://leetcode.com/problems/palindrome-number/
func isPalindrome(_ x: Int) -> Bool {
    if x < 0 {
        return false
    } else if x > 0 && x < 10 {
        return true
    }

    // return String(x) == String(String(x).reversed())

    // Creating reversed order number then if minus = 0 they are same
    var i = 0
    var j = x
    while j != 0 {
        i = i*10 + j%10
        j /= 10
    }

    return x-i == 0
}

//isPalindrome(121) // true
//isPalindrome(1213) // false

// https://leetcode.com/problems/contains-duplicate/
func containsDuplicate(_ nums: [Int]) -> Bool {
    return Set(nums).count < nums.count
}

// https://leetcode.com/problems/best-time-to-buy-and-sell-stock/
func maxProfit(_ prices: [Int]) -> Int {
    var max = 0
    var prev = prices.first!
    
    for i in prices {
        if i < prev {
            prev = i
        } else if i-prev > max {
            max = i-prev
        }
    }
    
    return max
}

//maxProfit([7,1,5,3,6,4]) // 5
//maxProfit([2,4,1]) // 2

// https://leetcode.com/problems/valid-parentheses/
func isValid(_ s: String) -> Bool {
    let pair = [")": "(", "}": "{", "]": "["]
    let open = pair.values
    
    var ins = [String]()
    
    for i in s {
        let c = String(i)
        if open.contains(c) {
            ins.append(c)
        } else {
            if ins.last == pair[c] {
                ins.popLast()
            } else {
                return false
            }
        }
    }
    
    return ins.isEmpty
}

//isValid("([)]") // false
//isValid("([]{})") // true

class MinStack {

    var arr = [Int]()
    var min = Int(Int32.min)

    init() {
        
    }
    
    // Associate each new val with different min value
    func push(_ val: Int) {
        if !arr.isEmpty {
            if val > min {
                arr.append(val)
            } else {
                arr.append(val*2-min)
                min = val
            }
        } else {
            arr.append(val)
            min = val
        }
    }
    
    func pop() {
        if let last = arr.popLast() {
            if last < min {
                min = 2*min - last
            }
        }
    }
    
    func top() -> Int {
        if let last = arr.last {
            if last < min {
                return min
            }
            return last
        }
        return 0
    }
    
    func getMin() -> Int {
        return min
    }
}

//var minStack = MinStack();
//minStack.push(2);
//minStack.push(0);
//minStack.push(3);
//minStack.push(0);
//minStack.getMin(); // return 0
//minStack.pop();
//minStack.getMin(); // return 0
//minStack.pop();
//minStack.getMin(); // return 0
//minStack.pop();
//minStack.top();    // return 2
//minStack.getMin(); // return 2

func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
    var dp = Array(repeating: false, count: s.count + 1)
    dp[0] = true
    
    let wordSet = Set(wordDict)
    
    for i in 1...s.count {
        for j in 0..<i {
            let start = s.index(s.startIndex, offsetBy: j)
            let end = s.index(s.startIndex, offsetBy: i)
            let subStr = String(s[start..<end])
            print(subStr, i, j)
            
            if dp[j] && wordSet.contains(subStr) {
                print("ok "+subStr)
                dp[i] = true
                break
            }
        }
    }
    
    return dp[s.count]
}

//wordBreak("applepenapple", ["apple","pen"])
//wordBreak("catsandogcat", ["cats","dog","sand","and","cat","an"])
//wordBreak("aaaaaaa", ["aaaa","aaa"])

func reverse(_ x: Int) -> Int {
    var s = String(x >= 0 ? String(x).reversed() : String(x * -1).reversed())
    let ret = x >= 0 ? Int(s)! : Int(s)! * -1
    return ret > Int32.max ? 0 : ret < Int32.min ? 0 : ret
}

func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
    let nums = (nums1+nums2).map({ Double($0) }).sorted()
    return nums.isEmpty ? 0 : nums.count == 1 ? nums.first! : nums.count % 2 == 0 ? (nums[nums.count/2-1]+nums[(nums.count/2)])/2.0 : nums[(nums.count-1)/2]
}

//findMedianSortedArrays([1,2], [3,4])
//: [Next](@next)
