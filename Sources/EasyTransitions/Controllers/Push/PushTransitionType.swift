//
//  Created by Maciej Gorecki on 30/08/2020.
//

#if canImport(UIKit)
import UIKit

public enum PushTransitionType {
    /// The view controller being present will come from the bottom pushing the presenting view controller out of the screen.
    case bottomToTop
    
    /// The view controller being present will come from the top pushing the presenting view controller out of the screen.
    case topToBottom
    
    /// The view controller being present will come from the left pushing the presenting view controller out of the screen.
    case leftToRight
    
    /// The view controller being present will come from the right pushing the presenting view controller out of the screen.
    case rightToLeft
    
    func transition(duration: TimeInterval) -> UIViewControllerAnimatedTransitioning {
        switch self {
        case .bottomToTop:
            return BottomToTopTransition(duration: duration)
        case .topToBottom:
            return TopToBottomTransition(duration: duration)
        case .leftToRight:
            return LeftToRightTransition(duration: duration)
        case .rightToLeft:
            return RightToLeftTransition(duration: duration)
        }
    }
    
    /// Opposite of the current transition - to go back the same way
    var opposite: PushTransitionType {
        switch self {
        case .bottomToTop:
            return .topToBottom
        case .topToBottom:
            return .bottomToTop
        case .leftToRight:
            return .rightToLeft
        case .rightToLeft:
            return .leftToRight
        }
    }
}
#endif
