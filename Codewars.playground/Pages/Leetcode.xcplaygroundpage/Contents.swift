//: [Previous](@previous)

import Foundation

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
