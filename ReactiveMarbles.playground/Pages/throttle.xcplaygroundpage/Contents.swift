import ReactiveCocoa
import ReactiveMarbles

//: ## `throttle()`
//: Limits events to only one in a given interval

let source = marbleSignalProducer(marbleSignal(colour: .Random))
let throttled = source.throttle(3.seconds, onScheduler: QueueScheduler.mainQueueScheduler)
display("Source", source)
display("Throttled", throttled)

//: [Previous](@previous) | [Next](@next)
