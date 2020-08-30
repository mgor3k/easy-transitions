//
//  Created by Maciej Gorecki on 30/08/2020.
//

#if canImport(UIKit)
import UIKit

extension UIView {
    static func springAnimate(
        duration: TimeInterval,
        animations: @escaping () -> Void,
        completion: @escaping () -> Void) {
            UIView.animate(
                withDuration: duration,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 1,
                options: .curveEaseOut,
                animations: animations,
                completion: { _ in completion() }
            )
    }
}

#endif
