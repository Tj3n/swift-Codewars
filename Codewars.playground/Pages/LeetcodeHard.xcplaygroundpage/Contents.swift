//: [Previous](@previous)

import Foundation

// https://leetcode.com/problems/minimum-window-substring/
func minWindow(_ s: String, _ t: String) -> String {
    // o(n): m+n = t.length + s.length, use sliding window
    var l = 0
    var r = 0
    var retl = -1
    var retr = -1
    
    if s.count < t.count {
        return ""
    }
    
    // Turn t into map of character & count
    let need = t.reduce(into: [Character: Int]()) { partialResult, c in
        partialResult[c] = (partialResult[c] ?? 0) + 1
    }
    print(need)
    
    let ss = Array(s)
    var sum = t.count // <=== have to count backward not foward
    var match = need // <=== have to count backward not foward
    
    while r < ss.count {
        let rc = ss[r]
        if let v = match[rc] {
            if v > 0 {
                // Finding the first valid string
                sum -= 1
            }
            
            match[rc]! -= 1
            if sum == 0 {
                // From the first time found a valid string, always maintain the l r bounds
                // Increase r until found extra matches
                
                while l < r {
                    // Then starting to increase l bound
                    let lc = ss[l]
                    if let lv = match[lc] {
                        if lv == 0 {
                            // Until the match no longer satisfied: the count of this character is matched and cannot be removed anymore)
                            break
                        } else {
                            // Else just ignore or increase the match value til reached 0
                            match[lc] = lv+1
                        }
                    }
                    
                    l += 1
                }
                
                print(l, r, match, ss[l...r].map({ String($0) }).joined())
                if retl == -1 || r-l < retr-retl {
                    // compare and find min length
                    retl = l
                    retr = r
                }
            }
        }
        
        r+=1
    }
    
    if retl == -1 {
        return ""
    }
    
    return ss[retl...retr].map({ String($0) }).joined()
}

//minWindow("ADOBECODEBANC", "ABC")
//minWindow("ADOBACODEBANC", "ABC")
//minWindow("ADOABCODEBANC", "ABC")
//minWindow("a", "aa")
//minWindow("a", "b")
//minWindow("caccaacaaaabbcaccaccc", "acccacbccc")

// https://leetcode.com/problems/text-justification/
func fullJustify(_ words: [String], _ maxWidth: Int) -> [String] {
    var rets = [String]()
    var curLen = 0
    var ret = [String]()
    var i = 0
    
    while i < words.count-1 {
        let w = words[i]
        curLen += w.count
        if curLen + 1 + words[i+1].count > maxWidth {
            ret.append(w)
            
            // Distribute maxWidth - curLen spaces to each ret and combine
            if ret.count > 1 {
                var distributedSpace = 0
                while distributedSpace < maxWidth - curLen {
                    ret[distributedSpace%(ret.count-1)].append(" ")
                    distributedSpace += 1
                }
            } else {
                ret[0].append(String(repeating: " ", count: maxWidth - curLen))
            }
            
            print(ret, curLen)
            rets.append(ret.joined(separator: " "))
            ret.removeAll()
            curLen = 0
        } else {
            curLen += 1
            ret.append(w)
        }
        
        i += 1
    }
    
    ret.append(words.last!)
    let last = ret.joined(separator: " ")
    return rets + [last + String(repeating: " ", count: maxWidth-last.count)]
}

fullJustify(["What","must","be","acknowledgment","shall","be"], 16)
fullJustify(["My","momma","always","said,","\"Life","was","like","a","box","of","chocolates.","You","never","know","what","you're","gonna","get."], 20)
/*
 |My    momma   always| numWords=3 numSpaces=3 remainingSpaces=1
 |said, "Life was like| numWords=4 numSpaces=1 remainingSpaces=0
 |a box of chocolates.| numWords=4 numSpaces=1 remainingSpaces=0
 |You  never know what| numWords=4 numSpaces=1 remainingSpaces=1
 |you're gonna get.   | no need for extra space
 */

// https://leetcode.com/problems/trapping-rain-water/
func trap(_ height: [Int]) -> Int {
    var maxl = 0
    var maxr = height.count-1
    var mid = 0
    var ret = 0
    
    for i in 1..<height.count {
        if height[i] >= height[maxl] {
            // water is equal to the lower bounds * range between and minus it's height
            let water = min(height[maxl], height[i]) * (i-maxl-1) - mid
            ret += water
            
            mid = 0
            maxl = i
        } else {
            mid += height[i]
        }
    }
    
    mid = 0
    
    for i in (maxl..<height.count-1).reversed() {
        if height[i] >= height[maxr] {
            // travel backward to find right to left trapped water between maxl and maxr
            let water = min(height[maxr], height[i]) * (maxr-i-1) - mid
            ret += water
            
            mid = 0
            maxr = i
        } else {
            mid += height[i]
        }
    }
    
    return ret
}

trap([0,1,0,2,1,0,1,3,2,1,2,1]) // 6
trap([4,2,0,3,2,5]) //9
trap([1,3,2,2,1])


// https://leetcode.com/problems/candy/
func candy(_ ratings: [Int]) -> Int {
    var ret = 0
    var arr = Array(repeating: 1, count: ratings.count)
    
    // go from left to right and compare lhs with rhs
    for i in 1..<ratings.count {
        arr[i] = ratings[i] > ratings[i-1] ? arr[i-1]+1 : 1
        ret += arr[i]
    }
    
    // go from right to left and compare rhs with lhs, if already have more candy then not doing anything
    for i in (0..<ratings.count-1).reversed() {
        if arr[i] <= arr[i+1] && ratings[i] > ratings[i+1] {
            ret += arr[i+1]+1 - arr[i]
            arr[i] = arr[i+1]+1
        }
    }
    return ret+1
}

//candy([1,3,4,5,2]) // 1,2,3,4,1
//candy([1,3,2,2,1]) // 1,2,1,2,1 7
//candy([1,0,2]) // 2,1,2 = 5
//candy([60, 80, 100, 100, 100, 100, 100]) // 1, 2, 3, 1, 1, 1, 1 = 10
candy([100, 80, 70, 60, 70, 80, 90, 100, 90, 80, 70, 60, 60]) // 4,3,2,1,2,3,4,5,4,3,2,1,1 - 35
//candy([6, 7, 6, 5, 4, 3, 2, 1, 0, 0, 0, 1, 0]) // 1,8,7,6,5,4,3,2,1,1,1,2,1 // 42

// https://leetcode.com/problems/substring-with-concatenation-of-all-words/ ❎
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

// https://leetcode.com/problems/sudoku-solver/ ❌
func solveSudoku(_ board: inout [[Character]]) {
    func isValid(_ board: [[Character]], _ row: Int, _ col: Int, _ val: Character) -> Bool {
        for i in 0..<9 {
            if board[row][i] == val || board[i][col] == val || board[row/3*3+i/3][col/3*3+i%3] == val {
                return false
            }
        }
        
        return true
    }
    
    func solve(_ board: inout [[Character]]) -> Bool {
        for i in 0..<9 {
            for j in 0..<9 {
                let c = board[i][j]
                if board[i][j] == "." {
                    for k in (1...9).map({ String($0).first! }) {
                        if isValid(board, i, j, k) {
                            board[i][j] = k
                            if solve(&board) {
                                return true
                            } else {
                                board[i][j] = "."
                            }
                        }
                    }
                    return false
                }
            }
        }
        return true
    }
    
    solve(&board)
}

var b: [[Character]] = [["5","3",".",".","7",".",".",".","."],["6",".",".","1","9","5",".",".","."],[".","9","8",".",".",".",".","6","."],["8",".",".",".","6",".",".",".","3"],["4",".",".","8",".","3",".",".","1"],["7",".",".",".","2",".",".",".","6"],[".","6",".",".",".",".","2","8","."],[".",".",".","4","1","9",".",".","5"],[".",".",".",".","8",".",".","7","9"]]
solveSudoku(&b)
//: [Next](@next)
