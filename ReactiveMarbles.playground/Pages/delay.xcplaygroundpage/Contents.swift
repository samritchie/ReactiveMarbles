import ReactiveCocoa
import ReactiveMarbles

//: ## `delay()`
//: Delays all events by a given interval

let source = marbleSignalProducer(marbleSignal(colour: .Random))
let delayed = source.delay(1.5.seconds, onScheduler:QueueScheduler.mainQueueScheduler)
display("Source", source)
display("Delayed", delayed)

//: [Previous](@previous) | [Next](@next)
