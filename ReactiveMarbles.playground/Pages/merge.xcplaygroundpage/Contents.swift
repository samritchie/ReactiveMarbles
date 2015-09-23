import ReactiveCocoa
import ReactiveMarbles

//: ## `flatten(.Merge)`
//: Returns a single event producer that sends all the events from the inner producers when they occur.

let source1 = marbleSignalProducer(irregularMarbleSignal(colour: .Random))
let source2 = marbleSignalProducer(irregularMarbleSignal(colour: .Random))
let aggregateProducer = SignalProducer<SignalProducer<Marble, NoError>, NoError>(values: [source1, source2])
let flattened = aggregateProducer.flatten(.Merge)
display("Source1", source1)
display("Source2", source2)
display("Flattened", flattened)

//: [Previous](@previous) | [Next](@next)
