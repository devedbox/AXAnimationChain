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
/// Constant enum type of effects showing directions.
///
public enum AXAnimationEffectsDirection: Int {
    case top, left, bottom, right
}
/// Calculate the settling duration of spring animation parameters: mass/stiffness/damping.
///
/// - Parameters:
///   - mass: mass of the spring animation to be calculated.
///   - stiffness: stiffness of the spring animation to be calculated.
///   - damping: damping of the spring animation to be calculated.
///
/// - Returns: duration of the spring to be settling.
private func settlingDurationForSpring(mass: Double, stiffness: Double, damping: Double) -> Double {
    let beta = damping/(2*mass)
    let omega0 = sqrt(stiffness/mass)
    
    let flag = -log(0.001)/min(beta, omega0)
    let duration = -log(0.0004)/min(beta, omega0)
    
    return (flag + duration) / 2;
}
/// Animation effects extension of `UIView`.
///
public extension UIView {
    /// Run a \`tada\` animation effect on the receiver.
    ///
    /// - Parameters:
    ///   - completion: a completion clousure to execute when the animation finished.
    ///
    public func tada(completion: @escaping () -> Void = {}) {
        chainAnimator.basic.property("transform.scale").fromValue(1.0).toValue(1.1).duration(0.15).combineBasic().property("transform.rotation").byValue(M_PI/21.0).duration(0.1).autoreverses().repeatCount(2).combineBasic().beginTime(0.1).property("transform.rotation").byValue(-M_PI/18.0).duration(0.1).autoreverses().repeatCount(2).nextToBasic().property("transform.scale").toValue(1.0).duration(0.15).start(completion: completion)
    }
    /// Run a \`bonuce\` animation effect on the receiver.
    ///
    /// - Parameters:
    ///   - from: the from direction of the bonuce animation showing up.
    ///   - completion: a completion clousure to execute when the animation finished.
    ///
    public func bonuce(from direction: AXAnimationEffectsDirection = .top, completion: @escaping () -> Void = {}) {
        switch direction {
        case .top:
            chainAnimator.basic.property("position.y").byValue(50).toValue(self.layer.position.y).duration(0.5).easeOutBounce().start(completion: completion)
        case .left:
            chainAnimator.basic.property("position.x").byValue(50).toValue(self.layer.position.x).duration(0.5).easeOutBounce().start(completion: completion)
        case .bottom:
            chainAnimator.basic.property("position.y").fromValue(self.layer.position.y+50).toValue(self.layer.position.y).duration(0.5).easeOutBounce().start(completion: completion)
        default:
            chainAnimator.basic.property("position.x").fromValue(self.layer.position.x+50).toValue(self.layer.position.x).duration(0.5).easeOutBounce().start(completion: completion)
        }
    }
    /// Run a \`pulse\` animation effect on the receiver.
    ///
    /// - Parameters:
    ///   - completion: a completion clousure to execute when the animation finished.
    ///
    public func pulse(completion: @escaping () -> Void = {}) {
        chainAnimator.basic.property("transform.scale").byValue(0.1).duration(0.5).linear().autoreverses().start(completion: completion)
    }
    /// Run a \`shake\` animation effect on the receiver.
    ///
    /// - Parameters:
    ///   - completion: a completion clousure to execute when the animation finished.
    ///
    public func shake(completion: @escaping () -> Void = {}) {
        let position = layer.position
        chainAnimator.basic.property("position.x").fromValue(position.x-20).toValue(position.x+20).duration(0.1).linear().autoreverses().repeatCount(1.5).nextToBasic().property("position.x").toValue(position.x).duration(0.1).start(completion: completion)
    }
    /// Run a \`swing\` animation effect on the receiver.
    ///
    /// - Parameters:
    ///   - completion: a completion clousure to execute when the animation finished.
    ///
    public func swing(completion: @escaping () -> Void = {}) {
        chainAnimator.basic.property("transform.rotation").byValue(M_PI/21.0).duration(0.1).autoreverses().repeatCount(2).combineBasic().beginTime(0.1).property("transform.rotation").byValue(-M_PI/18.0).duration(0.1).autoreverses().repeatCount(2).nextToBasic().property("transform.scale").toValue(1.0).duration(0.15).start(completion: completion)
    }
    /// Run a \`snap\` animation effect on the receiver.
    ///
    /// - Parameters:
    ///   - from: the from direction of the bonuce animation showing up.
    ///
    public func snap(from direction: AXAnimationEffectsDirection = .left) {
        layer.anchorToRight()
        chainAnimator.spring.property("position.x").byValue(150).toValue(self.layer.position.x)/*.mass(1).stiffness(100).damping(13)*/.combineSpring().property("transform.scale.x").byValue(-0.5).combineSpring().beginTime(0.5).property("transform.scale.x").byValue(0.5).mass(1).stiffness(100).damping(13).start()
    }
    /// Run a \`expand\` animation effect on the receiver.
    ///
    /// - Parameters:
    ///   - completion: a completion clousure to execute when the animation finished.
    ///
    public func expand(completion:@escaping () -> Void = {}) {
        chainAnimator.basic.property("transform.scale").fromValue(0.0).toValue(1.0).duration(0.5).start(completion: completion)
    }
    /// Run a \`compress\` animation effect on the receiver.
    ///
    /// - Parameters:
    ///   - completion: a completion clousure to execute when the animation finished.
    ///
    public func compress(completion: @escaping () -> Void = {}) {
        chainAnimator.basic.property("transform.scale").fromValue(1.0).toValue(0.0).duration(0.5).start(completion: completion)
    }
    /// Run a \`hinge\` animation effect on the receiver.
    ///
    /// - Parameters:
    ///   - completion: a completion clousure to execute when the animation finished.
    ///
    public func hinge(completion: @escaping () -> Void = {}) {
        layer.anchorToLeftTop()
        chainAnimator.spring.property("transform.rotation").fromValue(0).toValue(acos(Double(bounds.height)/Double(pow(pow(bounds.width, 2.0)+pow(bounds.height, 2.0), 0.5)))).mass(2).stiffness(100).damping(10).combineBasic().beginTime(1.0).property("position.y").fromValue(layer.position.y).toValue(UIScreen.main.bounds.height+layer.position.y).duration(0.5).easeInCubic().start(completion: completion)
    }
}
