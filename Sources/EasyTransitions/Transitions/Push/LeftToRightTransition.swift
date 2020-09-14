//
//  Created by Maciej Gorecki on 30/08/2020.
//

#if canImport(UIKit)
import UIKit

/// The view controller being present will come from the left pushing the presenting view controller out of the screen.
public class LeftToRightTransition: NSObject, UIViewControllerAnimatedTransitioning {
    private let duration: TimeInterval
    
    /// Initializer
    /// - Parameter duration: The total duration of the transition
    public init(duration: TimeInterval) {
        self.duration = duration
    }
}

public extension LeftToRightTransition {
    func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?
    ) -> TimeInterval {
        duration
    }
    
    func animateTransition(
        using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let toView = transitionContext.view(forKey: .to),
              let fromView = transitionContext.view(forKey: .from) else {
            return
        }
        
        containerView.addSubview(toView)
        
        let startingFrame = CGRect(
            x: -toView.frame.width,
            y: 0,
            width: toView.frame.width,
            height: toView.frame.height
        )
        
        toView.frame = startingFrame
        
        let animations = {
            toView.frame = .init(
                x: 0,
                y: 0,
                width: toView.frame.width,
                height: toView.frame.height
            )
            
            fromView.frame = .init(
                x: fromView.frame.width,
                y: 0,
                width: fromView.frame.width,
                height: fromView.frame.height
            )
        }
        
        let completion = {
            transitionContext.completeTransition(true)
        }
        
        UIView.springAnimate(
            duration: duration,
            animations: animations,
            completion: completion
        )
    }
}
#endif
