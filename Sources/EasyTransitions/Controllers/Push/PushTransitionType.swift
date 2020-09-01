//
//  Created by Maciej Gorecki on 30/08/2020.
//

#if canImport(UIKit)
import UIKit

public enum PushTransitionType {
    case bottomToTop
    case topToBottom
    case leftToRight
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
