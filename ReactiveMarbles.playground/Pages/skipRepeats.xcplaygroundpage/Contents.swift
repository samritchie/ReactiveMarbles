import ReactiveCocoa
import ReactiveMarbles

//: ## `skipRepeats()`
//: Removes (consecutive) duplicates based on equality test

let source = marbleSignalProducer(marbleSignal(colour: .Random))
let filtered = source.skipRepeats { a, b in a.colour == b.colour }
display("Source", source)
display("Filtered", filtered)

//: [Previous](@previous) | [Next](@next)
