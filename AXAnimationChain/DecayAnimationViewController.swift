//
//  DecayAnimationViewController.swift
//  AXAnimationChain
//
//  Created by devedbox on 2017/4/1.
//  Copyright © 2017年 devedbox. All rights reserved.
//

import UIKit
import ObjectiveC
import AXAnimationChainSwift

extension UIView {
    private struct _AssociatedObjectKey {
        static let touchsBeganKey = "touchsBegan"
    }
    internal var touchsBegan: ((Set<UITouch>, UIEvent?) -> Void)? {
        get { return objc_getAssociatedObject(self, _AssociatedObjectKey.touchsBeganKey) as? ((Set<UITouch>, UIEvent?) -> Void) }
        set { objc_setAssociatedObject(self, _AssociatedObjectKey.touchsBeganKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
    }
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        // print("\((String(#file) as NSString).lastPathComponent)")
        touchsBegan?(touches, event)
    }
}

class DecayAnimationViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var animatedView: UIView!
    weak var panGesture: UIPanGestureRecognizer?
    weak var longPressGesture: UILongPressGestureRecognizer?
    
    var shouldBeginInactiveOfAnimatedView = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Add pan ges ture to the animated view.
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        pan.delegate = self
        view.addGestureRecognizer(pan)
        panGesture = pan
        
        // let tap = UITapGestureRecognizer(target: self, action: #selector(handleTagGesture(_:)))
        // tap.delegate = self
        // view.addGestureRecognizer(tap)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(_:)))
        longPress.delegate = self
        longPress.minimumPressDuration = 0.0001
        // view.addGestureRecognizer(longPress)
        // longPressGesture = longPress
        
        view.touchsBegan = { [unowned self] touchs, event in
            self._applyImmediateValueOfAnimatedView()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions.
    @objc
    private func handleTagGesture(_ genture: UITapGestureRecognizer) {
        // _applyImmediateValueOfAnimatedView()
        print("State of tap gesture: \(genture.state.rawValue)")
    }
    
    @objc
    private func handleLongPressGesture(_ genture: UILongPressGestureRecognizer) {
        // _applyImmediateValueOfAnimatedView()
        print("State of long press gesture: \(genture.state.rawValue)")
    }
    
    @objc
    private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        var point = gesture.location(in: view)
        
        switch gesture.state {
        case .possible: fallthrough
        case .began:
            _applyImmediateValueOfAnimatedView()
            
            point = gesture.location(in: view)
            
            if animatedView.frame.contains(point) {
                shouldBeginInactiveOfAnimatedView = true
            } else {
                shouldBeginInactiveOfAnimatedView = false
            }
            
            let pauseTime = animatedView.layer.convertTime(CACurrentMediaTime(), from: nil)
            print("pause time: \(pauseTime)")
        case .changed:
            /*
            point.x = max(animatedView.frame.width/2+64, point.x)
            point.y = max(animatedView.frame.height/2+64, point.y)
            point.x = min(view.frame.width-animatedView.frame.width/2, point.x)
            point.y = min(view.frame.height-animatedView.frame.height/2, point.y)
             */
            guard shouldBeginInactiveOfAnimatedView else { break }
            animatedView.center = point
        case .ended:
            guard shouldBeginInactiveOfAnimatedView else { break }
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
            CATransaction.setCompletionBlock({[weak self] () -> Void in
                // print("view's center:\(String(describing: self?.animatedView.center)), layer's position:\(String(describing: self?.animatedView.layer.position))")
                // self?.animatedView.layer.position = CGPoint(x: decayx.values?.last as! Double, y: decayy.values?.last as! Double)
                // self?.animatedView.layer.removeAllAnimations()
                // print("view's center:\(String(describing: self?.animatedView.center)), layer's position:\(String(describing: self?.animatedView.layer.position))")
                self?._applyImmediateValueOfAnimatedView()
            })
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
    
    // MARK: Private
    private func _applyImmediateValueOfAnimatedView() {
        defer {
            animatedView.layer.removeAllAnimations()
        }
        guard let animationKeys = animatedView.layer.animationKeys() else { return }
        for key in animationKeys {
            guard let animation = animatedView.layer.animation(forKey: key) as? AXDecayAnimation else { continue }
            
            let beginTime = animation.beginTime
            // let timeOffset = animation.timeOffset
            
            // print("begin time: \(beginTime), time offset: \(timeOffset)")
            // print("current time: \(CACurrentMediaTime())")
            
            let time = CACurrentMediaTime()-beginTime
            guard let immediateValue = try? animation.immediateValue(atTime: time) else { continue }
            
            animatedView.layer.setValue(immediateValue, forKeyPath: animation.keyPath!)
        }
    }
    
    // MARK: UIGestureRecognizerDelegate.
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isKind(of: UITapGestureRecognizer.self) {
            return false
        }
        return false
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == longPressGesture && otherGestureRecognizer == panGesture {
            return true
        }
        return false
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == panGesture && otherGestureRecognizer == longPressGesture {
            return true
        }
        return false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
