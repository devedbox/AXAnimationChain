//
//  AXDecayAnimation.h
//  AXAnimationChain
//
//  Created by devedbox on 2017/3/31.
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
NS_ASSUME_NONNULL_BEGIN
@interface AXDecayAnimation : CAKeyframeAnimation
/* The initial velocity of the object attached to the spring. Defaults
 * to zero, which represents an unmoving object. Negative values
 * represent the object moving away from the spring attachment point,
 * positive values represent the object moving towards the spring
 * attachment point. */
@property(assign, nonatomic) CGFloat velocity;
/**
 @abstract The deceleration factor.
 @discussion Values specifies should be in the range [0, 1]. Lower values results in faster deceleration. Defaults to 0.998.
 */
@property(assign, nonatomic) CGFloat deceleration;
/**
 @abstract The expected duration.
 @discussion Derived based on input velocity and deceleration values.
 */
@property(readonly, nonatomic) CFTimeInterval settlingDuration;

@property(nullable, strong, nonatomic) id fromValue;
@end

@interface AXDecayAnimation (Unavailable)
- (void)setTimingFunction:(CAMediaTimingFunction *)timingFunction __attribute__((unavailable));
- (void)setValues:(NSArray *)values __attribute__((unavailable));
- (void)setPath:(CGPathRef)path __attribute__((unavailable));
- (void)setKeyTimes:(NSArray<NSNumber *> *)keyTimes __attribute__((unavailable));
- (void)setTimingFunctions:(NSArray<CAMediaTimingFunction *> *)timingFunctions __attribute__((unavailable));
- (void)setCalculationMode:(NSString *)calculationMode __attribute__((unavailable));
- (void)setTensionValues:(NSArray<NSNumber *> *)tensionValues __attribute__((unavailable));
- (void)setContinuityValues:(NSArray<NSNumber *> *)continuityValues __attribute__((unavailable));
- (void)setBiasValues:(NSArray<NSNumber *> *)biasValues __attribute__((unavailable));
- (void)setRotationMode:(NSString *)rotationMode __attribute__((unavailable));
@end
NS_ASSUME_NONNULL_END
