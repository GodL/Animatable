
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
    
    var value: Value?
    
    public var projectedValue: Self {
        self
    }
    
    public var wrappedValue: Value {
        set {
            self.value = newValue
        }
        get {
            value!
        }
    }
    
    public init(_ animation: A) {
        self.animation = animation
    }
}

extension Animatable where Value: UIView {
    public func startAnimation() {
        value?.layer.add(animation.animation, forKey: animation.animationKey)
    }
    
    public func stopAnimation() {
        guard let key = animation.animationKey else {
            value?.layer.removeAllAnimations()
            return
        }
        value?.layer.removeAnimation(forKey: key)
    }
}

extension Animatable where Value: CALayer {
    public func startAnimation() {
        value?.add(animation.animation, forKey: animation.animationKey)
    }
    
    public func stopAnimation() {
        guard let key = animation.animationKey else {
            value?.removeAllAnimations()
            return
        }
        value?.removeAnimation(forKey: key)
    }
}

