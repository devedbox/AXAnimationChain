//
//  CAAnimation+Convertable.h
//  AXAnimationChain
//
//  Created by devedbox on 2017/1/3.
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
#import <UIKit/UIKit.h>
#import "CAMediaTimingFunction+Extends.h"
#import "AXSpringAnimation.h"
NS_ASSUME_NONNULL_BEGIN

@interface CAKeyframeAnimation (Convertable)
/// Convert animation from CABasicAnimation.
/// @discusstion Converting keyframe animation from basic animation will use the values function of the timing functions automatically.
///
/// @param basicAnimation basic animation to convert.
/// @return Converted keyframe animation.
///
+ (nullable instancetype)animationWithBasic:(nullable CABasicAnimation *)basicAnimation;
/// Convert animation from CABasicAnimation using custom values function.
///
+ (nullable instancetype)animationWithBasic:(nullable CABasicAnimation *)basicAnimation usingValuesFunction:(nullable double (^)(double t, double b, double c, double d))valuesFunction;
/// Convert animation from CASpringAnimation.
///
/// @param animation spring animation to convert.
/// @return Converted keyframe animation.
+ (nullable instancetype)animationWithSpring:(nullable AXCASpringAnimation *)animation;
@end

@interface CABasicAnimation (Convertable)
/// Convert animation from CAKeyframeAnimation.
/// @discusstion Using default timing function. If the keyfram is converted from a basic animation, the timing dunction will be the one of the basic animation.
///
/// @param animation keyframe animation to convert.
/// @return Converted basic animation.
+ (nullable instancetype)animationWithKeyframe:(nullable CAKeyframeAnimation *)animation;
/// Convert animation from CAKeyframeAnimation using custom timing function.
///
+ (nullable instancetype)animationWithKeyframe:(nullable CAKeyframeAnimation *)animation usingTimingFunction:(nullable CAMediaTimingFunction *)timingFunction;
/// Convert animation from CASpringAnimation.
///
+ (nullable instancetype)animationWithSpring:(nullable AXCASpringAnimation *)animation;
@end

@interface AXCASpringAnimation (Convertable)
/// Convert animation from CABasicAnimation.
///
+ (nullable instancetype)animationWithBasic:(nullable CABasicAnimation *)animation;
@end
NS_ASSUME_NONNULL_END
