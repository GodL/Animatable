# Animatable

✨ A simpler way to set coreAnimation with PropertyWrapper.

## At a Glance

Initialize scale animation.

```swift
    struct ScaleAnimation: AnimatedType {
        var animation: CAAnimation {
        let ani = CABasicAnimation(keyPath: "transform.scale")
        ani.duration = 0.3
        ani.toValue = 0.1
        return ani
        }
    }
```
Use scale animation with PropertyWrapper

``` swift
    @Animatable(animated: Animations.TranslationAnimation(), configure: {
        if isRepeat {
            $0.autoreverses = true
            $0.repeatCount = 100
            }
    })
    var translationView: UILabel = UILabel()

    @Animatable(animated: Animations.ScaleAnimation(), configure: {
        if isRepeat {
            $0.autoreverses = true
            $0.repeatCount = 100
            }
    })
    var scaleView: UILabel = UILabel()

    @Animatable(animated: AnimationGroup(Animations.TranslationAnimation(), Animations.ScaleAnimation()), configure: {
        if isRepeat {
            $0.autoreverses = true
            $0.repeatCount = 100
            }
        })
    var combineView: UILabel = UILabel()
    
    $translationView.startAnimation()
    $scaleView.startAnimation()
    $combineView.startAnimation()
```

## Tips

You can use projectedValue $ to startAnimation and stopAnimation

## Installation

- **Using [Swift Package Manager](https://swift.org/package-manager)**:

```swift
import PackageDescription

let package = Package(
name: "MyAwesomeApp",
dependencies: [
.Package(url: "https://github.com/GodL/Animatable.git", majorVersion: 1.0.6),
],
targets: [
.target(
name: "MyAwesomeApp",
dependencies: ["Animatable"])
]
)
```

- **Using [Cococpods]**:

``` ruby
pod 'GLResponderChain', '~> 1.0.6'
```

## License

**Animatable** is under MIT license. See the [LICENSE](LICENSE) file for more info.
