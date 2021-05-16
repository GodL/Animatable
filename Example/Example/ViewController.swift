//
//  ViewController.swift
//  Example
//
//  Created by 李浩 on 2021/5/16.
//

import UIKit

var isRepeat: Bool = false

class ViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        translationView.text = "平移"
        translationView.backgroundColor = .red
        translationView.textAlignment = .center
        translationView.frame = CGRect(x: 20, y: 100, width: 100, height: 30)
        self.view.addSubview(translationView)
        
        scaleView.text = "缩放"
        scaleView.backgroundColor = .orange
        scaleView.textAlignment = .center
        scaleView.frame = CGRect(x: self.view.center.x - 25, y: 180, width: 50, height: 50)
        self.view.addSubview(scaleView)
        
        combineView.text = "组合式动画"
        combineView.backgroundColor = .blue
        combineView.textAlignment = .center
        combineView.frame = CGRect(x: 20, y: 280, width: 100, height: 30)
        self.view.addSubview(combineView)
        
        let btn1 = UIButton(type: .custom)
        btn1.setTitle("执行一次", for: .normal)
        btn1.backgroundColor = .brown
        btn1.frame = CGRect(x: self.view.center.x - 130, y: 350, width: 100, height: 50)
        self.view.addSubview(btn1)
        
        let btn2 = UIButton(type: .custom)
        btn2.setTitle("重复执行", for: .normal)
        btn2.backgroundColor = .brown
        btn2.frame = CGRect(x: self.view.center.x + 30, y: 350, width: 100, height: 50)
        self.view.addSubview(btn2)
        
        btn1.addTarget(self, action: #selector(_do), for: .touchUpInside)
        btn2.addTarget(self, action: #selector(_doRepeat), for: .touchUpInside)
        
        let btn3 = UIButton(type: .custom)
        btn3.setTitle("移除", for: .normal)
        btn3.backgroundColor = .brown
        btn3.frame = CGRect(x: self.view.center.x - 30, y: 420, width: 60, height: 60)
        btn3.addTarget(self, action: #selector(remove), for: .touchUpInside)
        self.view.addSubview(btn3)
        // Do any additional setup after loading the view.
    }

    @objc func _do() {
        isRepeat = false
        `do`()
    }
    
    @objc func _doRepeat() {
        isRepeat = true
        `do`()
    }
    
    @objc func remove() {
        $translationView.stopAnimation()
        $scaleView.stopAnimation()
        $combineView.stopAnimation()
    }
    
    func `do`() {
        $translationView.startAnimation()
        $scaleView.startAnimation()
        $combineView.startAnimation()
    }
}

enum Animations {
    
    struct TranslationAnimation: AnimatedType {
        var animation: CAAnimation {
            let animation = CABasicAnimation(keyPath: "transform.translation.x")
            animation.duration = 2
            animation.toValue = 200
            return animation
        }
    }
    
    struct ScaleAnimation: AnimatedType {
        var animation: CAAnimation {
            let animation = CABasicAnimation(keyPath: "transform.scale")
            animation.duration = 2
            animation.toValue = 2
            return animation
        }
    }
}
