//: [Previous](@previous)

import Foundation

// https://leetcode.com/problems/is-subsequence/
func isSubsequence(_ s: String, _ t: String) -> Bool {
    let ss = Array(s)
    var i = 0
    
    if t.count < s.count { return false }
    if s.count == 0 { return true }
    
    for c in t {
        if c == ss[i] {
            i += 1
        }
        
        if i == s.count {
            return true
        }
    }
    
    return false
}

isSubsequence("abc", "ahbgdc")

// https://leetcode.com/problems/roman-to-integer/
func romanToInt(_ s: String) -> Int {
    let roman = ["I": 1, "V": 5, "X": 10, "L": 50, "C": 100, "D": 500, "M": 1000, "IV": 4, "IX": 9, "XL": 40, "XC": 90, "CD": 400, "CM": 900]
    let arr = Array(s)
    var ret = 0
    var i = 0
    
    while i < arr.count {
        if i != arr.count - 1, let j = roman[arr[i...i+1].map({ String($0) }).joined()] {
            ret += j
            i += 2
        } else {
            ret += roman[String(arr[i])]!
            i += 1
        }
    }
    
    return ret
}

romanToInt("III")
romanToInt("LVIII")
romanToInt("MCMXCIV") // 1994

// https://leetcode.com/problems/majority-element/
func majorityElement(_ nums: [Int]) -> Int {
    var max = 0
    var ret = 0
    
    for i in nums {
        if max == 0 {
            ret = i
        }
        
        if i == ret {
            max += 1
        } else {
            max -= 1
        }
    }
    return ret
}

majorityElement([2,2,1,1,1,2,2]) // 2

// https://leetcode.com/problems/remove-element/
func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
    var count = 0
    var i = 0
    
    while i < nums.count {
        if nums[i] == val {
            nums.remove(at: i)
        } else {
            count += 1
            i += 1
        }
    }
    
    return count
}

//var nums = [0,1,2,2,3,0,4,2]
//removeElement(&nums, 2) // 5
//print(nums)

// https://leetcode.com/problems/ransom-note/
func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
    var dict = magazine.utf8CString.reduce(into: [CChar: Int]()) { partialResult, c in
        if let v = partialResult[c] {
            partialResult[c] = v+1
        } else {
            partialResult[c] = 1
        }
    }
    
    for c in ransomNote.utf8CString {
        if let v = dict[c] {
            if v-1 == 0 {
                dict.removeValue(forKey: c)
            } else {
                dict[c] = v-1
            }
        } else {
            return false
        }
    }
    
    return true
}

canConstruct("aa", "aba")

// https://leetcode.com/problems/number-of-steps-to-reduce-a-number-to-zero/
func numberOfSteps(_ num: Int) -> Int {
    if num == 0 {
        return 0
    }
    
    var ret = 1
    var s = num
    while s != 1 {
        if s % 2 == 0 {
            s = s / 2
            ret += 1
        } else {
            s = (s - 1) / 2
            ret += 2
        }
    }
    return ret
}

numberOfSteps(14) // 6

// https://leetcode.com/problems/fizz-buzz/
func fizzBuzz(_ n: Int) -> [String] {
    return (1...n).map({ i in
        if i % 3 == 0 && i % 5 == 0 {
            return "FizzBuzz"
        } else if i % 3 == 0 {
            return "Fizz"
        } else if i % 5 == 0 {
            return "Buzz"
        } else {
            return String(i)
        }
    })
}

fizzBuzz(15) //["1","2","Fizz","4","Buzz","Fizz","7","8","Fizz","Buzz","11","Fizz","13","14","FizzBuzz"]

// https://leetcode.com/problems/running-sum-of-1d-array/
func runningSum(_ nums: [Int]) -> [Int] {
    var ret = [nums.first!]
    for i in 1..<nums.count {
        ret.append(nums[i]+ret[i-1])
    }
    
    return ret
}

runningSum([1,2,3,4]) // [1,3,6,10]

// https://leetcode.com/problems/richest-customer-wealth/
func maximumWealth(_ accounts: [[Int]]) -> Int {
    var ret = 0
    for i in accounts {
        var sum = 0
        for j in i {
            sum += j
        }
        ret = max(sum, ret)
    }
    return ret
}

// https://leetcode.com/problems/length-of-last-word/
func lengthOfLastWord(_ s: String) -> Int {
    var ret = 0
    for c in Array(s).reversed() {
        if c != " " {
            ret += 1
        } else if ret != 0 {
            return ret
        }
    }
    return ret
}

lengthOfLastWord("   fly me   to   the moon  ") // 4


// https://leetcode.com/problems/count-and-say/
func countAndSay(_ n: Int) -> String {
    func say(_ s: [Character]) -> String {
        var ret = ""
        var count = 1
        for i in 0..<s.count {
            if i+1 < s.count && s[i] == s[i+1] {
                count += 1
            } else {
                print(ret, count, s[i])
                ret += "\(count)\(s[i])"
                count = 1
            }
        }
        
        return ret
    }
    
    var ret = "1"
    for _ in 1..<n {
        ret = say(Array(ret))
    }
    return ret
}

countAndSay(4) // 1211

// https://leetcode.com/problems/search-insert-position/
func searchInsert(_ nums: [Int], _ target: Int) -> Int {
    func binarySearch(_ nums: [Int], _ target: Int) -> [Int] {
        var l = 0
        var r = nums.count - 1
        while l <= r {
            var m = (l + r) / 2
            if nums[m] < target {
                l = m+1
            } else {
                r = m-1
            }
        }
        return [l, r]
    }
    
    let ret = binarySearch(nums, target)
    print(ret)
    return max(ret.first!, ret.last!)
}

searchInsert([1,3,5,6], 3) // 2

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
