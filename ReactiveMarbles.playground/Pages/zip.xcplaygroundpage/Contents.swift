import ReactiveCocoa
import ReactiveMarbles

//: ## `zipWith()`
//: Sends a tuple like `combineLatest`, but matches up events by sequence number

let source1 = marbleSignalProducer(irregularMarbleSignal(colour: .Random))
let source2 = marbleSignalProducer(irregularMarbleSignal(colour: .Random))
let zipped = source1.zipWith(source2)
display("Source1", source1)
display("Source2", source2)
display("Zipped", zipped)

//: [Previous](@previous) | [Next](@next)
