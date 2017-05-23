//
//  CAAnimation+ImmediateValue.h
//  AXAnimationChain
//
//  Created by devedbox on 2017/4/1.
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

#import <QuartzCore/QuartzCore.h>

#ifndef AXDisableImmediateValue
#define AXDisableImmediateValue(AnimationClass) \
@interface AnimationClass (ImmediateValue)\
- (nullable id)immediateValueAtTime:(CFTimeInterval)time error:(NSError __autoreleasing * _Nullable *_Nullable)error __attribute__((unavailable));\
@end
#endif

extern NSUInteger const kAXImmediateValueCannotBeCalculatedErrorCode;

/// Get the immediate value of the animation values.
/// @discusstion Do not using this method on `CAAnimation`, `CATransition` and `CAAnimationGroup`, because these
/// animations cannot be calculated. if u try to call `immediateValueAtTime` on those animations,
/// There will be an exception throwed.
///
@interface CAAnimation (ImmediateValue)
/// Immediate value from the value function.
///
/// @importance `keyTimes` and `path` properties of keyframe animation is not allowed.
///
- (nullable id)immediateValueAtTime:(CFTimeInterval)time error:(NSError __autoreleasing * _Nullable *_Nullable)error;
@end

AXDisableImmediateValue(CATransition)
AXDisableImmediateValue(CAAnimationGroup)
