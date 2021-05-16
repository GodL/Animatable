
import UIKit

public protocol AnimatedType {
    
    var animation: CAAnimation { get }
    
    var animationKey: String? { get }
    
}

extension AnimatedType {
    public var animationKey: String? { nil }
}

public struct AnimationGroup: AnimatedType {
    let animations: [AnimatedType]
    
    public var animation: CAAnimation {
        let group = CAAnimationGroup()
        group.animations = self.animations.map(\.animation)
        group.duration = group.animations?.first?.duration ?? 0
        return group
    }
}

extension AnimationGroup {
    public init<A1: AnimatedType,A2: AnimatedType>(_ a1: A1, _ a2: A2) {
        animations = [a1,a2]
    }
    
    public init<A1: AnimatedType,A2: AnimatedType,A3: AnimatedType>(_ a1: A1, _ a2: A2,_ a3: A3) {
        animations = [a1,a2,a3]
    }
    
    public init<A1: AnimatedType,A2: AnimatedType,A3: AnimatedType,A4: AnimatedType>(_ a1: A1, _ a2: A2, _ a3: A3, _ a4: A4) {
        animations = [a1,a2,a3,a4]
    }
}

extension AnimationGroup {
    public init<A: AnimatedType>(_ animations: [A]) {
        self.animations = animations
    }
    
    public init<A: AnimatedType>(_ animations: A ...) {
        self.animations = animations
    }
}

@propertyWrapper
public struct Animatable<A: AnimatedType,Value> {
    
    let animation: A
        
    var configure: ((CAAnimation) -> Void)?
    
    public var projectedValue: Self {
        self
    }
    
    public var wrappedValue: Value
    
    public init(wrappedValue: Value, animated animation: A, configure: ((CAAnimation) -> Void)? = nil) {
        self.wrappedValue = wrappedValue
        self.animation = animation
        self.configure = configure
    }
}

extension Animatable where Value: UIView {
    public func startAnimation() {
        let key = animation.animationKey
        let animation = animation.animation
        configure?(animation)
        wrappedValue.layer.add(animation, forKey: key)
    }
    
    public func stopAnimation() {
        guard let key = animation.animationKey else {
            wrappedValue.layer.removeAllAnimations()
            return
        }
        wrappedValue.layer.removeAnimation(forKey: key)
    }
}

extension Animatable where Value: CALayer {
    public func startAnimation() {
        let key = animation.animationKey
        let animation = animation.animation
        configure?(animation)
        wrappedValue.add(animation, forKey: key)
    }
    
    public func stopAnimation() {
        guard let key = animation.animationKey else {
            wrappedValue.removeAllAnimations()
            return
        }
        wrappedValue.removeAnimation(forKey: key)
    }
}
