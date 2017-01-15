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
import AXAnimationChain

extension UIView {
    public func tada() {
        self.chainAnimator.basic.property("transform.scale").fromValue(1.0).toValue(1.1).duration(0.15).combineBasic().property("transform.rotation").byValue(M_PI/21.0).duration(0.1).autoreverses().repeatCount(2).combineBasic().beginTime(0.1).property("transform.rotation").byValue(-M_PI/18.0).duration(0.1).autoreverses().repeatCount(2).nextToBasic().property("transform.scale").toValue(1.0).duration(0.15).start()
    }
    public func bonuce() {
        self.chainAnimator.basic.property("position.y").byValue(50).toValue(self.layer.position.y).duration(0.5).easeOutBounce().start()
    }
    public func pulse() {
        self.chainAnimator.basic.property("transform.scale").byValue(0.1).duration(0.5).linear().autoreverses().start()
    }
}
