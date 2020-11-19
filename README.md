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
    class MyView: UIView {
        @Animatable(ScaleAnimation()) var scaleView: UIView
    
        override init(frame: CGRect) {
            scaleView = UIView(frame: frame)
            super.init(frame: frame)
        
            self.addSubview(scaleView)
        }
    
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            $scaleView.startAnimation()
        }
}
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
        .Package(url: "https://github.com/GodL/Animatable.git", majorVersion: 1.0.2),
      ],
      targets: [
          .target(
              name: "MyAwesomeApp",
              dependencies: ["Animatable"])
      ]
    )
    ```
    
    ## License

    **Animatable** is under MIT license. See the [LICENSE](LICENSE) file for more info.
