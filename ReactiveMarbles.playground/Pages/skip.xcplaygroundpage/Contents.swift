import ReactiveCocoa
import ReactiveMarbles

//: ## `skip()` & `take()`
//: Skips or (or takes) as specified number of events 

let signal = marbleSignalProducer(marbleSignal(colour: .Random))
let filtered = signal.skip(4)
display("Signal", signal)
display("Filtered", filtered)

//: [Previous](@previous) | [Next](@next)
