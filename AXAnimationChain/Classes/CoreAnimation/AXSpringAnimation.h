//
//  AXSpringAnimation.h
//  AXAnimationChain
//
//  Created by devedbox on 2017/1/8.
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

#ifndef AXCASpringAnimation
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
#define AXCASpringAnimation CASpringAnimation
#else
#define AXCASpringAnimation AXSpringAnimation
#endif
#endif

NS_ASSUME_NONNULL_BEGIN
@interface AXSpringAnimation : CAKeyframeAnimation
/* The mass of the object attached to the end of the spring. Must be greater
 than 0. Defaults to one. */

@property(assign, nonatomic) CGFloat mass;

/* The spring stiffness coefficient. Must be greater than 0.
 * Defaults to 100. */

@property(assign, nonatomic) CGFloat stiffness;

/* The damping coefficient. Must be greater than or equal to 0.
 * Defaults to 10. */

@property(assign, nonatomic) CGFloat damping;

/* The initial velocity of the object attached to the spring. Defaults
 * to zero, which represents an unmoving object. Negative values
 * represent the object moving away from the spring attachment point,
 * positive values represent the object moving towards the spring
 * attachment point. */

@property(assign, nonatomic) CGFloat initialVelocity;

/* Returns the estimated duration required for the spring system to be
 * considered at rest. The duration is evaluated for the current animation
 * parameters. */

@property(readonly, nonatomic) CFTimeInterval settlingDuration;

/* The objects defining the property values being interpolated between.
 * All are optional, and no more than two should be non-nil. The object
 * type should match the type of the property being animated (using the
 * standard rules described in CALayer.h). The supported modes of
 * animation are:
 *
 * - both `fromValue' and `toValue' non-nil. Interpolates between
 * `fromValue' and `toValue'.
 *
 * - `fromValue' and `byValue' non-nil. Interpolates between
 * `fromValue' and `fromValue' plus `byValue'.
 *
 * - `byValue' and `toValue' non-nil. Interpolates between `toValue'
 * minus `byValue' and `toValue'. */

@property(nullable, strong, nonatomic) id fromValue;
@property(nullable, strong, nonatomic) id toValue;
@property(nullable, strong, nonatomic) id byValue;
@end

@interface AXSpringAnimation (Unavailable)
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
