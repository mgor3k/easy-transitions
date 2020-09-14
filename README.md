# EasyTransitions

EasyTransitions is a small SPM package with simple presentation transitions.

<sub>Documentation coming soon.</sub>

<img src="https://i.imgur.com/kWRIZmr.gif" width="150"><img src="https://i.imgur.com/mSSv6iM.gif" width="150"><img src="https://i.imgur.com/n8M7I0K.gif" width="150"><img src="https://i.imgur.com/83uRH4L.gif" width="150"><img src="https://i.imgur.com/KWbs96g.gif" width="150">

This library contains subclasses of `UIViewControllerAnimatedTransitioning`

* `OverlayTransition(duration:, startingPoint:, backgroundColor:)`
* `BottomToTopTransition(duration:)`
* `LeftToRightTransition(duration:)`
* `RightToLeftTransition(duration:)`
* `TopToBottomTransition(duration:)`
* more coming soon

For example usage check sample controllers `PushTransitionNavigationController` or `OverlayTransitionNavigationController`
```swift
let someVC = SomeViewController()

let navVC = PushTransitionNavigationController(
    transitionDuration: 1,
    transitionType: .rightToLeft
)

navVC.viewControllers = [someVC]
present(navVC, animated: true)
```

```swift
let someVC = SomeViewController()

let navVC = OverlayTransitionNavigationController(
    startingPoint: button.center,
    backgroundColor: button.backgroundColor
)

navVC.viewControllers = [someVC]
present(navVC, animated: true)
```
