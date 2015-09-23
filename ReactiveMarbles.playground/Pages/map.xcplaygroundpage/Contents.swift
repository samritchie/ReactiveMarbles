import ReactiveCocoa
import ReactiveMarbles

//: ## `map()`
//: Transforms event values with a transform function

let source = marbleSignalProducer(marbleSignal(colour: .Random))
let doubled = source.map { m in Marble(colour: m.colour, value: m.value * 2) }
display("Source", source)
display("Doubled", doubled)

//: [Previous](@previous) | [Next](@next)
