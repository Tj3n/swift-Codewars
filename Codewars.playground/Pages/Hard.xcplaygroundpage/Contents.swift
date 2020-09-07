//: Created by Tien Vu - tienvn3845@gmail.com
/*:
 # Hard
 ___
 ## Others:
 1. [Normal](Normal)
 2. [Linked List](LinkedList)
 */
import Foundation
import PlaygroundSupport

//PlaygroundPage.current.needsIndefiniteExecution = true

//https://www.codewars.com/kata/55be10de92aad5ef28000023/train/swift
//FML
func checkChoose(_ m: Int, _ n: Int) -> Int {
    if m == 1 { return 0 }
    var x = -1
    for i in 1...n/2 {
        let b = fact(n)/(fact(i)*fact(n - i))
        if Int(round(b)) == m {
            x = i
            break
        } else if Int(round(b)) > m {
            break
        }
    }
    return x
}

func fact(_ num: Int) -> Float80 {
    var fact: Float80 = 1
    let n: Float80 = Float80(num+1)
    if Int(n) <= 2 { return Float80(num) }
    for i in 1..<Int(n) {
        fact = fact*Float80(i)
    }
    return fact
}

func betterCheckChoose(_ m: Int, _ n: Int) -> Int {
    var result: Int = 1
    for i in 0..<n + 1 {
        if result == m {return i}
        result = result * (n - i) / (i + 1)
    }
    return -1
}

//https://www.codewars.com/kata/ease-the-stockbroker
func balanceStatements(_ list: String) -> String {
    guard list.count > 0  else { return "Buy: 0 Sell: 0" }
    let arr = list.components(separatedBy: ",")
    var badOrder = [String]()
    var totalBuy = 0.0
    var totalSell = 0.0
    
    for order in arr {
        let splited = order.components(separatedBy: " ")
        
        let isBuy = !splited.contains("S")
        var value = 0.0
        var quantity = 0
        var isBad = false
        
        if splited.count < 4 {
            badOrder.append(order)
        } else {
            for (i,comp) in splited.enumerated() {
                switch i {
                case 0:
                    if Int(comp) != nil && comp.count > 1 {
                        isBad = true
                    }
                case 1:
                    if let q = Int(comp) {
                        quantity = q
                    } else {
                        isBad = true
                    }
                case 2:
                    if !comp.contains(".") {
                        isBad = true
                    } else {
                        value = Double(comp)!
                    }
                case 3:
                    if comp != "B" && comp != "S" {
                        isBad = true
                    }
                default:
                    break
                }
            }
        }
        
        if isBad {
            badOrder.append(order)
        } else {
            if isBuy {
                totalBuy += value*Double(quantity)
            } else {
                totalSell += value*Double(quantity)
            }
        }
    }
    let bad = badOrder.count > 0 ? "; Badly formed \(badOrder.count): \(badOrder.joined(separator: " ;")) ;" : ""
    return "Buy: \(Int(round(totalBuy))) Sell: \(Int(round(totalSell)))\(bad)"
}

//https://www.codewars.com/kata/55e86e212fce2aae75000060/train/swift
//Crap test cases
func prod2sum(_ a: Int64, _ b: Int64, _ c: Int64, _ d: Int64) -> [(Int64, Int64)] {
    let n = (a*a+b*b)*(c*c+d*d)
    
    var result = [(Int64, Int64)]()
    guard Int(floor(sqrt(Double(n/2)))) > 1 else { return result }
    for i in 0...Int(floor(sqrt(Double(n/2)))) {
        let e = Int64(i*i)
        let f = sqrt(Double(n-e))
        if f.truncatingRemainder(dividingBy: 1) == 0 {
            result.append((Int64(i), Int64(f)))
        }
    }
    
    var real = [(Int64, Int64)]()
    for tuple in result {
        if checkValid(a, b, c, d, num: tuple.0) && checkValid(a, b, c, d, num: tuple.1) {
            real.append(tuple)
        }
    }
    return real
}

func checkValid(_ a: Int64, _ b: Int64, _ c: Int64, _ d: Int64, num: Int64) -> Bool {
    let a = a >= 0 ? a : -a
    let b = b >= 0 ? b : -b
    let c = c >= 0 ? c : -c
    let d = d >= 0 ? d : -d
    switch num {
    case a*c+b*d:
        return true
    case a*d+b*c:
        return true
    case a*c-b*d:
        return true
    case a*d-b*c:
        return true
    case -a*c+b*d:
        return true
    case -a*d+b*c:
        return true
    default:
        return false
    }
}

//https://www.codewars.com/kata/first-variation-on-caesar-cipher/train/swift
func movingShift(_ s: String, _ shift: Int) -> [String] {
    
    let cipher = caesarShift(string: s, shift: shift, reverse: false)
    let stringArr = cipher.map({ String($0) })
    
    let splitRange = stringArr.count%5 == 0 ? stringArr.count/5 : (stringArr.count-stringArr.count%5+5)/5
    var splitedArr = [String]()
    var j = 0
    
    for i in 1...4 {
        splitedArr.append(stringArr[j...i*splitRange-1].joined())
        j = i*splitRange
    }
    
    if j < stringArr.count-1 {
        splitedArr.append(stringArr[j...stringArr.count-1].joined())
    } else {
        splitedArr.append("")
    }
    
    return splitedArr
}

func demovingShift(_ arr: [String], _ shift: Int) -> String {
    return caesarShift(string: arr.joined(), shift: shift, reverse: true)
}

func caesarShift(string: String, shift: Int, reverse: Bool) -> String {
    var shifted = shift
    var stringArr = string.map({ String($0) })
    
    var letters = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    var uLetters = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    if reverse {
        letters = Array(letters.reversed())
        uLetters = Array(uLetters.reversed())
    }
    
    for (i, char) in stringArr.enumerated() {
        if letters.contains(char) {
            if letters.firstIndex(of: char)!+shifted >= letters.count {
                stringArr[i] = letters[(letters.firstIndex(of: char)!+shifted)-letters.count]
            } else {
                stringArr[i] = letters[letters.firstIndex(of: char)!+shifted]
            }
            
        } else if uLetters.contains(char) {
            if uLetters.firstIndex(of: char)!+shifted >= uLetters.count {
                stringArr[i] = uLetters[(uLetters.firstIndex(of: char)!+shifted)-uLetters.count]
            } else {
                stringArr[i] = uLetters[uLetters.firstIndex(of: char)!+shifted]
            }
        }
        
        shifted+=1
        
        if shifted > 25 {
            shifted = 0
        }
    }
    
    return stringArr.joined()
}

//https://www.codewars.com/kata/phone-directory
func phone(_ strng: String, _ num: String) -> String {
    let arr = strng.components(separatedBy: "\n")
    let lines = arr.filter( {$0.contains(num)} )
    
    guard lines.count > 0 else {return "Error => Not found: \(num)"}
    guard lines.count < 2 else { return "Error => Too many people: \(num)" }
    
    var line = lines[0].replacingOccurrences(of: num, with: "")
    var name = checkMatches(for: "<[a-zA-Z ']+>", in: line)[0]
    line = line.replacingOccurrences(of: name, with: "")
    name.remove(at: name.startIndex)
    name.remove(at: name.index(before: name.endIndex))
    let adress = checkMatches(for: "[a-zA-Z0-9.-]+", in: line).joined(separator: " ")
    
    return "Phone => \(num), Name => \(name), Address => \(adress)"
}

func checkMatches(for regex: String, in text: String) -> [String] {
    do {
        let regex = try NSRegularExpression(pattern: regex, options: .caseInsensitive)
        let nsString = NSString(string: text)
        let result = regex.matches(in: text, options: [], range: NSMakeRange(0, text.count))
        return result.map { nsString.substring(with: $0.range) }
    } catch let error {
        print("invalid regex: \(error.localizedDescription)")
        return []
    }
}

//https://www.codewars.com/kata/salesmans-travel/train/swift
func travel(_ r: String, zipcode: String) -> String {
    guard zipcode.count == 8 else { return "\(zipcode):/" }
    var ar = r.components(separatedBy: ",")
    var indexToRemove = [Int]()
    for (index, add) in ar.enumerated() {
        if add.contains(zipcode) {
            ar[index].removeSubrange(ar[index].range(of: zipcode)!)
            ar[index] = ar[index].trimmingCharacters(in: .whitespaces)
        } else {
            indexToRemove.append(index)
        }
    }
    _ = indexToRemove.reversed().map({ ar.remove(at: $0) })
    guard ar.count > 0 else { return "\(zipcode):/" }
    let numList = ar.map({ $0.components(separatedBy: " ")[0] })
    _ = numList.enumerated().map({ ar[$0.offset] = ar[$0.offset].replacingOccurrences(of: $0.element, with: "").trimmingCharacters(in: .whitespaces) })
    let address = ar.joined(separator: ",")+"/"+numList.joined(separator: ",")
    return zipcode+":"+address
}

//https://www.codewars.com/kata/583c5e83f30065633b00021b/train/swift
//Create a math that accept Int, Double, Float?
infix operator ?=
func ?= <T: Strideable > (lhs: T, rhs: T) -> Bool {
    var left: Float!
    var right: Float!
    if let l = lhs as? Float, let r = rhs as? Float {
        left = l
        right = r
    } else if let l = lhs as? Double, let r = rhs as? Double{
        left = Float(l)
        right = Float(r)
    } else if let l = lhs as? Int, let r = rhs as? Int {
        left = Float(l)
        right = Float(r)
    } else {
        return false
    }
    if left > right {
        return left >= right-right*0.1 && left <= right+right*0.1
    } else {
        return right >= left-left*0.1 && right <= left+left*0.1
    }
}

//https://www.codewars.com/kata/554f76dca89983cc400000bb/train/swift
func solequa(_ n: Int) -> [(Int, Int)] {
    //find factor
    var factors:[(a: Int, b: Int)] = [(n,1)]
    for i in 2...Int(sqrt(Double(n))) {
        if n%i == 0 {
            factors.append((Int(n/i),i))
        }
    }
    
    //calculate x,y
    var result = [(Int, Int)]()
    for (i,j) in factors {
        if (i+j)%2 == 0 && (i-j)%4 == 0 {
            result.append((Int((i+j)/2),Int((i-j)/4)))
        }
    }
    return result
}

//https://www.codewars.com/kata/55aa075506463dac6600010d/train/swift
func listSquared(_ m: Int, _ n: Int) -> [(Int, Int)] {
    var result = [(Int, Int)]()
    for i in m...n {
        if i > 4 {
            //find factor
            var factors = [i,1]
            for j in 2...Int(sqrt(Double(i))) {
                if i%j == 0 {
                    if Int(i/j) == j {
                        factors.append(j)
                    } else {
                        factors.append(contentsOf: [Int(i/j),j])
                    }
                }
            }
            //calc sum and divide
            let sum = factors.map({ $0*$0 }).reduce(0, +)
            if sqrt(Double(sum)).truncatingRemainder(dividingBy: 1) == 0 {
                result.append((i,sum))
            }
        } else if i == 1 {
            result.append((1,1))
        }
    }
    return result
}

//https://www.codewars.com/kata/square-matrix-multiplication/train/swift
func matrixMultiplication(_ a:[[Int]], _ b:[[Int]]) -> [[Int]] {
    var result = [[Int]]()
    for i in 0..<a.count  {
        var rrow = [Int]()
        for j in 0..<b.count {
            var sum = 0
            for k in 0..<a[i].count {
                sum += a[i][k]*b[k][j]
            }
            rrow.append(sum)
        }
        result.append(rrow)
    }
    return result
}

//https://www.codewars.com/kata/best-travel/train/swift
//Get all combination of length from an array
func subArray<T>(arr: [T], length: Int) -> [[T]] {
    var a = [[T]]()
    var result = [T?](repeating: nil, count: length)
    combination(arr:arr, len: length, start: 0, result: &result, final: &a)
    return a
}

func combination<T>(arr: [T], len: Int, start: Int, result: inout [T?], final: inout [[T]]) {
    if len == 0 {
        final.append(Array(result) as! [T])
        return
    }
    for i in start...arr.count-len {
        result[result.count-len] = arr[i]
        combination(arr: arr, len: len-1, start: i+1, result: &result, final: &final)
    }
}

func chooseBestSum(_ t: Int, _ k: Int, _ ls: [Int]) -> Int {
    if k > ls.count { return  -1 }
    let a = subArray(arr: ls, length: k).map({ $0.reduce(0, +) })
    var result = -1
    for i in a {
        let j = t-i
        if j >= 0 && j < t-result {
            result = i
        }
    }
    return result
}

//https://www.codewars.com/kata/54d7660d2daf68c619000d95/train/swift
//Shorten some code
func gcd2(_ k: (Int,Int)) -> Int {
    if k.0 <= 0 || k.1 <= 0 { return 0 }
//    var a = k.0 > k.1 ? k.0 : k.1
//    var b = k.0 > k.1 ? k.1 : k.0
//    var c = b
//    while a%b != 0 {
//        c = a%b
//        a = b
//        b = c
//    }
//    return c
    if k.0 < k.1 { return gcd2((k.1, k.0)) }
    if k.0%k.1 != 0 {
        return gcd2((k.1,k.0%k.1))
    } else {
        return k.1
    }
}

//Uoc chung lon nhat
func gcd(_ l: [Int]) -> Int {
//    var arr = l
//    while arr.count > 1 {
//        let a = arr.removeLast()
//        let b = arr.removeLast()
//        arr.append(gcd2((b, a)))
//    }
//    return arr[0]
    return l.reduce(1, { gcd2(($0, $1)) })
}

//Boi chung nho nhat
func lcm(_ l: [Int]) -> Int {
//    var arr = l
//    while arr.count > 1 {
//        let a = arr.removeLast()
//        let b = arr.removeLast()
//        arr.append(a*b/gcd2((b, a)))
//    }
//    return arr[0]
    return l.reduce(1, { $0*$1/gcd2(($0, $1)) })
}

func convertFracts(_ l: [(Int, Int)]) -> [(Int, Int)] {
    if l.count < 1 { return l }
    var arr = l
    //Reduce fractions
    for (index, frac) in l.enumerated() {
        let a = gcd2((frac.0,frac.1))
        if a > 1 {
            arr[index] = (frac.0/a, frac.1/a)
        }
    }
    //Get same denominator
    let i = lcm(arr.map({ $0.1 }))
    let result = arr.map({ (($0.0*i)/$0.1, i) })
    return result
}

//https://www.codewars.com/kata/54d496788776e49e6b00052f/train/swift
func sumOfDivided(_ l: [Int]) -> [(Int, Int)] {
    var result = [Int:Int]()
    for i in l {
        let j = i > 0 ? i : -i
        let factors = findFactor(num: j)
        let primeFactors = factors.filter({ findFactor(num: $0).count == 2 }) //Prime only have factor of 1 and itself
        for k in primeFactors {
            if let a = result[k] {
                result[k] = a+i
            } else {
                result[k] = i
            }
        }
    }
    let a = result.map({ ($0,$1) })
    return a.sorted(by: { $0.0 < $1.0 })
}

func findFactor(num: Int) -> [Int] {
    var factors = [Int]()
    for i in 1...Int(round(sqrt(Double(num)))) {
        if num%i == 0 {
            if Int(num/i) == i {
                factors.append(i)
            } else {
                factors.append(contentsOf: [Int(num/i), i])
            }
        }
    }
    return factors
}

//https://www.codewars.com/kata/5263c5d011f4233c9d000561/train/swift
func getLines(_ num:Int?) -> String {
    guard let num = num, num > 0 else { return "-1" }
    guard num > 1 else { return "1" }
    var result = ["1"]
    _=(1...num-1).map { result.append(getSay(result[$0-1])) }
    return result.joined(separator: ",")
}

func getSay(_ num: String) -> String {
    var counter = 0
    var result = ""
    var arr = num.map { String($0) }
    arr.append("")
    var char = arr[0]
    for i in arr {
        if char == i {
            counter+=1
        } else {
            result.append("\(counter)\(char)")
            char = i
            counter = 1
        }
    }
    return result
}

//https://leetcode.com/problems/multiply-strings/
func multiply(_ num1: String, _ num2: String) -> String {
    var result = Array(repeating: 0, count: num1.count + num2.count)
    let arr1 = num1.reversed()
    let arr2 = num2.reversed()
    
    for (i, a) in arr1.enumerated() {
        let a = Int(String(a))!
        var carry = 0
        for (j, b) in arr2.enumerated() {
            let b = Int(String(b))!
            let r = result[i + j] + a * b + carry
            result[i + j] = r % 10
            carry = r / 10
        }
        while carry > 0 {
            let r = result[i + num2.count] + carry
            result[i + num2.count] = r % 10
            carry = r / 10
        }
    }
    
    let resStr = result.reversed().dropFirst().map{ String($0) }.joined()
    return resStr.count > 0 ? resStr : "0"
}

//https://leetcode.com/problems/longest-substring-without-repeating-characters/
func lengthOfLongestSubstring(_ s: String) -> Int {
    var maxS = 0
    var curS = 0
    var indexDict = [String: Int]()
    var lastCut = 0
    for (i, c) in s.enumerated() {
        let c = String(c)
        if let cs = indexDict[c] {
            if cs >= lastCut {
                curS = i - cs
                lastCut = cs
            } else {
                curS+=1
            }
        } else {
            curS+=1
        }
        
        indexDict[c] = i
        
        if curS > maxS {
            maxS = curS
        }
    }
    return maxS
}
//: [Next](@next)
