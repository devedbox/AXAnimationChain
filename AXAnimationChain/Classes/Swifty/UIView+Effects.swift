//
//  UIView+Effects.swift
//  AXAnimationChain
//
//  Created by devedbox on 2017/1/15.
//  Copyright © 2017年 devedbox. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit
import AXAnimationChainSwift

public enum AXAnimationEffectsDirection: Int {
    case top, left, bottom, right
}

private func settlingDurationForSpring(mass: Double, stiffness: Double, damping: Double) -> Double {
    let beta = damping/(2*mass)
    let omega0 = sqrt(stiffness/mass)
    
    let flag = -log(0.001)/min(beta, omega0)
    let duration = -log(0.0004)/min(beta, omega0)
    
    return (flag + duration) / 2;
}

extension UIView {
    public func tada() {
        chainAnimator.basic.property("transform.scale").fromValue(1.0).toValue(1.1).duration(0.15).combineBasic().property("transform.rotation").byValue(M_PI/21.0).duration(0.1).autoreverses().repeatCount(2).combineBasic().beginTime(0.1).property("transform.rotation").byValue(-M_PI/18.0).duration(0.1).autoreverses().repeatCount(2).nextToBasic().property("transform.scale").toValue(1.0).duration(0.15).start()
    }
    public func bonuce(from direction: AXAnimationEffectsDirection = .top) {
        switch direction {
        case .top:
            chainAnimator.basic.property("position.y").byValue(50).toValue(self.layer.position.y).duration(0.5).easeOutBounce().start()
        case .left:
            chainAnimator.basic.property("position.x").byValue(50).toValue(self.layer.position.x).duration(0.5).easeOutBounce().start()
        case .bottom:
            chainAnimator.basic.property("position.y").fromValue(self.layer.position.y+50).toValue(self.layer.position.y).duration(0.5).easeOutBounce().start()
        default:
            chainAnimator.basic.property("position.x").fromValue(self.layer.position.x+50).toValue(self.layer.position.x).duration(0.5).easeOutBounce().start()
        }
    }
    public func pulse() {
        chainAnimator.basic.property("transform.scale").byValue(0.1).duration(0.5).linear().autoreverses().start()
    }
    public func shake() {
        let position = layer.position
        chainAnimator.basic.property("position.x").fromValue(position.x-20).toValue(position.x+20).duration(0.1).linear().autoreverses().repeatCount(1.5).nextToBasic().property("position.x").toValue(position.x).duration(0.1).start()
    }
    
    public func snap(from direction: AXAnimationEffectsDirection = .left) {
        chainAnimator.spring.property("position.x").byValue(150).toValue(self.layer.position.x).mass(1).stiffness(100).damping(13).combineKeyframe().property("transform.rotation").values([-M_PI_4/2, -M_PI_4/3, M_PI/18, M_PI/6, M_PI/18, 0]).duration(settlingDurationForSpring(mass: 1, stiffness: 100, damping: 13)*0.6).start()
    }
    
    public func expand(completion:@escaping () -> Void = {}) {
        chainAnimator.basic.property("transform.scale").fromValue(0.0).toValue(1.0).duration(0.5).complete(completion).start()
    }
    
    public func compress(completion: @escaping () -> Void = {}) {
        chainAnimator.basic.property("transform.scale").fromValue(1.0).toValue(0.0).duration(0.5).complete(completion).start()
    }
    
    public func hinge(completion: @escaping () -> Void = {}) {
        layer.anchorToLeftTop()
        chainAnimator.spring.property("transform.rotation").fromValue(0).toValue(acos(Double(bounds.height)/Double(pow(pow(bounds.width, 2.0)+pow(bounds.height, 2.0), 0.5)))).mass(2).stiffness(100).damping(10).combineBasic().beginTime(1.0).property("position.y").fromValue(layer.position.y).toValue(UIScreen.main.bounds.height+layer.position.y).duration(0.5).easeInCubic().start()
    }
}
