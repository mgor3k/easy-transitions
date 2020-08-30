//
//  Created by Maciej Gorecki on 30/08/2020.
//

#if canImport(UIKit)
import UIKit

public struct OverlayTransitionConfiguration {
    public let duration: TimeInterval
    public let mode: OverlayTransitionMode
    public let startingPoint: CGPoint
    public let backgroundColor: UIColor
    
    public init(
        duration: TimeInterval = 0.5,
        mode: OverlayTransitionMode,
        startingPoint: CGPoint,
        backgroundColor: UIColor) {
        self.duration = duration
        self.mode = mode
        self.startingPoint = startingPoint
        self.backgroundColor = backgroundColor
    }
}

public enum OverlayTransitionMode {
    case present, dismiss
}

public class OverlayTransition: NSObject, UIViewControllerAnimatedTransitioning {
    private let configuration: OverlayTransitionConfiguration
    
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
        let targetView = transitionContext.view(forKey: .to)!
        
        let originalCenter = targetView.center
        let originalSize = targetView.frame.size
        
        overlay.frame = frameForOverlay(
            originalCenter,
            size: originalSize,
            start: configuration.startingPoint
        )
        overlay.layer.cornerRadius = overlay.frame.size.height / 2
        overlay.center = configuration.startingPoint
        overlay.transform = .init(scaleX: 0.001, y: 0.001)
        overlay.backgroundColor = configuration.backgroundColor
        containerView.addSubview(overlay)
        
        targetView.center = configuration.startingPoint
        targetView.transform = .init(scaleX: 0.001, y: 0.001)
        targetView.alpha = 0
        containerView.addSubview(targetView)
        
        let animations = {
            self.overlay.transform = .identity
            targetView.transform = .identity
            targetView.alpha = 1
            targetView.center = originalCenter
        }
        
        let completion = { [weak self] in
            transitionContext.completeTransition(true)
            self?.overlay.isHidden = true
            self?.overlay.removeFromSuperview()
        }
        
        UIView.springAnimate(
            duration: configuration.duration,
            animations: animations,
            completion: completion
        )
    }
}

private extension OverlayTransition {
    func frameForOverlay(_ originalCenter: CGPoint, size originalSize: CGSize, start: CGPoint) -> CGRect {
      let lengthX = fmax(start.x, originalSize.width - start.x)
      let lengthY = fmax(start.y, originalSize.height - start.y)
      let offset = sqrt(lengthX * lengthX + lengthY * lengthY) * 2
      let size = CGSize(width: offset, height: offset)
      
      return CGRect(origin: CGPoint.zero, size: size)
    }
}
#endif
