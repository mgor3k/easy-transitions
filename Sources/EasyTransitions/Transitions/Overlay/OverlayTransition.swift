//
//  Created by Maciej Gorecki on 30/08/2020.
//

#if canImport(UIKit)
import UIKit

public enum OverlayTransitionMode {
    case present, dismiss
}

/// Circular overlay transition.
public class OverlayTransition: NSObject, UIViewControllerAnimatedTransitioning {
    private enum Constants {
        static let transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
    }
        
    private let duration: TimeInterval
    private let startingPoint: CGPoint
    private let backgroundColor: UIColor
    
    /// The current transition type - change this for dismiss
    public var mode: OverlayTransitionMode = .present
    
    private let overlay = UIView()
    
    /// Initializer
    /// - Parameters:
    ///   - duration: Transition duration
    ///   - startingPoint: Starting point of the transition e.g. center point of a button
    ///   - backgroundColor: Background color of the presenting controller - it will stick out of its bounds. This should also match the buttons background for the best effect.
    public init(
        duration: TimeInterval = 0.35,
        startingPoint: CGPoint,
        backgroundColor: UIColor) {
        self.duration = duration
        self.startingPoint = startingPoint
        self.backgroundColor = backgroundColor
    }
}

public extension OverlayTransition {
    func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?
    ) -> TimeInterval {
        duration
    }
    
    func animateTransition(
        using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        let fromViewController = transitionContext.viewController(forKey: .from)!
        let toViewController = transitionContext.viewController(forKey: .to)!
        
        if mode == .present {
            fromViewController.beginAppearanceTransition(false, animated: true)
        } else {
            toViewController.beginAppearanceTransition(true, animated: true)
        }
        
        let targetView = transitionContext.view(
            forKey: mode == .present ? .to : .from
        )!
        
        let originalCenter = targetView.center
        let originalSize = targetView.frame.size
        
        overlay.frame = calculateOverlayFrame(
            originalCenter: originalCenter,
            originalSize: originalSize,
            startingPoint: startingPoint
        )
        
        overlay.layer.cornerRadius = overlay.frame.size.height / 2
        overlay.center = startingPoint
        overlay.backgroundColor = backgroundColor
        overlay.isHidden = false
        
        if mode == .present {
            overlay.transform = Constants.transform
            targetView.center = startingPoint
            targetView.transform = Constants.transform
            targetView.alpha = 0
            containerView.addSubview(overlay)
            containerView.addSubview(targetView)
        }
        
        let animations = {
            switch self.mode {
            case .present:
                self.overlay.transform = .identity
                targetView.transform = .identity
                targetView.alpha = 1
                targetView.center = originalCenter
            case .dismiss:
                self.overlay.transform = Constants.transform
                targetView.transform = Constants.transform
                targetView.center = self.startingPoint
                targetView.alpha = 0
            }
        }
        
        let completion = { [weak self] in
            switch self?.mode {
            case .present:
                transitionContext.completeTransition(true)
                self?.overlay.isHidden = true
                fromViewController.endAppearanceTransition()
            default:
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                
                if !transitionContext.transitionWasCancelled {
                    targetView.center = originalCenter
                    targetView.removeFromSuperview()
                    self?.overlay.removeFromSuperview()
                    toViewController.endAppearanceTransition()
                }
            }
        }
        
        UIView.springAnimate(
            duration: duration,
            animations: animations,
            completion: completion
        )
    }
}

private extension OverlayTransition {
    func calculateOverlayFrame(
        originalCenter: CGPoint,
        originalSize: CGSize,
        startingPoint: CGPoint) -> CGRect {
      let lengthX = fmax(startingPoint.x, originalSize.width - startingPoint.x)
      let lengthY = fmax(startingPoint.y, originalSize.height - startingPoint.y)
      let offset = sqrt(lengthX * lengthX + lengthY * lengthY) * 2
      let size = CGSize(width: offset, height: offset)
      
      return CGRect(origin: .zero, size: size)
    }
}
#endif
