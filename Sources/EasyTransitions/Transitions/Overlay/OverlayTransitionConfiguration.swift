//
//  Created by Maciej Gorecki on 30/08/2020.
//

#if canImport(UIKit)
import UIKit

public struct OverlayTransitionConfiguration {
    public let duration: TimeInterval
    public let startingPoint: CGPoint
    public let backgroundColor: UIColor
    
    public init(
        duration: TimeInterval = 0.5,
        startingPoint: CGPoint,
        backgroundColor: UIColor) {
        self.duration = duration
        self.startingPoint = startingPoint
        self.backgroundColor = backgroundColor
    }
}
#endif
