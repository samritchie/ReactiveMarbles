import ReactiveCocoa
import ReactiveMarbles

//: ## `sampleOn()`
//: Sends the latest event from the source every time an event is sent on the trigger
//: Useful for using timers to sample irregular data & turn it into a regular event.

let source1 = marbleSignalProducer(irregularMarbleSignal(colour: .Random))
let source2 = marbleSignalProducer(marbleSignal(colour: .Single(.Red)))
let combined = source1.sampleOn(source2.map { _ in })
display("Source1", source1)
display("Source2", source2, showValue: false)
display("Combined", combined, showValue: true)

//: [Previous](@previous) | [Next](@next)
