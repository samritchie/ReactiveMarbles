//
//  PlaygroundSupport.swift
//  ReactiveMarbles
//
//  Created by Sam Ritchie on 16/09/2015.
//  Copyright © 2015 codesplice pty ltd. All rights reserved.
//

import Foundation
import SpriteKit
import XCPlayground
import ReactiveCocoa

public func display(name: String, _ signal: Signal<Marble, NoError>, showValue: Bool = true) {
    let container = SKView(frame: CGRect(x: 0, y: 0, width: 500, height: 100))
    XCPShowView(name, view: container )
    container.presentScene(MarbleScene(signal: signal, size: container.bounds.size, showValue: showValue))
}

public func display(name: String, _ signal: SignalProducer<Marble, NoError>, showValue: Bool = true) {
    let container = SKView(frame: CGRect(x: 0, y: 0, width: 500, height: 100))
    XCPShowView(name, view: container )
    container.presentScene(MarbleScene(signalProducer: signal, size: container.bounds.size, showValue: showValue))
}

public func display(name: String, _ signal: SignalProducer<(Marble, Marble), NoError>, showValue: Bool = true) {
    let container = SKView(frame: CGRect(x: 0, y: 0, width: 500, height: 100))
    XCPShowView(name, view: container )
    container.presentScene(CombinedMarbleScene(signalProducer: signal, size: container.bounds.size, showValue: showValue))
}
