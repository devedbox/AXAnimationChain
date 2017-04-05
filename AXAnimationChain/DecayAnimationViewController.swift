//
//  DecayAnimationViewController.swift
//  AXAnimationChain
//
//  Created by devedbox on 2017/4/1.
//  Copyright © 2017年 devedbox. All rights reserved.
//

import UIKit
import AXAnimationChainSwift

class DecayAnimationViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var animatedView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Add pan ges ture to the animated view.
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        pan.delegate = self
        animatedView.addGestureRecognizer(pan)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTagGesture(_:)))
        view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions.
    @objc
    private func handleTagGesture(_ genture: UITapGestureRecognizer) {
        defer {
            animatedView.layer.removeAllAnimations()
        }
        guard let animationKeys = animatedView.layer.animationKeys() else { return }
        for key in animationKeys {
            guard let animation = animatedView.layer.animation(forKey: key) as? AXDecayAnimation else { continue }
            
            let beginTime = animation.beginTime
            let timeOffset = animation.timeOffset
            
            print("begin time: \(beginTime), time offset: \(timeOffset)")
            print("current time: \(CACurrentMediaTime())")
            
            let time = CACurrentMediaTime()-beginTime
            guard let immediateValue = animation.immediateValue(atTime: time) else { continue }
            
            animatedView.layer.setValue(immediateValue, forKeyPath: animation.keyPath!)
        }
    }
    
    @objc
    private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        var point = gesture.location(in: view)
        
        switch gesture.state {
        case .began:
            point = gesture.location(in: view)
            
            let pauseTime = animatedView.layer.convertTime(CACurrentMediaTime(), from: nil)
            print("pause time: \(pauseTime)")
        case .possible: break
        case .changed:
            /*
            point.x = max(animatedView.frame.width/2+64, point.x)
            point.y = max(animatedView.frame.height/2+64, point.y)
            point.x = min(view.frame.width-animatedView.frame.width/2, point.x)
            point.y = min(view.frame.height-animatedView.frame.height/2, point.y)
             */
            animatedView.center = point
        case .ended:
            point = gesture.location(in: view)
            print("view's center:\(String(describing: animatedView.center)), layer's position:\(String(describing: animatedView.layer.position))")
            
            let ve = gesture.velocity(in: animatedView)
            let decayx = AXDecayAnimation(keyPath: "position.x")
            decayx.fromValue = point.x
            decayx.velocity = ve.x
            decayx.isRemovedOnCompletion=false
            decayx.fillMode=kCAFillModeForwards
            // decayx.timingFunction = CAMediaTimingFunction.default()
            // decayx.isAdditive = true
            let decayy = AXDecayAnimation(keyPath: "position.y")
            decayy.fromValue = point.y
            decayy.velocity = ve.y
            decayy.isRemovedOnCompletion=false
            decayy.fillMode=kCAFillModeForwards
            // decayy.timingFunction = CAMediaTimingFunction.default()
            // decayy.isAdditive = true
            // CATransaction.setCompletionBlock({[weak self] () -> Void in
                // print("view's center:\(String(describing: self?.animatedView.center)), layer's position:\(String(describing: self?.animatedView.layer.position))")
                // self?.animatedView.layer.position = CGPoint(x: decayx.values?.last as! Double, y: decayy.values?.last as! Double)
                // self?.animatedView.layer.removeAllAnimations()
                // print("view's center:\(String(describing: self?.animatedView.center)), layer's position:\(String(describing: self?.animatedView.layer.position))")
            // })
            CATransaction.begin()
            CATransaction.setDisableActions(false)
            animatedView.layer.add(decayx, forKey: "position.x")
            animatedView.layer.add(decayy, forKey: "position.y")
            CATransaction.commit()
            
        case .cancelled: break
        case .failed: break
        // default: break
        }
    }
    
    // MARK: UIGestureRecognizerDelegate.

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
