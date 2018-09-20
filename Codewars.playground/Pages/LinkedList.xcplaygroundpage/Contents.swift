//: Created by Tien Vu - tienvn3845@gmail.com
/*:
 # Linked list
 ___
 ## Others:
 1. [Normal](Normal)
 2. [Hard](Hard)
 */

import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

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
