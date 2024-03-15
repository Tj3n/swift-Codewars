//: [Previous](@previous)

import Foundation

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
