//
//  Created by Maciej Gorecki on 30/08/2020.
//

#if canImport(UIKit)
import UIKit

public class OverlayTransition: NSObject, UIViewControllerAnimatedTransitioning {
    private enum Constants {
        static let transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
    }
    
    private let configuration: OverlayTransitionConfiguration
    public var mode: OverlayTransitionMode = .present
    
    private let overlay = UIView()
    
    public init(configuration: OverlayTransitionConfiguration) {
        self.configuration = configuration
    }
}

public extension OverlayTransition {
    func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?
    ) -> TimeInterval {
        configuration.duration
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
            startingPoint: configuration.startingPoint
        )
        
        overlay.layer.cornerRadius = overlay.frame.size.height / 2
        overlay.center = configuration.startingPoint
        overlay.backgroundColor = configuration.backgroundColor
        overlay.isHidden = false
        
        if mode == .present {
            overlay.transform = Constants.transform
            targetView.center = configuration.startingPoint
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
                targetView.center = self.configuration.startingPoint
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
            duration: configuration.duration,
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
