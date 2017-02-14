//
//  UIView+AnimationChain.swift
//  AXAnimationChain
//
//  Created by devedbox on 2017/2/11.
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

import Foundation
import AXAnimationChainSwift

public extension UIView {
    /// Associate keys strtuct.
    private struct AssociateKeys {
        static var afterContext = "afterContext"
        static var waitContext = "waitContext"
    }
    /// Spring animation parameters.
    public typealias SpringValue = (mass: CGFloat, stiffness: CGFloat, damping: CGFloat)
    /// Animation curve.
    public enum AnimationEasingCurve {
        case `in`, out, inOut
    }
    /// Animation type run as basic, spring and so on.
    public enum AnimationType {
        /*
        public enum EffectType: String {
            case `default`, linear, easeIn, easeOut, easeInOut, easeInSine, easeOutSine, easeInOutSine, easeInQuad, easeOutQuad, easeInOutQuad, easeInCubic, easeOutCubic, easeInOutCubic, easeInQuart, easeOutQuart, easeInOutQuart, easeInQuint, easeOutQuint, easeInOutQuint, easeInExpo, easeOutExpo, easeInOutExpo, easeInCirc, easeOutCirc, easeInOutCirc, easeInBack, easeOutBack, easeInOutBack
        } */
        
        case setted, basic(CAMediaTimingFunction?), spring(SpringValue?), bounce(AnimationEasingCurve), elastic(AnimationEasingCurve)
    }
    /// After total time duration.
    private var afterContext: Double? {
        get { return (objc_getAssociatedObject(self, &AssociateKeys.afterContext) as? Double) }
        set { objc_setAssociatedObject(self, &AssociateKeys.afterContext, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    /// Wait context.
    private var waitContext: Any {
        get { return objc_getAssociatedObject(self, &AssociateKeys.waitContext) }
        set { objc_setAssociatedObject(self, &AssociateKeys.waitContext, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    // MARK: - Animation type.
    /// Run as basic animation with a custom timing function. Default using `default` timing function.
    ///
    /// - Parameter timingFunction: timing function setted to the animation.
    ///
    public func basic(_ timingFunction: CAMediaTimingFunction = .default()) -> Self {
        let _ = chainAnimator.top.combinedAnimators?.last?.replace(with: chainAnimator.top.combinedAnimators?.last?.beginBasic().timingFunction(timingFunction))
        return self
    }
    /// Run as spring animation with a custom mass, stiffness and damping values.
    ///
    /// - Parameters:
    ///   - mass: mass of the spring animation.
    ///   - stiffness: stiffness of the spring animation.
    ///   - damping: damping of the spring animation.
    ///
    public func spring(mass: CGFloat = 1, stiffness: CGFloat = 100, damping: CGFloat = 10) -> Self {
        let _ = chainAnimator.top.combinedAnimators?.last?.replace(with: chainAnimator.top.combinedAnimators?.last?.beginSpring().mass(mass).stiffness(stiffness).damping(damping))
        return self
    }
    /// Run as bonuce animation effect with an animation easing curve.
    ///
    /// - Parameter easing: Animation easing curve.
    ///
    public func bonuce(easing: AnimationEasingCurve) -> Self {
        if let last = chainAnimator.top.combinedAnimators?.last {
            switch easing {
            case .in:
                if let fromValue = layer.initial((last.animation as! CAPropertyAnimation).keyPath!) {
                    let _ = last.replace(with: last.beginBasic().fromValue(fromValue).easeInBounce())
                } else {
                    let _ = last.replace(with: last.beginBasic().easeInBounce())
                }
            case .out:
                if let fromValue = layer.initial((last.animation as! CAPropertyAnimation).keyPath!) {
                    let _ = last.replace(with: last.beginBasic().fromValue(fromValue).easeOutBounce())
                } else {
                    let _ = last.replace(with: last.beginBasic().easeOutBounce())
                }
            default:
                if let fromValue = layer.initial((last.animation as! CAPropertyAnimation).keyPath!) {
                    let _ = last.replace(with: last.beginBasic().fromValue(fromValue).easeInOutBounce())
                } else {
                    let _ = last.replace(with: last.beginBasic().easeInOutBounce())
                }
            }
        }
        return self
    }
    /// Run as elastic animation effect with an animation easing curve.
    ///
    /// - Parameter easing: Animation easing curve.
    ///
    public func elastic(easing: AnimationEasingCurve) -> Self {
        if let last = chainAnimator.top.combinedAnimators?.last {
            switch easing {
            case .in:
                if let fromValue = layer.initial((last.animation as! CAPropertyAnimation).keyPath!) {
                    let _ = last.replace(with: last.beginBasic().fromValue(fromValue).easeInElastic())
                } else {
                    let _ = last.replace(with: last.beginBasic().easeInElastic())
                }
            case .out:
                if let fromValue = layer.initial((last.animation as! CAPropertyAnimation).keyPath!) {
                    let _ = last.replace(with: last.beginBasic().fromValue(fromValue).easeOutElastic())
                } else {
                    let _ = last.replace(with: last.beginBasic().easeOutElastic())
                }
            default:
                if let fromValue = layer.initial((last.animation as! CAPropertyAnimation).keyPath!) {
                    let _ = last.replace(with: last.beginBasic().fromValue(fromValue).easeInOutElastic())
                } else {
                    let _ = last.replace(with: last.beginBasic().easeInOutElastic())
                }
            }
        }
        return self
    }
    // MARK: - Animate.
    /// Perform the animation as a animation type allpying to all the animations. A completion closure will be executed when all animation finished.
    ///
    /// - Parameter as: animation type defined in `AnimationType` to animate as.
    /// - Parameter completion: completion closure to be executed when animation finished.
    ///
    public func animate(as animationType: AnimationType = .setted, completion: @escaping () -> Void = {}) {
        switch animationType {
        case .basic(let timingFunction):
            if let animators = chainAnimator.top.combinedAnimators {
                for animator in animators {
                    let replaced = animator.replace(with: animator.beginBasic())
                    if let timing = timingFunction {
                        replaced.timingFunction(timing)
                    }
                }
            }
        case .spring(let value):
            if let animators = chainAnimator.top.combinedAnimators {
                for animator in animators {
                    if let springValue = value {
                        let _ = animator.replace(with: animator.beginSpring().mass(springValue.mass).stiffness(springValue.stiffness).damping(springValue.damping))
                    } else {
                        let _ = animator.replace(with: animator.beginSpring())
                    }
                }
            }
        case .bounce(let easing):
            if let animators = chainAnimator.top.combinedAnimators {
                for animator in animators {
                    switch easing {
                    case .in:
                        if let fromValue = layer.initial((animator.animation as! CAPropertyAnimation).keyPath!) {
                            let _ = animator.replace(with: animator.beginBasic().fromValue(fromValue).easeInBounce())
                        } else {
                            let _ = animator.replace(with: animator.beginBasic().easeInBounce())
                        }
                    case .out:
                        if let fromValue = layer.initial((animator.animation as! CAPropertyAnimation).keyPath!) {
                            let _ = animator.replace(with: animator.beginBasic().fromValue(fromValue).easeOutBounce())
                        } else {
                            let _ = animator.replace(with: animator.beginBasic().easeOutBounce())
                        }
                    default:
                        if let fromValue = layer.initial((animator.animation as! CAPropertyAnimation).keyPath!) {
                            let _ = animator.replace(with: animator.beginBasic().fromValue(fromValue).easeInOutBounce())
                        } else {
                            let _ = animator.replace(with: animator.beginBasic().easeInOutBounce())
                        }
                    }
                }
            }
        case .elastic(let easing):
            if let animators = chainAnimator.top.combinedAnimators {
                for animator in animators {
                    switch easing {
                    case .in:
                        if let fromValue = layer.initial((animator.animation as! CAPropertyAnimation).keyPath!) {
                            let _ = animator.replace(with: animator.beginBasic().fromValue(fromValue).easeInElastic())
                        } else {
                            let _ = animator.replace(with: animator.beginBasic().easeInElastic())
                        }
                    case .out:
                        if let fromValue = layer.initial((animator.animation as! CAPropertyAnimation).keyPath!) {
                            let _ = animator.replace(with: animator.beginBasic().fromValue(fromValue).easeOutElastic())
                        } else {
                            let _ = animator.replace(with: animator.beginBasic().easeOutElastic())
                        }
                    default:
                        if let fromValue = layer.initial((animator.animation as! CAPropertyAnimation).keyPath!) {
                            let _ = animator.replace(with: animator.beginBasic().fromValue(fromValue).easeInOutElastic())
                        } else {
                            let _ = animator.replace(with: animator.beginBasic().easeInOutElastic())
                        }
                    }
                }
            }
        default: break
        }
        chainAnimator.top.start(completion: completion)
    }
    
    // MARK: - Timing control.
    /// Set the duration of animation to the receiver.
    ///
    /// - Parameter duration: time duration of the animation.
    ///
    public func duration(_ duration: TimeInterval) -> Self {
        chainAnimator.top.combinedAnimators?.last?.duration(duration)
        return self
    }
    /// Set the begin time duration of the next animation.
    ///
    /// - Parameter duration: Time duration of the next animation begin time.
    ///
    public func after(_ duration: TimeInterval) -> Self {
        if let after = afterContext {
            afterContext = after + duration
        } else {
            afterContext = duration
        }
        return self
    }
    
    // MARK: - To values.
    /// Animate moving `origin` to a destined point.
    ///
    /// - Parameter to: The point to move to.
    public func origin(to origin: CGPoint) -> Self {
        chainAnimator.top.combineBasic().property("position").beginTime(afterContext ?? 0.0).toValue(position(from: origin))
        return self
    }
    /// Animate moving `origin.x` to a destined value.
    ///
    /// - Parameter to: The value to move to.
    ///
    public func originX(to originX: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("position.x").beginTime(afterContext ?? 0.0).toValue(position(from: CGPoint(x: originX, y: layer.position.y)).x)
        return self
    }
    /// Animate moving `origin.y` to a destined value.
    ///
    /// - Parameter to: The value to move to.
    ///
    public func originY(to originY: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("position.y").beginTime(afterContext ?? 0.0).toValue(position(from: CGPoint(x: layer.position.x, y: originY)).y)
        return self
    }
    /// Animate moving `center` to a destined point.
    ///
    /// - Parameter to: The point to move to.
    ///
    public func center(to center: CGPoint) -> Self {
        chainAnimator.top.combineBasic().property("position").beginTime(afterContext ?? 0.0).toValue(center)
        return self
    }
    /// Animate moving `center.x` to a destined value.
    ///
    /// - Parameter to: The value to move to.
    ///
    public func centerX(to centerX: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("position.x").beginTime(afterContext ?? 0.0).toValue(CGPoint(x: centerX, y: layer.position.y))
        return self
    }
    /// Animate moving `center.y` to a destined value.
    ///
    /// - Parameter to: The value to move to.
    ///
    public func centerY(to centerY: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("position.y").beginTime(afterContext ?? 0.0).toValue(CGPoint(x: layer.position.x, y: centerY))
        return self
    }
    /// Animate moving `size` to a destined size.
    ///
    /// - Parameter to: The size to move to.
    ///
    public func size(to size: CGSize) -> Self {
        chainAnimator.top.combineBasic().property("bounds.size").beginTime(afterContext ?? 0.0).toValue(size)
        return self
    }
    /// Animate moving `width` to a destined value.
    ///
    /// - Parameter to: The value to move to.
    ///
    public func width(to width: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("bounds.size").beginTime(afterContext ?? 0.0).toValue(CGSize(width: width, height: layer.bounds.height))
        return self
    }
    /// Animate moving `height` to a destined value.
    ///
    /// - Parameter to: The value to move to.
    ///
    public func height(to height: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("bounds.size").beginTime(afterContext ?? 0.0).toValue(CGSize(width: layer.bounds.width, height: height))
        return self;
    }
    /// Animate moving `frame` to a destined rect.
    ///
    /// - Parameter to: The rect to move to.
    ///
    public func frame(to frame: CGRect) -> Self {
        return origin(to: frame.origin).size(to: frame.size)
    }
    /// Animate moving `bounds` to a destined rect.
    ///
    /// - Parameter to: The rect to move to.
    ///
    public func bounds(to bounds: CGRect) -> Self {
        return size(to: bounds.size)
    }
    /// Animate changing `opacity` to a destined value.
    ///
    /// - Parameter to: The value to change to.
    ///
    public func opacity(to opacity: Float) -> Self {
        chainAnimator.top.combineBasic().property("opacity").beginTime(afterContext ?? 0.0).toValue(opacity)
        return self
    }
    /// Animate changing `backgroundColor` to a destined color.
    ///
    /// - Parameter to: The color to change to.
    ///
    public func backgroundColor(to backgroundColor: UIColor) -> Self {
        chainAnimator.top.combineBasic().property("backgroundColor").beginTime(afterContext ?? 0.0).toValue(backgroundColor.cgColor)
        return self
    }
    /// Animate changing `borderColor` to a destined color.
    ///
    /// - Parameter to: The color to change to.
    ///
    public func borderColor(to borderColor: UIColor) -> Self {
        chainAnimator.top.combineBasic().property("borderColor").beginTime(afterContext ?? 0.0).toValue(borderColor.cgColor)
        return self
    }
    /// Animate changing `borderWidth` to a destined value.
    ///
    /// - Parameter to: The value to change to.
    ///
    public func borderWidth(to borderWidth: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("borderWidth").beginTime(afterContext ?? 0.0).toValue(borderWidth)
        return self
    }
    /// Animate changing `cornerRadius` to a destined value.
    ///
    /// - Parameter to: The value to change to.
    ///
    public func cornerRadius(to cornerRadius: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("cornerRadius").beginTime(afterContext ?? 0.0).toValue(cornerRadius)
        return self
    }
    /// Animate changing `scale` to a destined value.
    ///
    /// - Parameter to: The value to change to.
    ///
    public func scale(to scale: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.scale").beginTime(afterContext ?? 0.0).toValue(scale)
        return self
    }
    /// Animate changing `scale.x` to a destined value.
    ///
    /// - Parameter to: The value to change to.
    ///
    public func scaleX(to scaleX: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.scale.x").beginTime(afterContext ?? 0.0).toValue(scaleX)
        return self
    }
    /// Animate changing `scale.y` to a destined value.
    ///
    /// - Parameter to: The value to change to.
    ///
    public func scaleY(to scaleY: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.scale.y").beginTime(afterContext ?? 0.0).toValue(scaleY)
        return self
    }
    /// Animate changing `scale.z` to a destined value.
    ///
    /// - Parameter to: The value to change to.
    ///
    public func scaleZ(to scaleZ: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.scale.z").beginTime(afterContext ?? 0.0).toValue(scaleZ)
        return self
    }
    /// Animate changing `rotate` to a destined value.
    ///
    /// - Parameter to: The value to change to.
    ///
    public func rotate(to rotate: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.rotation").beginTime(afterContext ?? 0.0).toValue(rotate)
        return self
    }
    /// Animate changing `rotate.x` to a destined value.
    ///
    /// - Parameter to: The value to change to.
    ///
    public func rotateX(to rotateX: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.rotation.x").beginTime(afterContext ?? 0.0).toValue(rotateX)
        return self
    }
    /// Animate changing `rotate.y` to a destined value.
    ///
    /// - Parameter to: The value to change to.
    ///
    public func rotateY(to rotateY: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.rotation.y").beginTime(afterContext ?? 0.0).toValue(rotateY)
        return self
    }
    /// Animate changing `rotate.z` to a destined value.
    ///
    /// - Parameter to: The value to change to.
    ///
    public func rotateZ(to rotateZ: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.rotation.z").beginTime(afterContext ?? 0.0).toValue(rotateZ)
        return self
    }
    /// Animate changing `translate` to a destined point.
    ///
    /// - Parameter to: The point to change to.
    ///
    public func translate(to translate: CGPoint) -> Self {
        chainAnimator.top.combineBasic().property("transform.translation").beginTime(afterContext ?? 0.0).toValue(translate)
        return self
    }
    /// Animate changing `translate.x` to a destined value.
    ///
    /// - Parameter to: The value to change to.
    ///
    public func translateX(to translateX: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.translation.x").beginTime(afterContext ?? 0.0).toValue(translateX)
        return self
    }
    /// Animate changing `translate.y` to a destined value.
    ///
    /// - Parameter to: The value to change to.
    ///
    public func translateY(to translateY: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.translation.y").beginTime(afterContext ?? 0.0).toValue(translateY)
        return self
    }
    /// Animate changing `translate.z` to a destined value.
    ///
    /// - Parameter to: The value to change to.
    ///
    public func translateZ(to translateZ: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.translation.z").beginTime(afterContext ?? 0.0).toValue(translateZ)
        return self
    }
    /// Animate changing `image` to a destined image of the UIImage.
    ///
    /// - Parameter to: The image to change to.
    ///
    public func image(to image: UIImage) -> Self {
        chainAnimator.top.combineBasic().property("contents").beginTime(afterContext ?? 0.0).toValue(image.cgImage as Any)
        return self
    }
    
    // MARK: - By values.
    /// Animate moving `origin` by a point.
    ///
    /// - Parameter by: The point to move by.
    ///
    public func origin(by origin: CGPoint) -> Self {
        chainAnimator.top.combineBasic().property("position").beginTime(afterContext ?? 0.0).byValue(position(from: origin))
        return self
    }
    /// Animate moving `origin.x` by a value.
    ///
    /// - Parameter by: The value to move by.
    ///
    public func originX(by originX: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("position.x").beginTime(afterContext ?? 0.0).byValue(position(from: CGPoint(x: originX, y: layer.position.y)).x)
        return self
    }
    /// Animate moving `origin.y` by a value.
    ///
    /// - Parameter by: The value to move by.
    ///
    public func originY(by originY: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("position.x").beginTime(afterContext ?? 0.0).byValue(position(from: CGPoint(x: layer.position.x, y: originY)).y)
        return self
    }
    /// Animate moving `center` by a point.
    ///
    /// - Parameter by: The point to move by.
    ///
    public func center(by center: CGPoint) -> Self {
        chainAnimator.top.combineBasic().property("position").beginTime(afterContext ?? 0.0).byValue(center)
        return self
    }
    /// Animate moving `center.x` by a value.
    ///
    /// - Parameter by: The value to move by.
    ///
    public func centerX(by centerX: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("position.x").beginTime(afterContext ?? 0.0).byValue(CGPoint(x: centerX, y: layer.position.y))
        return self
    }
    /// Animate moving `center.y` by a value.
    ///
    /// - Parameter by: The value to move by.
    ///
    public func centerY(by centerY: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("position.y").beginTime(afterContext ?? 0.0).byValue(CGPoint(x: layer.position.x, y: centerY))
        return self
    }
    /// Animate changing `size` by a size.
    ///
    /// - Parameter by: The size to change by.
    ///
    public func size(by size: CGSize) -> Self {
        chainAnimator.top.combineBasic().property("bounds.size").beginTime(afterContext ?? 0.0).byValue(size)
        return self
    }
    /// Animate changing `width` by a value.
    ///
    /// - Parameter by: The value to change by.
    ///
    public func width(by width: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("bounds.size").beginTime(afterContext ?? 0.0).byValue(CGSize(width: width, height: layer.bounds.height))
        return self
    }
    /// Animate changing `height` by a value.
    ///
    /// - Parameter by: The value to change by.
    ///
    public func height(by height: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("bounds.size").beginTime(afterContext ?? 0.0).byValue(CGSize(width: layer.bounds.width, height: height))
        return self;
    }
    /// Animate changing `frame` by a rect.
    ///
    /// - Parameter by: The rect to change by.
    ///
    public func frame(by frame: CGRect) -> Self {
        return origin(by: frame.origin).size(by: frame.size)
    }
    /// Animate changing `bounds` by a rect.
    ///
    /// - Parameter by: The rect to change by.
    ///
    public func bounds(by bounds: CGRect) -> Self {
        return size(by: bounds.size)
    }
    /// Animate changing `opacity` by a value.
    ///
    /// - Parameter by: The value to change by.
    ///
    public func opacity(by opacity: Float) -> Self {
        chainAnimator.top.combineBasic().property("opacity").beginTime(afterContext ?? 0.0).byValue(opacity)
        return self
    }
    /// Animate changing `backgroundColor` by a color.
    ///
    /// - Parameter by: The color to change by.
    ///
    public func backgroundColor(by backgroundColor: UIColor) -> Self {
        chainAnimator.top.combineBasic().property("backgroundColor").beginTime(afterContext ?? 0.0).byValue(backgroundColor.cgColor)
        return self
    }
    /// Animate changing `borderColor` by a color.
    ///
    /// - Parameter by: The color to change by.
    ///
    public func borderColor(by borderColor: UIColor) -> Self {
        chainAnimator.top.combineBasic().property("borderColor").beginTime(afterContext ?? 0.0).byValue(borderColor.cgColor)
        return self
    }
    /// Animate changing `borderWidth` by a value.
    ///
    /// - Parameter by: The value to change by.
    ///
    public func borderWidth(by borderWidth: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("borderWidth").beginTime(afterContext ?? 0.0).byValue(borderWidth)
        return self
    }
    /// Animate changing `cornerRadius` by a value.
    ///
    /// - Parameter by: The value to change by.
    ///
    public func cornerRadius(by cornerRadius: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("cornerRadius").beginTime(afterContext ?? 0.0).byValue(cornerRadius)
        return self
    }
    /// Animate changing `transform.scale` by a value.
    ///
    /// - Parameter by: The value to change by.
    ///
    public func scale(by scale: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.scale").beginTime(afterContext ?? 0.0).byValue(scale)
        return self
    }
    /// Animate changing `transform.scale.x` by a value.
    ///
    /// - Parameter by: The value to change by.
    ///
    public func scaleX(by scaleX: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.scale.x").beginTime(afterContext ?? 0.0).byValue(scaleX)
        return self
    }
    /// Animate changing `scale.y` by a value.
    ///
    /// - Parameter by: The value to change by.
    ///
    public func scaleY(by scaleY: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.scale.y").beginTime(afterContext ?? 0.0).byValue(scaleY)
        return self
    }
    /// Animate changing `transform.scale.z` by a value.
    ///
    /// - Parameter by: The value to change by.
    ///
    public func scaleZ(by scaleZ: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.scale.z").beginTime(afterContext ?? 0.0).byValue(scaleZ)
        return self
    }
    /// Animate changing `transform.rotation` by a value.
    ///
    /// - Parameter by: The value to change by.
    ///
    public func rotate(by rotate: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.rotation").beginTime(afterContext ?? 0.0).byValue(rotate)
        return self
    }
    /// Animate changing `transform.rotation.x` by a value.
    ///
    /// - Parameter by: The value to change by.
    ///
    public func rotateX(by rotateX: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.rotation.x").beginTime(afterContext ?? 0.0).byValue(rotateX)
        return self
    }
    /// Animate changing `transform.rotation.y` by a value.
    ///
    /// - Parameter by: The value to change by.
    ///
    public func rotateY(by rotateY: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.rotation.y").beginTime(afterContext ?? 0.0).byValue(rotateY)
        return self
    }
    /// Animate changing `transform.rotation.z` by a value.
    ///
    /// - Parameter by: The value to change by.
    ///
    public func rotateZ(by rotateZ: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.rotation.z").beginTime(afterContext ?? 0.0).byValue(rotateZ)
        return self
    }
    /// Animate changing `transform.translation` by a value.
    ///
    /// - Parameter by: The value to change by.
    ///
    public func translate(by translate: CGPoint) -> Self {
        chainAnimator.top.combineBasic().property("transform.translation").beginTime(afterContext ?? 0.0).byValue(translate)
        return self
    }
    /// Animate changing `transform.translation.x` by a value.
    ///
    /// - Parameter by: The value to change by.
    ///
    public func translateX(by translateX: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.translation.x").beginTime(afterContext ?? 0.0).byValue(translateX)
        return self
    }
    /// Animate changing `transform.translation.y` by a value.
    ///
    /// - Parameter by: The value to change by.
    ///
    public func translateY(by translateY: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.translation.y").beginTime(afterContext ?? 0.0).byValue(translateY)
        return self
    }
    /// Animate changing `transform.translation.z` by a value.
    ///
    /// - Parameter by: The value to change by.
    ///
    public func translateZ(by translateZ: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.translation.z").beginTime(afterContext ?? 0.0).byValue(translateZ)
        return self
    }
    
    // MARK: - Private.
    /// Calculate the position value from a origin point by the value of anchor point.
    ///
    /// - Parameter from: The origin point to calculate with.
    /// - Returns: A position value calculated from the origin.
    ///
    private func position(from origin: CGPoint) -> CGPoint {
        return CGPoint(x: origin.x + layer.anchorPoint.x*bounds.width, y: origin.y + layer.anchorPoint.y*bounds.height)
    }

}

fileprivate extension CALayer {
    /// Get the initial value of the keypath to animate.
    ///
    /// - Parameter keyPath: The key path to animate on layer.
    /// - Returns: Initial value of the layer for the key path.
    ///
    fileprivate func initial(_ keyPath: String) -> Any? {
        switch keyPath {
        case "position":
            return position
        case "position.x":
            return position.x
        case "position.y":
            return position.y
        case "bounds.size":
            return bounds.size
        case "opacity":
            return opacity
        case "backgroundColor":
            return backgroundColor ?? UIColor.clear.cgColor
        case "borderColor":
            return borderColor ?? UIColor.clear.cgColor
        case "borderWidth":
            return borderWidth
        case "cornerRadius":
            return cornerRadius
        case "transform.scale":
            /*
            return (transform.m11+transform.m22+transform.m33)/3 */
            return value(forKeyPath: keyPath)
        case "transform.scale.x":
            /*
            return transform.m11 */
            return value(forKeyPath: keyPath)
        case "transform.scale.y":
            /*
            return transform.m22 */
            return value(forKeyPath: keyPath)
        case "transform.scale.z":
            /*
            return transform.m33 */
            return value(forKeyPath: keyPath)
        case "transform.rotation":
            return value(forKeyPath: keyPath)
        case "transform.rotation.x":
            return value(forKeyPath: keyPath)
        case "transform.rotation.y":
            return value(forKeyPath: keyPath)
        case "transform.rotation.z":
            return value(forKeyPath: keyPath)
        case "transform.translation":
            /*
            return (transform.m41+transform.m42+transform.m43)/3 */
            return value(forKeyPath: keyPath)
        case "transform.translation.x":
            /*
            return transform.m41 */
            return value(forKeyPath: keyPath)
        case "transform.translation.y":
            /*
            return transform.m42 */
            return value(forKeyPath: keyPath)
        case "transform.translation.z":
            /*
            return transform.m43 */
            return value(forKeyPath: keyPath)
        default: return value(forKeyPath: keyPath)
        }
    }
}
