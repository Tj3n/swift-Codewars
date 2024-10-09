//: [Previous](@previous)

import Foundation

// https://www.hackerrank.com/challenges/fraudulent-activity-notifications
func activityNotifications(expenditure: [Int], d: Int) -> Int {
    var ret = 0
    
    for i in d..<expenditure.count {
        let arr = expenditure[(i-d)..<i]
        let m = median(Array(arr))
        // print(arr, 2*m, expenditure[i])
        if Double(expenditure[i]) >= m*2 {
            ret += 1
        }
    }
    return ret
}

func median(_ a: [Int]) -> Double {
    let arr = a.sorted()
    if arr.count % 2 == 0 {
        return Double(arr[arr.count/2] + arr[arr.count/2-1]) / 2.0
    }
    return Double(arr[arr.count/2])
}


// https://www.hackerrank.com/challenges/weighted-uniform-string/
func weightedUniformStrings(s: String, queries: [Int]) -> [String] {
    let ss = s.map({ String($0) })
    var dict = queries.reduce(into: [Int: String](), { result, val in
        result[val] = "No"
    })
    
    var i = 0
    while i < ss.count {
        let c = ss[i]
        let weight = Int(c.unicodeScalars.first!.value) - 96
        if let _ = dict[weight] {
            dict[weight] = "Yes"
        }
        
        var j = i + 1
        // print(c)
        while j < ss.count && ss[j] == c {
            // print(j, i, weight * (j-i+1))
            if let _ = dict[weight * (j-i+1)] {
                dict[weight * (j-i+1)] = "Yes"
            }
            j += 1
        }
        
        i = j
    }
    // print(dict)
    return queries.map({ dict[$0]! })
}

// https://www.hackerrank.com/challenges/two-characters/
func alternate(s: String) -> Int {
    var ret = 0
    let ss = s.map({ String($0) })
    let sss = Array(Set(ss))
    
    if s.count == 1 {
        return 0
    }

    for i in 0..<sss.count-1 {
        for j in i+1..<sss.count {
            var str = [String]()
            var isAlt = true
            
            for c in ss {
                if c == sss[i] || c == sss[j] {
                    if str.count > 0 && str.last == c {
                        isAlt = false
                        break
                    } else {
                        str.append(c)
                    }
                }
            }
            
            if isAlt {
                print(str)
                ret = max(ret, str.count)
            }
        }
    }
    
    return ret
}

// https://www.hackerrank.com/challenges/reduced-string
func superReducedString(s: String) -> String {
    let ss = s.map({String($0)})
    var stack = [String]()
    var i = 0
    while i < ss.count {
        if stack.last == ss[i] {
            stack.removeLast()
        } else {
            stack.append(ss[i])
        }
        i += 1
    }

    return stack.count > 0 ? stack.joined() : "Empty String"
}

// https://www.hackerrank.com/challenges/almost-sorted
func almostSorted(arr: [Int]) -> Void {
    // compare with sorted arr to find the diff and then check if the diff is continuous or not
    if arr.first! > arr.last! && arr.count > 2 {
        print("no")
        return
    }
    
    let sorted = arr.sorted()
    var swapArr = [Int]()
    for i in 0..<arr.count {
        if arr[i] != sorted[i] {
            swapArr.append(i)
        }
    }
    
    if (swapArr.count == 2) {
        print("yes")
        print("swap", swapArr.first!+1, swapArr.last!+1)
    } else if swapArr.isEmpty {
        print("no")
    } else {
        var isContinous = true
        for i in 0..<swapArr.count-1 {
            if arr[swapArr[i]] < arr[swapArr[i+1]] {
                isContinous = false
                break
            }
        }
        if isContinous {
            print("yes")
            print("reverse", swapArr.first!+1, swapArr.last!+1)
        } else {
            print("no")
        }
    }
}

// https://www.hackerrank.com/challenges/larrys-array/
func larrysArray(A: [Int]) -> String {
    var count = 0
    for i in 0..<A.count {
        for j in i+1..<A.count {
            if A[i] > A[j] {
                count += 1
                print(A, A[i], A[j])
            }
        }
    }
    
    return count % 2 == 0 ? "YES" : "NO"
}

// https://www.hackerrank.com/challenges/bigger-is-greater
func biggerIsGreater(w: String) -> String {
    if w.count <= 1 { return "no answer" }
    var s = w.map({ String($0) })
    
    // Find pivot
    var i = s.count-2
    while i >= 0 && s[i] >= s[i+1] {
        i -= 1
    }
    
    if i < 0 {
        return "no answer"
    }
    
    // Find new pivot just greater than pivot
    var j = s.count - 1
    while j >= 0 && s[j] <= s[i] {
        j -= 1
    }
    
    // Swap pivot with new pivot
    s.swapAt(i, j)
    
    // Reverse all elements just after new pivot
    var n = s.count-1
    i += 1
    while i < n {
        s.swapAt(i, n)
        i += 1
        n -= 1
    }
    return s.joined()
}

// https://www.hackerrank.com/challenges/cut-the-sticks
func cutTheSticks(arr: [Int]) -> [Int] {
    var ret = [Int]()
    var sorted = arr.sorted()
    while !sorted.isEmpty {
        ret.append(sorted.count)
        
        let i = sorted.first!
        sorted = sorted.filter({ $0 > i })
    }
    
    return ret
}

cutTheSticks(arr:  [5, 4, 4, 2, 2, 8])

// https://www.hackerrank.com/challenges/library-fine
func libraryFine(d1: Int, m1: Int, y1: Int, d2: Int, m2: Int, y2: Int) -> Int {
    if y1 == y2 {
        if m1 == m2 {
            if d1 == d2 {
                return 0
            } else if d1 > d2 {
                return (d1-d2) * 15
            }
        } else if m1 > m2 {
            return (m1-m2) * 500
        }
    } else if y1 > y2 {
        return 10000
    }
    
    return 0
}

// https://www.hackerrank.com/challenges/sherlock-and-squares
func squares(a: Int, b: Int) -> Int {
    var ret = 0
    var i = ceil(sqrt(Double(a)))
    while pow(Decimal(i), 2) <= Decimal(b) {
        ret += 1
        i += 1
    }
    return ret
}

// https://www.hackerrank.com/challenges/append-and-delete
func appendAndDelete(s: String, t: String, k: Int) -> String {
    var matchIndex = 0
    let ss = s.map({ String($0) }) // OR s.split(separator: "")
    let tt = t.map({ String($0) })

    while matchIndex < min(ss.count, tt.count), ss[matchIndex] == tt[matchIndex] {
        matchIndex += 1
    }
    
    let diffCount = s.count - matchIndex + t.count - matchIndex

    // 3 conditions:
    // need exactly k moves upon start
    // k is longer than s + t so can always remove whole s to replace with t
    // if k > diffCount then need odd numbers of moves to keep delete and add the same char to match exactly k move
    if k == diffCount || k > s.count + t.count || (diffCount < k && (k - diffCount) % 2 == 0) {
        return "Yes"
    } else {
        return "No"
    }
}

//https://www.hackerrank.com/challenges/find-digits
func findDigits(n: Int) -> Int {
    var i = 0
    var j = n
    var ret = 0
    while j != 0 {
        i = j % 10
        j /= 10
        
        if i == 0 { continue }
        if (n % i == 0) {
            ret += 1
        }
    }
    return ret
}

// https://www.hackerrank.com/challenges/jumping-on-the-clouds-revisited
func jumpingOnClouds(c: [Int], k: Int) -> Int {
    var e = 100
    var i = 0
    // Jumping loop until reached start point
    while i == 0 || i % c.count != 0 {
        if c[i % c.count] == 0 {
            e -= 1
        } else {
            e -= 3
        }
        i += k
    }
    return e
}

// https://www.hackerrank.com/challenges/beautiful-days-at-the-movies
func beautifulDays(i: Int, j: Int, k: Int) -> Int {
    var result = 0
    for d in i...j {
        var org = d
        var reversed = 0
        
        // create the reversed number by getting each digit
        while org != 0 {
            let digit = org % 10
            reversed = reversed * 10 + digit
            org /= 10
        }

        let val = abs(d - reversed)
        if (val % k == 0) {
            result += 1
        }
    }
    return result;
}


// https://www.hackerrank.com/challenges/strange-advertising
func viralAdvertising(n: Int) -> Int {
    var ret = 0
    var shared = 5
    var liked = 0
    for _ in 1...n {
        liked = Int(floor(Double(shared) / 2))
        ret += liked
        shared = liked * 3
    }
    return ret
}


// https://www.hackerrank.com/challenges/permutation-equation
func permutationEquation(p: [Int]) -> [Int] {
    var ret = [Int]()
    let dict = p.enumerated().reduce(into: [Int: Int](), { dict, tupes in
        dict[tupes.1] = tupes.0 + 1
    })
    for i in 1...p.count {
       ret.append(dict[dict[i]!]!)
    }
    return ret
}
//: [Next](@next)
