//
//  AXChainAnimator.swift
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

public extension AXChainAnimator {
    /// A convenient method to combine the complete function and start function.
    ///
    /// - parameter completion: completion handler of the animator.
    ///
    public func start(completion: @escaping () -> Void = {}) {
        // Call the complete function and start function.
        self.complete(completion).start()
    }
}

public extension AXChainAnimator {
    /// Replace self of super animator's combined animators with a new animator.
    ///
    /// - Parameter with: animator to be replaced.
    /// - Returns: The animator if repalce succeed, or self.
    ///
    public func replace(with animator: AXChainAnimator?) -> Self {
        guard let _ = animator else {
            return self
        }
        // If super animator does not exits, return self.
        guard let _ = superAnimator else {
            return self
        }
        
        var _combinedAnimators = superAnimator!.combinedAnimators
        // If combined animators of super does not has any elements, return self.
        guard let _ = _combinedAnimators else {
            return self
        }
        // If combined animators of super does not contain self, return self.
        guard _combinedAnimators!.contains(self) else {
            return self
        }
        
        _combinedAnimators![_combinedAnimators!.index(of: self)!] = animator!
        superAnimator!.combinedAnimators = _combinedAnimators
        
        return type(of: self).init(animator:animator!)
    }
}
