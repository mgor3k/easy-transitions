//
//  Created by Maciej Gorecki on 29/08/2020.
//

#if canImport(UIKit)
import UIKit

public class PushTransitionNavigationController: UINavigationController {
    private let transitionDuration: TimeInterval
    private let transitionType: PushTransitionType
    
    public init(transitionDuration: TimeInterval, transitionType: PushTransitionType) {
        self.transitionDuration = transitionDuration
        self.transitionType = transitionType
        
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
        transitioningDelegate = self
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PushTransitionNavigationController: UIViewControllerTransitioningDelegate {
    public func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        transitionType
            .transition(duration: transitionDuration)
    }
    
    public func animationController(
        forDismissed dismissed: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        transitionType
            .opposite
            .transition(duration: transitionDuration)
    }
}
#endif
