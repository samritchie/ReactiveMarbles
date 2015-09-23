import ReactiveCocoa
import ReactiveMarbles

//: ## `filter()`
//: Filters events with a predicate

let signal = marbleSignal(colour: .Random)
let filtered = signal.filter { m in m.colour == .Purple }
display("Signal", signal)
display("Filtered", filtered)

//: [Previous](@previous) | [Next](@next)
