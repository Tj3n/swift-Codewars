//: Created by Tien Vu - tienvn3845@gmail.com
/*:
 # Normal
 ___
 ## Others:
 1. [Hard](Hard)
 2. [Linked List](LinkedList)
 
 >Codewars only support Swift 3 for now.
 */
import Foundation
import PlaygroundSupport

//PlaygroundPage.current.needsIndefiniteExecution = true

//https://www.codewars.com/kata/55bf01e5a717a0d57e0000ec
func persistence(for num: Int) -> Int {
    var numString = "\(num)"
    var times = 0
    while numString.count > 1 {
        var val = 1
        for singleDigit in numString {
            val = val*Int(String(singleDigit))!
        }
        numString = "\(val)"
        times += 1
    }
    return times
}

//https://www.codewars.com/kata/58223370aef9fc03fd000071
func dashatize(_ number: Int) -> String {
    var numString = "\(number > 0 ? number : -number)"
    var dashatize = ""
    for singleDigit in numString {
        if Int(String(singleDigit))! % 2 == 0 {
            dashatize.append(singleDigit)
        } else {
            if dashatize.last == Character("-") {
                dashatize.append("\(String(singleDigit))-")
            } else {
                dashatize.append("-\(String(singleDigit))-")
            }
        }
    }
    return dashatize.trimmingCharacters(in: CharacterSet.init(charactersIn: "-"))
}

//https://www.codewars.com/kata/5552101f47fc5178b1000050
func digPow(for number: Int, using power: Int) -> Int {
    let numString = String(number)
    var total = 0
    var counter = power
    for digit in numString {
        total += Int(pow(Double(String(digit))!,Double(counter)))
        counter += 1
    }
    return total % number == 0 ? total/number : -1
}

//https://www.codewars.com/kata/57f36495c0bb25ecf50000e7
func findSum(_ n: Int) -> Int {
    let a = 3
    let b = 5
    var m = 1
    var total = 0
    while a*m <= n {
        total += a*m
        m += 1
    }
    m = 0
    while b*m <= n {
        total += b*m
        m += 1
    }
    return total
}

//https://www.codewars.com/kata/5467e4d82edf8bbf40000155
func descendingOrder(of number: Int) -> Int {
    let sortedCharacters = String(number).sorted { $0 > $1 }
    return Int(String(sortedCharacters))!
}

//https://www.codewars.com/kata/5667e8f4e3f572a8f2000039
func accum(_ s: String) -> String {
    return s.enumerated().map { (index, element) in
        return String(element).uppercased().padding(toLength: index+1, withPad: String(element).lowercased(), startingAt: 0)
        }.joined(separator: "-")
}

//https://www.codewars.com/kata/57aa218e72292d98d500240f
func heron(_ a: Double, _ b: Double, _ c: Double) -> Double {
    let s = (a + b + c) / 2
    return sqrt(s*(s - a)*(s - b) * (s - c))
}

//https://www.codewars.com/kata/53da3dbb4a5168369a0000fe
func evenOrOdd(_ number:Int) -> String {
    return number % 2 == 0 ? "Even" : "Odd"
}

//https://www.codewars.com/kata/5583090cbe83f4fd8c000051
func digitize(_ num:Int) -> [Int] {
    return String(num).map({ Int(String($0))! }).reversed()
}

//https://www.codewars.com/kata/577b9960df78c19bca00007e
func findDigit(_ num:Int, _ nth: Int) -> Int {
    guard nth > 0 else {
        return -1
    }
    let numString = String(num)
    guard numString.count >= nth else { return 0 }
    if let i = Int(String(numString[numString.index(numString.endIndex, offsetBy: -nth)])) {
        return i
    } else {
        return 0
    }
}

//https://www.codewars.com/kata/5813d19765d81c592200001a
func dontGiveMeFive(_ start: Int, _ end: Int) -> Int {
    return (start...end).filter({ !String($0).contains("5") }).count
}

//https://www.codewars.com/kata/52761ee4cffbc69732000738
func evaluate(good: String, vsEvil evil: String) -> String {
    let goodForce = good.components(separatedBy: " ").enumerated().map { (index, element) -> Int in
        switch index {
        case 1:
            return Int(String(element))!*2
        case 2,3:
            return Int(String(element))!*3
        case 4:
            return Int(String(element))!*4
        case 5:
            return Int(String(element))!*10
        default:
            return Int(String(element))!
        }
        }.reduce(0, +)
    
    let evilForce = evil.components(separatedBy: " ").enumerated().map { (index, element) -> Int in
        switch index {
        case 1,2,3:
            return Int(String(element))!*2
        case 4:
            return Int(String(element))!*3
        case 5:
            return Int(String(element))!*5
        case 6:
            return Int(String(element))!*10
        default:
            return Int(String(element))!
        }
        }.reduce(0, +)
    
    return goodForce == evilForce ? "Battle Result: No victor on this battle field" : goodForce > evilForce ? "Battle Result: Good triumphs over Evil" : "Battle Result: Evil eradicates all trace of Good"
}

//https://www.codewars.com/kata/5592e3bd57b64d00f3000047
func findNb(_ number: Int) -> Int {
    var total = 0
    for i in 1...number {
        total +=  Int(pow(Double(i), 3))
        if total == number {
            return i
        } else if total > number {
            return -1
        }
    }
    
    return 0
}

//https://www.codewars.com/kata/5503013e34137eeeaa001648
func diamond(_ size: Int) -> String? {
    guard size > 0 && size % 2 != 0 else { return nil }
    var a = ""
    for i in stride(from: 1, through: size, by: 2) {
        var sub = ""
        if i != size {
            for _ in 1...2 {
                sub += String(repeatElement(" ", count: (size-i)/2)) + String(repeatElement("*", count: i)) + "\n"
            }
        } else {
            sub += String(repeatElement("*", count:  i)) + "\n"
        }
        a.insert(contentsOf: sub, at: a.index(a.startIndex, offsetBy: (a.count+1)/2))
    }
    return a
}

//https://www.codewars.com/kata/525e5a1cb735154b320002c8
func triangular(_ n: Int) -> Int{
    if n <= 0 {
        return 0
    }
    var result = 0
    var track = 0
    while track < n {
        track += 1
        result += track
    }
    return result
}

//https://www.codewars.com/kata/5842df8ccbd22792a4000245/train/swift
func expandedForm(_ num: Int) -> String {
    var expandStr = ""
    for (index, numChar) in String(num).enumerated() {
        if Int(String(numChar)) != 0 {
            expandStr += (" + " + String(numChar) + String(repeatElement("0", count: String(num).count-index-1)))
        }
    }
    return expandStr.substring(from: expandStr.index(expandStr.startIndex, offsetBy: 3))
}

//https://www.codewars.com/kata/5853213063adbd1b9b0000be/train/swift
enum Direction {
    case up, down, left, right
}

func streetFighterSelection(fighters: [[String]], position: (row: Int, column: Int), moves: [Direction]) -> [String] {
    var row = position.row
    var col = position.column
    let charList = moves.map { (move) -> String in
        switch move {
        case .up:
            row = 0
        case .down:
            row = 1
        case .left:
            col = col == 0 ? fighters[row].count - 1 : col-1
        case .right:
            col = col == fighters[row].count - 1 ? 0 : col+1
        }
        return fighters[row][col]
    }
    return charList
}

//https://www.codewars.com/kata/street-fighter-2-character-selection-part-2/swift
func superStreetFighterSelection(fighters: [[String]], position: (row: Int, column: Int), moves: [Direction]) -> [String] {
    var row = position.row
    var col = position.column
    let charList = moves.map { (move) -> String in
        var tempRow = row
        var tempCol = col
        switch move {
        case .up:
            tempRow = tempRow - 1 >= 0 ? tempRow-1 : 0
        case .down:
            tempRow = tempRow + 1 <= fighters.count-1 ? tempRow+1 : fighters.count-1
        case .left:
            tempCol = tempCol == 0 ? fighters[row].count - 1 : tempCol-1
            while fighters[row][tempCol] == "" {
                tempCol = tempCol == 0 ? fighters[row].count - 1 : tempCol-1
            }
            return fighters[row][tempCol]
        case .right:
            tempCol = tempCol == fighters[row].count - 1 ? 0 : tempCol+1
            while fighters[row][tempCol] == "" {
                tempCol = tempCol == fighters[row].count - 1 ? 0 : tempCol+1
            }
            return fighters[row][tempCol]
        }
        
        if fighters[tempRow][tempCol] == "" {
            return fighters[row][col]
        } else {
            row = tempRow
            col = tempCol
            return fighters[tempRow][tempCol]
        }
    }
    return charList
}

func condense(_ num: Int) -> String {
    let n = num < 0 ? -num : num
    var numStr = String(n)
    let (dotIndex, tag) = n < 1000000000000 ? n < 1000000000 ? n < 1000000 ? n < 1000 ? (0, "") : (-3,"k") : (-6,"m") : (-9,"b") : (-12,"t")
    numStr.insert(".", at: numStr.index(numStr.endIndex, offsetBy: dotIndex))
    return tag == "" ? String(num) : num > 0 ? String(format: "%.1f", Double(numStr)!) + tag : "-" + String(format: "%.1f", Double(numStr)!) + tag
}

func fizzBuzzCuckooClock(_ time: String) -> String {
    let timeArray = time.components(separatedBy: ":")
    let min = Int(timeArray[1])!
    if min == 0 {
        var hr = Int(timeArray[0])!
        hr = hr > 12 ? hr - 12 : hr
        return String(repeating: "Cuckoo ", count: hr).trimmingCharacters(in: .whitespaces)
    } else if min == 30 {
        return "Cuckoo"
    } else if min % 3 == 0 && min % 5 == 0 {
        return "Fizz Buzz"
    } else if min % 3 == 0 {
        return "Fizz"
    } else if min % 5 == 0 {
        return "Buzz"
    }
    return "tick"
}

//https://www.hackerrank.com/challenges/abbr
func abbreviation(input: String, abbreviation: String) -> Bool {
    let inputCharArrayCap = input.map({String($0).capitalized})
    let abbCharArray = abbreviation.map({String($0)})
    
    let similar = abbCharArray.filter({inputCharArrayCap.contains($0)})
    if similar.count != abbreviation.count { return false }
    
    var similarInInput = inputCharArrayCap.filter({abbCharArray.contains($0)})
    
    var i = 0
    var indexToRemove = [Int]()
    for char in abbCharArray {
        while i < similarInInput.count {
            if similarInInput[i] != char {
                indexToRemove.append(i)
                i+=1
            } else {
                i+=1
                break
            }
        }
    }
    
    if i < similarInInput.count - 1 {
        similarInInput.removeSubrange(i...similarInInput.count-1)
    }
    
    for j in indexToRemove.reversed() {
        similarInInput.remove(at: j)
    }
    
    similarInInput.joined()
    return true
}


//https://www.codewars.com/kata/550f22f4d758534c1100025a/train/swift
//Not optimized, keep adding dirrection to new array and remove last if next value is opposite
func dirReduc(_ arr: [String]) -> [String] {
    var result = checkDir(arr: arr)
    var before = result.count
    var after = 0

    while before != after {
        before = after > 0 ? after : before
        result = checkDir(arr: result)
        after = result.count
    }
    
    return result
}

func checkDir(arr: [String]) -> [String] {
    var result = arr
    var toRemove = [Int]()
    for (i,dir) in arr.enumerated() {
        
        guard i < arr.count-1 && !toRemove.contains(i) else { break }
        
        switch dir {
        case "NORTH":
            if arr[i+1] == "SOUTH" {
                toRemove.append(contentsOf: [i,i+1])
            }
        case "SOUTH":
            if arr[i+1] == "NORTH" {
                toRemove.append(contentsOf: [i,i+1])
            }
        case "EAST":
            if arr[i+1] == "WEST" {
                toRemove.append(contentsOf: [i,i+1])
            }
        case "WEST":
            if arr[i+1] == "EAST" {
                toRemove.append(contentsOf: [i,i+1])
            }
        default:
            break
        }
    }
    
    for i in toRemove.sorted().reversed() {
        result.remove(at: i)
    }
    return result
}

//https://www.codewars.com/kata/564057bc348c7200bd0000ff/train/swift
func thirt(_ n: Int) -> Int {
    let pttr = [1, 10, 9, 12, 3, 4]
    var numStr = String(n)
    while numStr.count > 2 {
        let a = numStr.reversed().map({Int(String($0))!}).enumerated().reduce(0) { (result, val) -> Int in
            return result + val.element*pttr[val.offset%6]
        }
        numStr = String(a)
    }
    return Int(numStr)!
}

//https://www.codewars.com/kata/550498447451fbbd7600041c/train/swift
func comp(_ a: [Int], _ b: [Int]) -> Bool {
    guard a.count > 0 && b.count > 0 || a.count == 0 && b.count == 0 else { return false }
    var d = b
    let c = a.map({ $0*$0 })
    c.forEach({
        if d.contains($0) {
            d.remove(at: d.firstIndex(of: $0)!)
        }
    })
    return d.count == 0
}

//https://www.codewars.com/kata/55e2adece53b4cdcb900006c/train/swift
//calculate from sec is better than from hr
func race(_ v1: Int, _ v2: Int, _ g: Int) -> [Int]? {
    guard v2 >= v1 else { return nil }
    let h = Double(g)/Double(v2-v1)
    let m = h.truncatingRemainder(dividingBy: 1)*60
    let s = m.truncatingRemainder(dividingBy: 1)*60
    var time = [h,m,s]
    for (index, i) in time.enumerated() {
        if i.truncatingRemainder(dividingBy: 1) > 0.99 {
            time[index-1] = round(i) == 60.0 ? round(time[index-1]) : time[index-1]
            time[index] = round(i) == 60.0 ? 0 : round(i)
        }
    }
    return [Int(time[0]), Int(time[1]), Int(time[2])]
}

//https://www.codewars.com/kata/5616868c81a0f281e500005c/train/swift
func rank(_ st: String, _ we: [Int], _ n: Int) -> String {
    let xs = (0..<26).map({Character(UnicodeScalar("a".unicodeScalars.first!.value + $0)!)})
    guard st.count > 0 else { return "No participants" }
    let list = st.components(separatedBy: ",")
    guard list.count >= n else { return "Not enough participants" }
    let ranked = list.enumerated().map { (index, name) -> (String, Int) in
        return (name, we[index]*(name.count + name.lowercased().reduce(0, { ($0+1)+xs.firstIndex(of: $1)! })))
        }.sorted { (first, second) -> Bool in
            if first.1 != second.1 {
                return first.1 > second.1
            } else {
                return first.0 < second.0
            }
    }
    return ranked[n-1].0
}

//https://www.codewars.com/kata/56a32dd6e4f4748cc3000006/train/swift
func mean(_ d : String, _ town: String) -> Double {
    guard let vals = getVals(d, town) else { return -1 }
    let mean = vals.reduce(0.0, +)/Double(vals.count)
    return mean
}

func variance(_ d : String, _ town: String) -> Double {
    guard let vals = getVals(d, town) else { return -1 }
    let avg = mean(d, town)
    let variance = vals.reduce(0.0, { $0+(pow((avg-$1), 2)) })/Double(vals.count)
    return variance
}

func getVals(_ d : String, _ town: String) -> [Double]? {
    let towns = d.components(separatedBy: "\n")
    let townStr = towns.filter({ $0.components(separatedBy: ":")[0] == town })
    guard townStr.count > 0 else { return nil }
    let months = townStr[0].components(separatedBy: ",")
    let vals = months.map({ Double($0.components(separatedBy: " ")[1])! })
    return vals
}

//https://www.codewars.com/kata/554a44516729e4d80b000012/train/swift
func nbMonths(_ startPriceOld: Int, _ startPriceNew: Int, _ savingPerMonth: Int, _ percentLossByMonth: Double) -> (Int, Int) {
    guard startPriceNew > startPriceOld else { return (0, startPriceOld-startPriceNew) }
    
    var loss = percentLossByMonth
    var old = Double(startPriceOld)
    var new = Double(startPriceNew)
    var saving = 0.0
    var month = 0
    
    while new - old - saving > 0 {
        if month % 2 != 0 {
            loss += 0.5
        }
        new -= new*(loss/100)
        old -= old*(loss/100)
        saving += Double(savingPerMonth)
        month += 1
    }
    
    return (month, Int(round(old + saving - new)))
}

//https://www.codewars.com/kata/toleetspeak/train/swift
func toLeetSpeak(_ s : String) -> String {
    let list = ["A" : "@","B" : "8","C" : "(","E" : "3","G" : "6","H" : "#","I" : "!","L" : "1","O" : "0","S" : "$","T" : "7","Z" : "2"]
    return s.map({ list[String($0)] ?? String($0) }).joined()
}

//https://www.codewars.com/kata/56a5d994ac971f1ac500003e/train/swift
func longestConsec(_ strarr: [String], _ k: Int) -> String {
    guard k <= strarr.count else { return "" }
    var longest = 0
    var result = ""
    for i in 0...(strarr.count - k) {
        let total = (0..<k).reduce(0, { $0+strarr[i+$1].count })
        if total > longest {
            longest = total
            result = (0..<k).reduce("", { $0+strarr[i+$1] })
        }
    }
    return result
}

//https://www.codewars.com/kata/556deca17c58da83c00002db/train/swift
func tribonacci(_ signature: [Int], _ n: Int) -> [Int] {
    var result = signature
    guard n > 3 else {
        result.removeSubrange(n..<3)
        return result
    }
    for i in 3..<n {
        result.append(result[i-1]+result[i-2]+result[i-3])
    }
    return result
}

//https://www.codewars.com/kata/54dc6f5a224c26032800005c/train/swift
func stockList(_ listOfArt: [String], _ listOfCat: [String]) -> String {
    if listOfArt.count == 0 { return "" }
    let result = listOfCat.map { (char) -> String in
        var val = 0
        for art in listOfArt {
            if String(art.first!) == char {
                val+=Int(art.components(separatedBy: " ")[1])!
            }
        }
        return "(\(char) : \(val))"
    }
    return result.joined(separator: " - ")
}

//https://www.codewars.com/kata/5544c7a5cb454edb3c000047/train/swift
func bouncingBall(_ h: Double, _ bounce: Double, _ window: Double) -> Int {
    if bounce >= 1 || bounce <= 0 { return -1 }
    var times = 1
    var height = h
    while height*bounce > window {
        height*=bounce
        times+=2
    }
    return times == 1 ? -1 : times
}

//https://www.codewars.com/kata/5227129b316b56d50d0003b7/train/swift
func flattenTwoLevels(_ arr:[Any]) -> [Any] {
    return arr.map {
        if let i: [Any] = $0 as? [Any] {
            return flattenOneLevel(i)
        }
        return $0
    }
}

func flattenOneLevel(_ arr:[Any]) -> [Any] {
    var result = [Any]()
    for k in arr {
        if let j: [Any] = k as? [Any] {
            result.append(contentsOf: flattenOneLevel(j))
        } else {
            result.append(k)
        }
    }
    return result
}

//https://www.codewars.com/kata/weight-for-weight/
func orderWeight(_ s: String) -> String {
    let arr = s.components(separatedBy: " ")
    let result = arr.sorted { (first, second) -> Bool in
        let a = first.reduce(0, { Int(String($0))! + Int(String($1))! })
        let b = second.reduce(0, { Int(String($0))! + Int(String($1))! })
        return a == b ? first < second : a < b
    }
    return result.joined(separator: " ")
}

//https://www.codewars.com/kata/fold-an-array
func foldArray(_ arr: [Int], times: Int) -> [Int] {
    var time = times
    var arr = arr
    while time > 0 {
        let counter = arr.count - 1
        for i in 0...counter/2 {
            arr[i] = i == counter-i ? arr[i] : arr[i]+arr[counter-i]
        }
        time -= 1
        if (counter/2+1 <= counter) {
            arr.removeSubrange(counter/2+1...counter)
        }
    }
    return arr
}

//https://www.codewars.com/kata/sum-of-digits-slash-digital-root/train/swift
func digitalRoot(of number: Int) -> Int {
    var num = String(number)
    while num.count > 1 {
        num = String(num.reduce(0, { $0+Int(String($1))! }))
    }
    return Int(num)!
}

//https://www.codewars.com/kata/5541f58a944b85ce6d00006a
func fib(_ n: UInt64) -> UInt64 {
    if n == 0 { return 0 }
    if n == 1 { return 1 }
    return (fib(n-1)+fib(n-2))
}

//Unoptimize
func productFib(_ prod : UInt64) -> (UInt64,UInt64,Bool) {
    var a = UInt64(1)
    
    func estimateFib(_ n: UInt64) -> UInt64 {
        return UInt64((pow(((1.0 + sqrt(5.0))/2.0), Double(n))/sqrt(5.0)).rounded())
    }
    
    var c = estimateFib(a)
    var d = estimateFib(a+1)
    while c*d < prod {
        a+=1
        c = estimateFib(a)
        d = estimateFib(a+1)
    }
    
    return c*d == prod ? (c, d, true) : (c, d, false)
}

//https://www.codewars.com/kata/triangle-number-check
func isTriangleNumber(_ number: Int) -> Bool {
    var a = 0
    var b = 1
    while a < number {
        a+=b
        b+=1
    }
    return a==number
}

//https://www.codewars.com/kata/find-the-parity-outlier/train/swift
func findOutlier(_ array: [Int]) -> Int {
    return array[0...2].filter({$0 % 2 != 0}).count > 1 ? array.filter({ $0 % 2 == 0 }).first! : array.filter({ $0 % 2 != 0 }).first!
}

//https://www.codewars.com/kata/what-century-is-it/train/swift
func whatCentury(_ year: String) -> String {
    let a = Int(ceil(Double(year)!/100.0))
    if a == 11 || a == 12 {
        return "\(a)th"
    } else if a%10 == 1 {
        return "\(a)st"
    } else if a%10 == 2 {
        return "\(a)nd"
    } else if a%10 == 3 {
        return "\(a)rd"
    } else {
        return "\(a)th"
    }
//    return a == 11 || a == 12 ? "\(a)th" : a%10 == 1 ? "\(a)st" : a%10 == 2 ? "\(a)nd" : a%10 == 3 ? "\(a)rd" : "\(a)th"
}

//https://www.codewars.com/kata/599bb194b7a047b04d000077/train/swift
func howManyPizzas(_ n: Int) -> String {
    let pizza = pow(Double(n)/2.0,2.0)/(pow(4.0, 2.0)*(45/360))
    return "pizzas: \(Int(pizza/8)), slices: \(Int(pizza)%8)"
}

//https://www.codewars.com/kata/56cac350145912e68b0006f0/train/swift
func arrange(_ s: String) -> String {
    var arr = s.split(separator: " ")
//    var arr = s.components(separatedBy: " ")
    (0...arr.count-2).forEach {
        if ($0%2 == 0 && arr[$0].count > arr[$0+1].count) || ($0%2 != 0 && arr[$0].count < arr[$0+1].count) {
            arr.swapAt($0, $0+1)
//            swap(&arr[$0], &arr[$0+1])
        }
    }
    return arr.enumerated().map({ $0%2 == 0 ? $1.lowercased() : $1.uppercased() }).joined(separator: " ")
}

//https://www.codewars.com/kata/find-the-missing-term-in-an-arithmetic-progression/train/swift
func findMissing(_ l:[Int]) -> Int {
    let isProgressing = l[1] > l[0]
    var progressingValue = 0
    var result = 0
    
    for i in 0..<l.count-1 {
        let progressing = l[i+1]-l[i]
        if progressingValue == 0 {
            progressingValue = progressing
        }
        
        if progressing > progressingValue {
            result = isProgressing ? l[i]+progressingValue : l[i]-progressing
            break
        } else if progressing < progressingValue {
            result = isProgressing ? l[i]-progressing : l[i]+progressingValue
            break
        }
    }
    
    return result
}

func reverseRect(n: Int) {
    var count = 1
    var d = 0
    var row = n-1
    var col = n-1
    var result = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
    
    //Use stride to prevent exception with range up > low
    while d <= n/2 {
        //left to right col
        for i in stride(from: d, through: col, by: 1) {
            result[d][i] = count
            count+=1
        }
        
        //top to down row
        for i in stride(from: d+1, through: row, by: 1) {
            result[i][col] = count
            count+=1
        }

        //right to left col
        for i in stride(from: col-1, through: d, by: -1) {
            result[row][i] = count
            count+=1
        }

        //down to up row
        for i in stride(from: row-1, to: d, by: -1) {
            result[i][d] = count;
            count+=1
        }

        d+=1
        row-=1
        col-=1
    }
    
    for i in result {
        print(i)
    }
}
//reverseRect(n: 4)
//reverseRect(n: 3)
//reverseRect(n: 6)
