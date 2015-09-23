//
//  Marbles.swift
//  ReactiveMarbles
//
//  Created by Sam Ritchie on 12/09/2015.
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
import ReactiveCocoa
import SpriteKit

public enum MarbleColour: String {
    case Red, Green, Blue, Yellow, Purple, Orange, Brown, Grey
    var skColor: SKColor {
        switch self {
        case .Red:
            return SKColor.redColor()
        case .Green:
            return SKColor.greenColor()
        case .Blue:
            return SKColor.blueColor()
        case .Yellow:
            return SKColor.yellowColor()
        case .Purple:
            return SKColor.purpleColor()
        case .Orange:
            return SKColor.orangeColor()
        case .Brown:
            return SKColor.brownColor()
        case .Grey:
            return SKColor.grayColor()
        }
    }
    static let allColours = [MarbleColour.Red, .Green, .Blue, .Yellow, .Purple, .Orange, .Brown, .Grey]
    
    static func random() -> MarbleColour {
        return MarbleColour.allColours[Int(arc4random()) % MarbleColour.allColours.count]
    }
}

public enum MarbleSignalColour {
    case Single(MarbleColour)
    case Random
}

public struct Marble: CustomDebugStringConvertible {
    public let colour: MarbleColour
    public let value: Int
    
    public init(colour: MarbleColour, value: Int) {
        self.colour = colour
        self.value = value
    }
    
    public var debugDescription: String {
        return "Marble(\(colour), \(value))"
    }
}

public func marbleSignal() -> Signal<Marble, NoError> {
    return marbleSignal(colour: .Single(.Red))
}

public func marbleSignal(colour colour: MarbleColour) -> Signal<Marble, NoError> {
    return marbleSignal(colour: .Single(colour))
}

public func marbleSignal(colour colour: MarbleSignalColour) -> Signal<Marble, NoError> {
    return Signal { sink in
         NSTimer.schedule(repeatInterval: 1.second) { t in
            let value = Int(arc4random() % 20)
            switch colour {
            case let .Single(c):
                sendNext(sink, Marble(colour: c, value: value))
            case .Random:
                sendNext(sink, Marble(colour: MarbleColour.random(), value: value))
            }
        }
        return nil
    }
}

public func irregularMarbleSignal(colour colour: MarbleSignalColour) -> Signal<Marble, NoError> {
    return Signal { sink in
        NSTimer.schedule(repeatInterval: 0.25.seconds) { t in
            if arc4random() % 12 == 0 {
                let value = Int(arc4random() % 20)
                switch colour {
                case let .Single(c):
                    sendNext(sink, Marble(colour: c, value: value))
                case .Random:
                    sendNext(sink, Marble(colour: MarbleColour.random(), value: value))
                }
            }
        }
        return nil
    }
}

public func marbleSignalProducer(signal: Signal<Marble, NoError>) -> SignalProducer<Marble, NoError> {
    return SignalProducer<Marble, NoError> { sink, disp in
        signal.observe(sink)
    }
}

public func marbleSignalProducer(colour: MarbleColour, count: Int) -> SignalProducer<Marble, NoError> {
    return SignalProducer<Marble, NoError> { sink, disp in
         NSTimer.schedule(repeatInterval: 1.second) { t in
            sendNext(sink, Marble(colour: colour, value: 0))
        }
    }.take(count)
}

public class MarbleScene: SKScene {
    let signal: SignalProducer<Marble, NoError>
    let marbleWidth = CGFloat(50.0)
    let showValue: Bool
    var mostRecentNode: SKNode?
    
    public init(signal: Signal<Marble, NoError>, size: CGSize, showValue: Bool = false) {
        self.signal = marbleSignalProducer(signal)
        self.showValue = showValue
        super.init(size: size)
    }

    public init(signalProducer: SignalProducer<Marble, NoError>, size: CGSize, showValue: Bool = false) {
        self.signal = signalProducer
        self.showValue = showValue
        super.init(size: size)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        signal = marbleSignalProducer(marbleSignal())
        self.showValue = false
        super.init(coder: aDecoder)
    }
    
    public override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.whiteColor()
        signal.startWithNext { m in
            let marble = SKShapeNode(circleOfRadius: self.marbleWidth/2.0)
            marble.fillColor = m.colour.skColor
            marble.lineWidth = 0;
            var x = self.size.width + (self.marbleWidth/2.0)
            if let last = self.mostRecentNode { x = max(x, last.position.x + 5) }
            marble.position = CGPoint(x: x, y: self.size.height - (self.marbleWidth))
            if self.showValue {
                let value = SKLabelNode(text: m.value.description)
                value.fontColor = NSColor.blackColor()
                value.position = CGPoint(x: 0, y: -self.marbleWidth/4.0)
                marble.addChild(value)
            }
            self.addChild(marble)
            let actionMove = SKAction.moveTo(CGPoint(x: -self.marbleWidth, y: self.size.height - (self.marbleWidth)), duration: NSTimeInterval(self.size.width/self.marbleWidth / 2))
            let actionMoveDone = SKAction.removeFromParent()
            marble.runAction(SKAction.sequence([actionMove, actionMoveDone]))
            self.mostRecentNode = marble
       }
    }
}

public class CombinedMarbleScene: SKScene {
    let signal: SignalProducer<(Marble, Marble), NoError>
    let marbleWidth = CGFloat(50.0)
    let showValue: Bool
    
    public init(signalProducer: SignalProducer<(Marble, Marble), NoError>, size: CGSize, showValue: Bool = false) {
        self.signal = signalProducer
        self.showValue = showValue
        super.init(size: size)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        signal = SignalProducer<(Marble, Marble), NoError>.empty
        self.showValue = false
        super.init(coder: aDecoder)
    }
    
    public override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.whiteColor()
        signal.startWithNext { (m1, m2) in
            self.addMarble(m1, height: self.frame.height - (self.marbleWidth/2.0))
            self.addMarble(m2, height: self.marbleWidth/2.0)
        }
    }
    
    private func addMarble(m: Marble, height: CGFloat) {
        let marble = SKShapeNode(circleOfRadius: self.marbleWidth/2.0)
        marble.fillColor = m.colour.skColor
        marble.lineWidth = 0;
        marble.position = CGPoint(x: self.size.width + (self.marbleWidth/2.0), y: height)
        if self.showValue {
            let value = SKLabelNode(text: m.value.description)
            value.fontColor = NSColor.blackColor()
            value.position = CGPoint(x: 0, y: -self.marbleWidth/4.0)
            marble.addChild(value)
        }
       self.addChild(marble)
        let actionMove = SKAction.moveTo(CGPoint(x: -self.marbleWidth, y: height), duration: NSTimeInterval(self.size.width/self.marbleWidth / 2))
        let actionMoveDone = SKAction.removeFromParent()
        marble.runAction(SKAction.sequence([actionMove, actionMoveDone]))
    }
}
