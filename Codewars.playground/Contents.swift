//: Created by Tien Vu - tienvn3845@gmail.com

import UIKit

//: Linked list


enum SomeError: Error {
    case outOfBounds
    case invalidSplit
    case emptyList
}

class Node {
    var data: Int
    var next: Node?
    init(_ data: Int) {
        self.data = data
    }
}

struct Context {
    var source:Node?
    var dest:Node?
}

//https://www.codewars.com/kata/55beec7dd347078289000021
func length(_ head: Node?) -> Int {
    var length = 0
    
    var node = head
    while node != nil {
        length += 1
        node = node!.next
    }
    return length
}

//https://www.codewars.com/kata/55beec7dd347078289000021
func count(_ head: Node?, _ data: Int) -> Int {
    var count = 0
    var node = head
    while node != nil {
        if node?.data == data {
            count += 1
        }
        node = node!.next
    }
    return count
}

//http://www.codewars.com/kata/linked-lists-push-and-buildonetwothree
func push(_ head:Node?, _ data:Int) -> Node {
    if let head = head {
        let pushed = Node(data)
        pushed.next = head
        return pushed
    } else {
        return Node(data)
    }
}

//http://www.codewars.com/kata/linked-lists-push-and-buildonetwothree
func buildOneTwoThree() -> Node {
    let final = Node(0)
    var current = final
    for i in 1...3 {
        current.next = Node(i)
        current = current.next!
    }
    return final.next!
}

func buildListFromArray(_ array: [Int]) -> Node {
    var node: Node?
    for data in array.reversed() {
        node = push(node, data)
    }
    return node!
}

//http://www.codewars.com/kata/linked-lists-get-nth-node
func getNth(_ head: Node?, _ index: Int) throws -> Node? {
    var current = head
    if index < 0 { throw SomeError.outOfBounds }
    guard index >= 1 else { return current }
    for _ in 1...index {
        current = current!.next
        guard current != nil else {
            throw SomeError.outOfBounds
        }
    }
    
    return current
}

//https://www.codewars.com/kata/55cacc3039607536c6000081
func insertNth(_ head: Node?, _ index: Int, _ data: Int) throws -> Node? {
    let start = Node(0)
    var current = start
    var a = head
    var counter = 0
    var changed = false
    if index < 0 { throw SomeError.outOfBounds }
    guard index >= 1 else { return push(head, data) }
    
    while a != nil {
        if counter == index {
            current.next = Node(data)
            current = current.next!
            changed = true
        } else {
            current.next = Node(a!.data)
            current = current.next!
            a = a!.next
        }
        counter += 1
    }
    if counter == index {
        current.next = Node(data)
        changed = true
    }
    guard changed else { throw SomeError.outOfBounds }
    return start.next
}

//https://www.codewars.com/kata/55cc33e97259667a08000044
//Not optimized, create node with data and iliterate through head with current and prev
func sortedInsert(_ head: Node?, _ data: Int) -> Node? {
    let start = Node(0)
    var current = start
    var a = head
    var inserted = false
    guard head != nil else { return push(head, data) }
    
    while a != nil {
        if a!.data > data {
            current.next = Node(data)
            current = current.next!
            inserted = true
            current.next = a
            break
        }
        current.next = Node(a!.data)
        current = current.next!
        a = a!.next
    }
    
    if inserted == false {
        current.next = Node(data)
    }
    return start.next
}

//https://www.codewars.com/kata/55d0c7ee7c0d30a12b000045
func insertSort(head: Node?) -> Node? {
    var current: Node?
    var a = head
    while a != nil {
        current = sortedInsert(current, a!.data)
        a = a!.next
    }
    return current
}

//https://www.codewars.com/kata/55d9f257d60c5fd98d00001b
func removeDuplicates(head:Node?) -> Node? {
    var current = head
    var prev: Node?
    
    while current != nil {
        if prev?.data == current?.data {
            prev?.next = current?.next
        } else {
            prev = current
        }
        current = current!.next
    }
    
    return head
}

//https://www.codewars.com/kata/55da347204760ba494000038
func moveNode(source:Node?, dest:Node?) throws -> Context? {
    guard source != nil else { throw SomeError.emptyList }
    return Context(source: source?.next, dest: push(dest, source!.data))
}

//https://www.codewars.com/kata/55e72695870aae78c4000026
func reverse(list:inout Node?) {
    var result: Node?
    var a = list
    
    while a != nil {
        result = push(result, a!.data)
        a = a!.next
    }
    
    list = result
}

//https://www.codewars.com/kata/55e725b930957a038a000042
func recursiveReverse(list:Node?) -> Node? {
    var current: Node?
    var a = list
    
    while a != nil {
        current = push(current, a!.data)
        a = a!.next
    }
    
    return current
}

//https://www.codewars.com/kata/55e5253dcd20f821c400008e
func shuffleMerge(first: Node?, second: Node?) -> Node? {
    let merged = Node(0)
    var current = merged
    var a = first
    var b = second
    var switched = false
    while a != nil && b != nil {
        if switched {
            current.next = b
            b = b!.next
        } else {
            current.next = a
            a = a!.next
        }
        current = current.next!
        switched = !switched
    }
    current.next = ( a != nil ? a : b)
    return merged.next
}

//https://www.codewars.com/kata/55e5d31bf7ca1e44980000a7
func sortedMerge(first:Node?, second:Node?) -> Node? {
    let dummyHead = Node(0)
    var current = dummyHead
    var a = first
    var b = second
    
    while a != nil && b != nil {
        if a!.data <= b!.data {
            current.next = a
            a = a!.next
        } else {
            current.next = b
            b = b!.next
        }
        current = current.next!
    }
    current.next = ( a != nil ? a : b)
    return dummyHead.next
}

//https://www.codewars.com/kata/55e1d2ba1a3229674d000037
func frontBackSplit(source: Node?, front: inout Node?, back: inout Node?) throws {
    guard source != nil else { throw SomeError.invalidSplit }
    back = source
    front = source
    var currentFront = front
    
    while back != nil {
        for _ in 1...2 {
            back = back?.next
            guard back != nil else {
                back = currentFront?.next
                currentFront?.next = nil
                guard front != nil && back != nil else { throw SomeError.invalidSplit }
                return
            }
        }
        currentFront = currentFront?.next
    }
}

//https://www.codewars.com/kata/55e5fa3501fd9c3f4d000050
func mergeSort(_ list:Node?) -> Node? {
    var a: Node?
    var b: Node?
    do {
        try frontBackSplit(source: list, front: &a, back: &b)
        a = a?.next != nil ? mergeSort(a) : a
        b = b?.next != nil ? mergeSort(b) : b
        return sortedMerge(first: a, second: b)
    } catch _ {
        return list
    }
}

//https://www.codewars.com/kata/55dd5386575839a74f0000a9
func alternatingSplit(head:Node?) throws -> Context? {
    let aHead = Node(0)
    let bHead = Node(0)
    var a = aHead
    var b = bHead
    var current = head
    var counter = 1
    while current != nil {
        if counter % 2 == 0 {
            a.next = Node(current!.data)
            current = current!.next
            a = a.next!
        } else {
            b.next = Node(current!.data)
            current = current!.next
            b = b.next!
        }
        counter += 1
    }
    guard aHead.next != nil && bHead.next != nil else {
        throw SomeError.invalidSplit
    }
    return Context(source: aHead.next, dest: bHead.next)
}

//https://www.codewars.com/kata/55e67e44bf97fa66900000a0
func SortedIntersect(first:Node?, second:Node?) -> Node? {
    var a = first
    var b = second
    let result = Node(0)
    var currentResult = result
    
    while a != nil && b != nil {
        if a!.data == b!.data {
            if currentResult.data != a!.data {
                currentResult.next = Node(a!.data)
                currentResult = currentResult.next!
            }
            a = a?.next
            b = b?.next
        } else if a!.data > b!.data {
            b = b?.next
        } else {
            a = a?.next
        }
    }
    return result.next
}

//: Others

//https://www.codewars.com/kata/55bf01e5a717a0d57e0000ec
func persistence(for num: Int) -> Int {
    var numString = "\(num)"
    var times = 0
    while numString.characters.count > 1 {
        var val = 1
        for singleDigit in numString.characters {
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
    for singleDigit in numString.characters {
        if Int(String(singleDigit))! % 2 == 0 {
            dashatize.append(singleDigit)
        } else {
            if dashatize.characters.last == Character("-") {
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
    for digit in numString.characters {
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
    let sortedCharacters = String(number).characters.sorted { $0 > $1 }
    return Int(String(sortedCharacters))!
}

//https://www.codewars.com/kata/5667e8f4e3f572a8f2000039
func accum(_ s: String) -> String {
    return s.characters.enumerated().map { (index, element) in
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
    return String(num).characters.map({ Int(String($0))! }).reversed()
}

//https://www.codewars.com/kata/577b9960df78c19bca00007e
func findDigit(_ num:Int, _ nth: Int) -> Int {
    guard nth > 0 else {
        return -1
    }
    let numString = String(num)
    guard numString.characters.count >= nth else { return 0 }
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
        a.insert(contentsOf: sub.characters, at: a.index(a.startIndex, offsetBy: (a.characters.count+1)/2))
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
    for (index, numChar) in String(num).characters.enumerated() {
        if Int(String(numChar)) != 0 {
            expandStr += (" + " + String(numChar) + String(repeatElement("0", count: String(num).characters.count-index-1)))
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

//https://www.hackerrank.com/challenges/abbr
func abbreviation(input: String, abbreviation: String) -> Bool {
    let inputCharArrayCap = input.characters.map({String($0).capitalized})
    let abbCharArray = abbreviation.characters.map({String($0)})
    
    let similar = abbCharArray.filter({inputCharArrayCap.contains($0)})
    if similar.count != abbreviation.characters.count { return false }
    
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

//https://www.codewars.com/kata/salesmans-travel/train/swift
func travel(_ r: String, zipcode: String) -> String {
    
    guard zipcode.characters.count == 8 else { return "\(zipcode):/" }
    
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
        let result = regex.matches(in: text, options: [], range: NSMakeRange(0, text.characters.count))
        return result.map { nsString.substring(with: $0.range) }
    } catch let error {
        print("invalid regex: \(error.localizedDescription)")
        return []
    }
}


//https://www.codewars.com/kata/first-variation-on-caesar-cipher/train/swift
func movingShift(_ s: String, _ shift: Int) -> [String] {
    
    let cipher = caesarShift(string: s, shift: shift, reverse: false)
    let stringArr = cipher.characters.map({ String($0) })
    
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
    var stringArr = string.characters.map({ String($0) })
    
    var letters = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    var uLetters = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    if reverse {
        letters = Array(letters.reversed())
        uLetters = Array(uLetters.reversed())
    }
    
    for (i, char) in stringArr.enumerated() {
        if letters.contains(char) {
            if letters.index(of: char)!+shifted >= letters.count {
                stringArr[i] = letters[(letters.index(of: char)!+shifted)-letters.count]
            } else {
                stringArr[i] = letters[letters.index(of: char)!+shifted]
            }
            
        } else if uLetters.contains(char) {
            if uLetters.index(of: char)!+shifted >= uLetters.count {
                stringArr[i] = uLetters[(uLetters.index(of: char)!+shifted)-uLetters.count]
            } else {
                stringArr[i] = uLetters[uLetters.index(of: char)!+shifted]
            }
        }
        
        shifted+=1
        
        if shifted > 25 {
            shifted = 0
        }
    }
    
    return stringArr.joined()
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
