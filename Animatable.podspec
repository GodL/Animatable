Pod::Spec.new do |s|
  s.name             = "Animatable"
  s.version          = "1.0.6"
  s.license          = { :type => "MIT" }
  s.homepage         = "https://github.com/GodL/Animatable"
  s.author           = { "GodL" => "547188371@qq.com" }
  s.summary          = "A simpler way to set coreAnimation with PropertyWrapper."

  s.source           = { :git => "https://github.com/GodL/Animatable.git", :tag => "#{s.version}" }
  s.source_files     = "Sources/Animatable/*.swift"
  
  s.swift_version    = "5.0"

  s.ios.deployment_target = "9.0"
end
