import ReactiveCocoa
import ReactiveMarbles

//: ## `flatten(.Concat)`
//: Returns a single event producer that sends all the events from the inner producers sequentially.
//: (ie all events from the first producer, then all events from the second producer)

let source1 = marbleSignalProducer(.Red, count: 5)
let source2 = marbleSignalProducer(.Blue, count: 3)
let aggregateProducer = SignalProducer<SignalProducer<Marble, NoError>, NoError>(values: [source1, source2])
let flattened = aggregateProducer.flatten(.Concat)
display("Source1", source1)
display("Source2", source2)
display("Flattened", flattened)

//: [Previous](@previous) | [Next](@next)
