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
    private struct AssociateKeys {
        static var afterContext = "afterContext"
        static var waitContext = "waitContext"
    }
    
    public enum AnimationType {
        /*
        public enum EffectType: String {
            case `default`, linear, easeIn, easeOut, easeInOut, easeInSine, easeOutSine, easeInOutSine, easeInQuad, easeOutQuad, easeInOutQuad, easeInCubic, easeOutCubic, easeInOutCubic, easeInQuart, easeOutQuart, easeInOutQuart, easeInQuint, easeOutQuint, easeInOutQuint, easeInExpo, easeOutExpo, easeInOutExpo, easeInCirc, easeOutCirc, easeInOutCirc, easeInBack, easeOutBack, easeInOutBack
        } */
        
        case setted, basic(CAMediaTimingFunction), spring
    }
    
    private var afterContext: Double? {
        get { return (objc_getAssociatedObject(self, &AssociateKeys.afterContext) as? Double) }
        set { objc_setAssociatedObject(self, &AssociateKeys.afterContext, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    private var waitContext: Any {
        get { return objc_getAssociatedObject(self, &AssociateKeys.waitContext) }
        set { objc_setAssociatedObject(self, &AssociateKeys.waitContext, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    // MARK: - Animation type.
    public func basic() -> Self {
        /* animatorContext = kAXAnimatorContextBasic */
        let _ = chainAnimator.top.combinedAnimators?.last?.replace(with: chainAnimator.top.combinedAnimators?.last?.beginBasic())
        return self
    }
    
    public func spring() -> Self {
        /* animatorContext = kAXAnimatorContextSpring */
        let _ = chainAnimator.top.combinedAnimators?.last?.replace(with: chainAnimator.top.combinedAnimators?.last?.beginSpring())
        return self
    }
    
    // MARK: - Animate.
    public func animate(as animationType: AnimationType = .setted, completion: @escaping () -> Void = {}) {
        switch animationType {
        case .basic(let timingFunction):
            if let animators = chainAnimator.top.combinedAnimators {
                for animator in animators {
                    let _ = animator.replace(with: animator.beginBasic().timingFunction(timingFunction))
                }
            }
        case .spring:
            if let animators = chainAnimator.top.combinedAnimators {
                for animator in animators {
                    let _ = animator.replace(with: animator.beginSpring())
                }
            }
        default: break
        }
        chainAnimator.top.start(completion: completion)
    }
    
    // MARK: - Timing control.
    public func duration(_ duration: TimeInterval) -> Self {
        chainAnimator.top.combinedAnimators?.last?.duration(duration)
        return self
    }
    
    public func after(_ duration: TimeInterval) -> Self {
        if let after = afterContext {
            afterContext = after + duration
        } else {
            afterContext = duration
        }
        return self
    }
    
    // MARK: - To values.
    
    public func origin(to origin: CGPoint) -> Self {
        chainAnimator.top.combineBasic().property("position").beginTime(afterContext ?? 0.0).toValue(position(from: origin))
        return self
    }
    
    public func originX(to originX: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("position.x").beginTime(afterContext ?? 0.0).toValue(position(from: CGPoint(x: originX, y: layer.position.y)).x)
        return self
    }
    
    public func originY(to originY: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("position.x").beginTime(afterContext ?? 0.0).toValue(position(from: CGPoint(x: layer.position.x, y: originY)).y)
        return self
    }
    
    public func center(to center: CGPoint) -> Self {
        chainAnimator.top.combineBasic().property("position").beginTime(afterContext ?? 0.0).toValue(center)
        return self
    }
    
    public func centerX(to centerX: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("position.x").beginTime(afterContext ?? 0.0).toValue(CGPoint(x: centerX, y: layer.position.y))
        return self
    }
    
    public func centerY(to centerY: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("position.y").beginTime(afterContext ?? 0.0).toValue(CGPoint(x: layer.position.x, y: centerY))
        return self
    }
    
    public func size(to size: CGSize) -> Self {
        chainAnimator.top.combineBasic().property("bounds.size").beginTime(afterContext ?? 0.0).toValue(size)
        return self
    }
    
    public func width(to width: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("bounds.size").beginTime(afterContext ?? 0.0).toValue(CGSize(width: width, height: layer.bounds.height))
        return self
    }
    
    public func height(to height: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("bounds.size").beginTime(afterContext ?? 0.0).toValue(CGSize(width: layer.bounds.width, height: height))
        return self;
    }
    
    public func frame(to frame: CGRect) -> Self {
        return origin(to: frame.origin).size(to: frame.size)
    }
    
    public func bounds(to bounds: CGRect) -> Self {
        return size(to: bounds.size)
    }
    
    public func opacity(to opacity: Float) -> Self {
        chainAnimator.top.combineBasic().property("opacity").beginTime(afterContext ?? 0.0).toValue(opacity)
        return self
    }
    
    public func backgroundColor(to backgroundColor: UIColor) -> Self {
        chainAnimator.top.combineBasic().property("backgroundColor").beginTime(afterContext ?? 0.0).toValue(backgroundColor.cgColor)
        return self
    }
    
    public func borderColor(to borderColor: UIColor) -> Self {
        chainAnimator.top.combineBasic().property("borderColor").beginTime(afterContext ?? 0.0).toValue(borderColor.cgColor)
        return self
    }
    
    public func borderWidth(to borderWidth: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("borderWidth").beginTime(afterContext ?? 0.0).toValue(borderWidth)
        return self
    }
    
    public func cornerRadius(to cornerRadius: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("cornerRadius").beginTime(afterContext ?? 0.0).toValue(cornerRadius)
        return self
    }
    
    public func scale(to scale: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.scale").beginTime(afterContext ?? 0.0).toValue(scale)
        return self
    }
    
    public func scaleX(to scaleX: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.scale.x").beginTime(afterContext ?? 0.0).toValue(scaleX)
        return self
    }
    
    public func scaleY(to scaleY: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.scale.y").beginTime(afterContext ?? 0.0).toValue(scaleY)
        return self
    }
    
    public func scaleZ(to scaleZ: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.scale.z").beginTime(afterContext ?? 0.0).toValue(scaleZ)
        return self
    }
    
    public func rotate(to rotate: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.rotation").beginTime(afterContext ?? 0.0).toValue(rotate)
        return self
    }
    
    public func rotateX(to rotateX: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.rotation.x").beginTime(afterContext ?? 0.0).toValue(rotateX)
        return self
    }
    
    public func rotateY(to rotateY: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.rotation.y").beginTime(afterContext ?? 0.0).toValue(rotateY)
        return self
    }
    
    public func rotateZ(to rotateZ: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.rotation.z").beginTime(afterContext ?? 0.0).toValue(rotateZ)
        return self
    }
    
    public func translate(to translate: CGPoint) -> Self {
        chainAnimator.top.combineBasic().property("transform.translation").beginTime(afterContext ?? 0.0).toValue(translate)
        return self
    }
    
    public func translateX(to translateX: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.translation.x").beginTime(afterContext ?? 0.0).toValue(translateX)
        return self
    }
    
    public func translateY(to translateY: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.translation.y").beginTime(afterContext ?? 0.0).toValue(translateY)
        return self
    }
    
    public func translateZ(to translateZ: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.translation.z").beginTime(afterContext ?? 0.0).toValue(translateZ)
        return self
    }
    
    public func image(to image: UIImage) -> Self {
        chainAnimator.top.combineBasic().property("contents").beginTime(afterContext ?? 0.0).toValue(image.cgImage as Any)
        return self
    }
    
    // MARK: - By values.
    public func origin(by origin: CGPoint) -> Self {
        chainAnimator.top.combineBasic().property("position").beginTime(afterContext ?? 0.0).byValue(position(from: origin))
        return self
    }
    
    public func originX(by originX: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("position.x").beginTime(afterContext ?? 0.0).byValue(position(from: CGPoint(x: originX, y: layer.position.y)).x)
        return self
    }
    
    public func originY(by originY: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("position.x").beginTime(afterContext ?? 0.0).byValue(position(from: CGPoint(x: layer.position.x, y: originY)).y)
        return self
    }
    
    public func center(by center: CGPoint) -> Self {
        chainAnimator.top.combineBasic().property("position").beginTime(afterContext ?? 0.0).byValue(center)
        return self
    }
    
    public func centerX(by centerX: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("position.x").beginTime(afterContext ?? 0.0).byValue(CGPoint(x: centerX, y: layer.position.y))
        return self
    }
    
    public func centerY(by centerY: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("position.y").beginTime(afterContext ?? 0.0).byValue(CGPoint(x: layer.position.x, y: centerY))
        return self
    }
    
    public func size(by size: CGSize) -> Self {
        chainAnimator.top.combineBasic().property("bounds.size").beginTime(afterContext ?? 0.0).byValue(size)
        return self
    }
    
    public func width(by width: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("bounds.size").beginTime(afterContext ?? 0.0).byValue(CGSize(width: width, height: layer.bounds.height))
        return self
    }
    
    public func height(by height: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("bounds.size").beginTime(afterContext ?? 0.0).byValue(CGSize(width: layer.bounds.width, height: height))
        return self;
    }
    
    public func frame(by frame: CGRect) -> Self {
        return origin(by: frame.origin).size(by: frame.size)
    }
    
    public func bounds(by bounds: CGRect) -> Self {
        return size(by: bounds.size)
    }
    
    public func opacity(by opacity: Float) -> Self {
        chainAnimator.top.combineBasic().property("opacity").beginTime(afterContext ?? 0.0).byValue(opacity)
        return self
    }
    
    public func backgroundColor(by backgroundColor: UIColor) -> Self {
        chainAnimator.top.combineBasic().property("backgroundColor").beginTime(afterContext ?? 0.0).byValue(backgroundColor.cgColor)
        return self
    }
    
    public func borderColor(by borderColor: UIColor) -> Self {
        chainAnimator.top.combineBasic().property("borderColor").beginTime(afterContext ?? 0.0).byValue(borderColor.cgColor)
        return self
    }
    
    public func borderWidth(by borderWidth: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("borderWidth").beginTime(afterContext ?? 0.0).byValue(borderWidth)
        return self
    }
    
    public func cornerRadius(by cornerRadius: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("cornerRadius").beginTime(afterContext ?? 0.0).byValue(cornerRadius)
        return self
    }
    
    public func scale(by scale: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.scale").beginTime(afterContext ?? 0.0).byValue(scale)
        return self
    }
    
    public func scaleX(by scaleX: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.scale.x").beginTime(afterContext ?? 0.0).byValue(scaleX)
        return self
    }
    
    public func scaleY(by scaleY: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.scale.y").beginTime(afterContext ?? 0.0).byValue(scaleY)
        return self
    }
    
    public func scaleZ(by scaleZ: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.scale.z").beginTime(afterContext ?? 0.0).byValue(scaleZ)
        return self
    }
    
    public func rotate(by rotate: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.rotation").beginTime(afterContext ?? 0.0).byValue(rotate)
        return self
    }
    
    public func rotateX(by rotateX: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.rotation.x").beginTime(afterContext ?? 0.0).byValue(rotateX)
        return self
    }
    
    public func rotateY(by rotateY: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.rotation.y").beginTime(afterContext ?? 0.0).byValue(rotateY)
        return self
    }
    
    public func rotateZ(by rotateZ: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.rotation.z").beginTime(afterContext ?? 0.0).byValue(rotateZ)
        return self
    }
    
    public func translate(by translate: CGPoint) -> Self {
        chainAnimator.top.combineBasic().property("transform.translation").beginTime(afterContext ?? 0.0).byValue(translate)
        return self
    }
    
    public func translateX(by translateX: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.translation.x").beginTime(afterContext ?? 0.0).byValue(translateX)
        return self
    }
    
    public func translateY(by translateY: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.translation.y").beginTime(afterContext ?? 0.0).byValue(translateY)
        return self
    }
    
    public func translateZ(by translateZ: CGFloat) -> Self {
        chainAnimator.top.combineBasic().property("transform.translation.z").beginTime(afterContext ?? 0.0).byValue(translateZ)
        return self
    }
    
    // MARK: - Private.
    
    private func position(from origin: CGPoint) -> CGPoint {
        return CGPoint(x: origin.x + layer.anchorPoint.x*bounds.width, y: origin.y + layer.anchorPoint.y*bounds.height)
    }

}
