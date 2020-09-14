//
//  Created by Maciej Gorecki on 31/08/2020.
//

#if canImport(UIKit)
import UIKit

/// An example of a controller using the overlay transition.
public class OverlayTransitionNavigationController: UINavigationController {
    private let transition: OverlayTransition
    
    /// Initializer
    /// - Parameters:
    ///   - transitionDuration: Transition duration
    ///   - startingPoint: Starting point of the transition e.g. center point of a button
    ///   - backgroundColor: Background color of the presenting controller - it will stick out of its bounds. This should also match the buttons background for the best effect.
    public init(
        transitionDuration: TimeInterval = 0.5,
        startingPoint: CGPoint,
        backgroundColor: UIColor) {
        self.transition = OverlayTransition(
            duration: transitionDuration,
            startingPoint: startingPoint,
            backgroundColor: backgroundColor
        )
        
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
        transitioningDelegate = self
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OverlayTransitionNavigationController: UIViewControllerTransitioningDelegate {
    public func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        transition.mode = .present
        return transition
    }
    
    public func animationController(
        forDismissed dismissed: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        transition.mode = .dismiss
        return transition
    }
}
#endif
