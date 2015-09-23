import ReactiveCocoa
import ReactiveMarbles

//: ## `delay()`
//: Delays all events by a given interval

let source = marbleSignalProducer(marbleSignal(colour: .Random))
let delayed = source.delay(1.5.seconds, onScheduler:QueueScheduler(queue: dispatch_get_main_queue()))
display("Source", source)
display("Delayed", delayed)

//: [Previous](@previous) | [Next](@next)
