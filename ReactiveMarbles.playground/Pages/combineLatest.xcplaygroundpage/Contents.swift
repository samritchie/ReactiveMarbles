import ReactiveCocoa
import ReactiveMarbles

//: ## `combineLatestWith()`
//: Sends a tuple of the latest events from each `SignalProducer`.
//: Operates on a `SignalProducer<SignalProduce<T, E>>`

let source1 = marbleSignalProducer(irregularMarbleSignal(colour: .Random))
let source2 = marbleSignalProducer(irregularMarbleSignal(colour: .Random))
let combined = source1.combineLatestWith(source2)
display("Source1", source1)
display("Source2", source2)
display("Combined", combined)

//: [Previous](@previous) | [Next](@next)
