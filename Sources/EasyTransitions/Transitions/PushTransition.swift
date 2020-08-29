//
//  Created by Maciej Gorecki on 29/08/2020.
//

#if canImport(UIKit)
import UIKit

public class PushTransition: NSObject, UIViewControllerAnimatedTransitioning {
    private let animationDuration: TimeInterval
    
    init(duration: TimeInterval) {
        self.animationDuration = duration
    }
    
    public func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?
    ) -> TimeInterval {
        animationDuration
    }
    
    public func animateTransition(
        using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let toView = transitionContext.view(forKey: .to), let fromView = transitionContext.view(forKey: .from) else { return }
        
        containerView.addSubview(toView)
        
        let startingFrame = CGRect(x: 0, y: toView.frame.height, width: toView.frame.width, height: toView.frame.height)
        toView.frame = startingFrame
        
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
                        toView.frame = CGRect(x: 0, y: 0, width: toView.frame.width, height: toView.frame.height)
                        fromView.frame = CGRect(x: 0, y: -fromView.frame.height, width: fromView.frame.width, height: fromView.frame.height)
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
        
    }
}
#endif
