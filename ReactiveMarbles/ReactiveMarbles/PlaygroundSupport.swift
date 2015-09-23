//
//  PlaygroundSupport.swift
//  ReactiveMarbles
//
//  Created by Sam Ritchie on 16/09/2015.
//  Copyright © 2015 codesplice pty ltd.
//
//  Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted,
//  provided that the above copyright notice and this permission notice appear in all copies.
//
//  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
//  INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
//  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE
//  OF THIS SOFTWARE.

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
