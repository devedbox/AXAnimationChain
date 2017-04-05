//
//  AXDecayAnimation.m
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

@import UIKit;
@import Foundation;
#import "AXDecayAnimation.h"
#import "CAMediaTimingFunction+Extends.h"

extern NSArray * CGPointValuesWithComponents(NSArray *xValues, NSArray *yValues);
extern NSArray * CGSizeValuesWithComponents(NSArray *widthValues, NSArray *heightValues);
extern NSArray * CGRectValuesWithComponents(NSArray *xValues, NSArray *yValues, NSArray *widths, NSArray *heights);
extern NSArray * UIColorValuesWithComponents(NSArray *redValues, NSArray *greenValues, NSArray *blueValues, NSArray *alphaValues);
extern NSArray * CATransform3DValuesWithComponents(NSArray *m11, NSArray *m12, NSArray *m13, NSArray *m14, NSArray *m21, NSArray *m22, NSArray *m23, NSArray *m24, NSArray *m31, NSArray *m32, NSArray *m33, NSArray *m34, NSArray *m41, NSArray *m42, NSArray *m43, NSArray *m44);

static NSArray * _AXDecayNSNumberValuesCaculationWithBeginValue(CGFloat beginNumber, NSTimeInterval duration, CAMediaTimingFunction *timing, CAKeyframeValuesFunction function) {
    // 69 FPS per second.
    NSUInteger components = (NSUInteger)ceil(69 * duration)+2;
    
    NSMutableArray *numbers = [NSMutableArray arrayWithCapacity:components];
    
    const double increment = 1.0 / (double)(components - 1);
    
    double progress = 0.0,
    v,
    value = beginNumber;
    
    NSUInteger i;
    // Add the begin number to the numbers in case of losing first frame.
    [numbers addObject:@(beginNumber)];
    for (i = 1; i < components; i++)
    {
        v = (function?:timing.valuesFuntion)(duration * progress * 1000, 0, 1, duration/components);
        value = value + v;
        
        [numbers addObject:@(value)];
        
        progress += increment;
    }
    
    return [numbers copy];
}

NSArray * _AXDecayKeyframeValuesWithBeginFrame(id fromValue, NSTimeInterval duration, CAMediaTimingFunction *timing, CAKeyframeValuesFunction function)
{
    id beginValue;
    beginValue = fromValue;
    
    if ([beginValue isKindOfClass:[NSNumber class]]) {
        return
        _AXDecayNSNumberValuesCaculationWithBeginValue([beginValue floatValue], duration, timing, function);
    } else if ([beginValue isKindOfClass:[UIColor class]]) {
        const CGFloat *fromComponents = CGColorGetComponents(((UIColor*)beginValue).CGColor);
        return UIColorValuesWithComponents(
                                           _AXDecayNSNumberValuesCaculationWithBeginValue(fromComponents[0], duration, timing, function),
                                           _AXDecayNSNumberValuesCaculationWithBeginValue(fromComponents[1], duration, timing, function),
                                           _AXDecayNSNumberValuesCaculationWithBeginValue(fromComponents[2], duration, timing, function),
                                           _AXDecayNSNumberValuesCaculationWithBeginValue(fromComponents[3], duration, timing, function)
                                           );
    } else if ([beginValue isKindOfClass:[NSValue class]]) {
        NSString *valueType = [NSString stringWithCString:[beginValue objCType] encoding:NSStringEncodingConversionAllowLossy];
        if ([valueType rangeOfString:@"CGRect"].location == 1) {
            CGRect fromRect = [beginValue CGRectValue];
            return CGRectValuesWithComponents(_AXDecayNSNumberValuesCaculationWithBeginValue(fromRect.origin.x, duration, timing, function),
                                              _AXDecayNSNumberValuesCaculationWithBeginValue(fromRect.origin.y, duration, timing, function),
                                              _AXDecayNSNumberValuesCaculationWithBeginValue(fromRect.size.width, duration, timing, function),
                                              _AXDecayNSNumberValuesCaculationWithBeginValue(fromRect.size.height, duration, timing, function));
            
        } else if ([valueType rangeOfString:@"CGPoint"].location == 1) {
            CGPoint fromPoint = [beginValue CGPointValue];
            return CGPointValuesWithComponents(
                                               _AXDecayNSNumberValuesCaculationWithBeginValue(fromPoint.x, duration, timing, function),
                                               _AXDecayNSNumberValuesCaculationWithBeginValue(fromPoint.y, duration, timing, function)
                                               );
            
        } else if ([valueType rangeOfString:@"CATransform3D"].location == 1) {
            CATransform3D fromTransform = [beginValue CATransform3DValue];
            return CATransform3DValuesWithComponents(
                                                     _AXDecayNSNumberValuesCaculationWithBeginValue(fromTransform.m11, duration, timing, function),
                                                     _AXDecayNSNumberValuesCaculationWithBeginValue(fromTransform.m12, duration, timing, function),
                                                     _AXDecayNSNumberValuesCaculationWithBeginValue(fromTransform.m13, duration, timing, function),
                                                     _AXDecayNSNumberValuesCaculationWithBeginValue(fromTransform.m14, duration, timing, function),
                                                     _AXDecayNSNumberValuesCaculationWithBeginValue(fromTransform.m21, duration, timing, function),
                                                     _AXDecayNSNumberValuesCaculationWithBeginValue(fromTransform.m22, duration, timing, function),
                                                     _AXDecayNSNumberValuesCaculationWithBeginValue(fromTransform.m23, duration, timing, function),
                                                     _AXDecayNSNumberValuesCaculationWithBeginValue(fromTransform.m24, duration, timing, function),
                                                     _AXDecayNSNumberValuesCaculationWithBeginValue(fromTransform.m31, duration, timing, function),
                                                     _AXDecayNSNumberValuesCaculationWithBeginValue(fromTransform.m32, duration, timing, function),
                                                     _AXDecayNSNumberValuesCaculationWithBeginValue(fromTransform.m33, duration, timing, function),
                                                     _AXDecayNSNumberValuesCaculationWithBeginValue(fromTransform.m34, duration, timing, function),
                                                     _AXDecayNSNumberValuesCaculationWithBeginValue(fromTransform.m41, duration, timing, function),
                                                     _AXDecayNSNumberValuesCaculationWithBeginValue(fromTransform.m42, duration, timing, function),
                                                     _AXDecayNSNumberValuesCaculationWithBeginValue(fromTransform.m43, duration, timing, function),
                                                     _AXDecayNSNumberValuesCaculationWithBeginValue(fromTransform.m44, duration, timing, function)
                                                     );
        } else if ([valueType rangeOfString:@"CGSize"].location == 1) {
            CGSize fromSize = [beginValue CGSizeValue];
            return CGSizeValuesWithComponents(
                                              _AXDecayNSNumberValuesCaculationWithBeginValue(fromSize.width, duration, timing, function),
                                              _AXDecayNSNumberValuesCaculationWithBeginValue(fromSize.height, duration, timing, function)
                                              );
        }
    }
    return nil;
}

@interface AXDecayAnimation ()
/// Handled ve.
@property(assign, nonatomic) CGFloat handledVelocity;
@end

@implementation AXDecayAnimation
- (instancetype)init {
    if (self = [super init]) {
        [self initializer];
    }
    return self;
}

- (void)initializer {
    _velocity = 0.0;
    _handledVelocity = 0.0;
    _deceleration = 0.998;
    
    super.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
}

- (void)setVelocity:(CGFloat)velocity {
    _velocity = velocity;
    _handledVelocity = _velocity;
    [self _setValues];
}

- (void)setDeceleration:(CGFloat)deceleration {
    _deceleration = deceleration;
    [self _setValues];
}

- (void)setTimingFunction:(CAMediaTimingFunction *)timingFunction {
    @throw @"Decay animation won't be effected by timing function.";
}

- (CFTimeInterval)settlingDuration {
    // compute duration till threshold velocity
    float scaledVelocity = _velocity / 1000.;
    
    double k = 1 * 5. / 1000.;
    double v = k / scaledVelocity;
    double d = log(_deceleration) * 1000.;
    double duration = log(fabs(v)) / d;
    
    // ensure velocity threshold is exceeded
    if (isnan(duration) || duration < 0) {
        duration = 0;
    }
    // return log(0.0001)/log(_deceleration);
    return duration;
}

- (void)_setValues {
    _handledVelocity = _velocity;
    
    NSTimeInterval duration = self.settlingDuration;
    super.duration = duration;
    NSArray *values = _AXDecayKeyframeValuesWithBeginFrame(self.fromValue, duration, self.timingFunction, ^double(double t, double b, double c, double d) {
        // v0 = v / 1000
        // v = v0 * powf(deceleration, dt);
        // v = v * 1000;
        
        // x0 = x;
        // x = x0 + v0 * deceleration * (1 - powf(deceleration, dt)) / (1 - deceleration)
        float v0;
        float dt = /*(t/d)*duration*1000.*/d*1000.;
        float kv = powf(_deceleration, dt);
        float kx = _deceleration * (1 - kv) / (1 - _deceleration);
        
        v0 = _handledVelocity / 1000.;
        _handledVelocity = v0 * kv * 1000.;
        // x = x + v0 * kx;
        return v0*kx;
    });
    
    super.values = values;
}
@end
