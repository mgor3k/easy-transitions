//
//  Created by Maciej Gorecki on 31/08/2020.
//

#if canImport(UIKit)
import UIKit

public class OverlayTransitionNavigationController: UINavigationController {
    private let transitionDuration: TimeInterval
    private let transition: OverlayTransition
    
    public init(
        transitionDuration: TimeInterval = 0.5,
        startingPoint: CGPoint,
        backgroundColor: UIColor) {
        self.transitionDuration = transitionDuration
        
        let configuration = OverlayTransitionConfiguration(
            duration: transitionDuration,
            startingPoint: startingPoint,
            backgroundColor: backgroundColor
        )
        
        self.transition = OverlayTransition(configuration: configuration)
        
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
