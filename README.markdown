# ReactiveMarbles

## SpriteKit marble animations demonstrating [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa/tree/swift2) methods.

[Marbles](http://rxmarbles.com) are a time-honoured method of teaching RX concepts. This repository includes a Swift 2 Playground with animated marble views to allow experimentation with ReactiveCocoa 4 signals.

### Getting Started:

1. Clone or download the repo
2. Run `carthage checkout`, or `git submodule init`
3. Build the 'ReactiveMarbles-OSX' scheme
4. Open one of the Playground pages, show the Assistant Editor, and choose 'Timeline'.

### TODO/Known Issues:

* No iOS framework - iOS Playgrounds are limited to only one live view, which makes these somewhat less useful.
* The private XCPlayground.framework is bundled in the repository. This may not work with different versions of Xcode (currently built for Xcode 7)
* The frame rate is pretty awful on slower Macs. 

I’m also **not** a seasoned ReactiveCocoa expert, and some of this code may be incorrect/misleading/non-idiomatic/crap. I’d gratefully appreciate corrections and/or PRs. There’s probably more work that can be done in the Playground support to make it a bit more useful & natural to experiment with.