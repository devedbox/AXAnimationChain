//
//  AXSpringAnimation.m
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

#import "AXSpringAnimation.h"

typedef double (^_)(double t, double b, double c, double d);
extern NSArray * AnimationValuesForCAKeyframeAnimationWithFrames(id fromValue, id toValue, NSTimeInterval duration, CAMediaTimingFunction *timing, _ function);
extern id ToValueByValueWithValue(id value, id byValue, BOOL plus);

@implementation AXSpringAnimation
- (instancetype)init {
    if (self = [super init]) {
        [self initializer];
    }
    return self;
}

- (void)initializer {
    _mass = 1;
    _stiffness = 100;
    _damping = 10;
}

- (void)setMass:(CGFloat)mass {
    _mass = mass;
}

- (void)setStiffness:(CGFloat)stiffness {
    _stiffness = stiffness;
}

- (void)setDamping:(CGFloat)damping {
    _damping = damping;
}

- (void)setInitialVelocity:(CGFloat)initialVelocity {
    _initialVelocity = initialVelocity;
}

- (void)setFromValue:(id)fromValue {
    _fromValue = fromValue;
    [self _setValues];
}

- (void)setByValue:(id)byValue {
    _byValue = byValue;
    [self _setValues];
}

- (void)setToValue:(id)toValue {
    _toValue = toValue;
    [self _setValues];
}

- (CFTimeInterval)settlingDuration {
    return (-(2.0*_mass*log(0.001))/_damping);
}

- (void)_setValues {
    self.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    if (self.fromValue && self.toValue) {
        super.values = AnimationValuesForCAKeyframeAnimationWithFrames(self.fromValue, self.toValue, self.settlingDuration, self.timingFunction, ^double (double t, double b, double c, double d) {
            return (1-exp(-_damping/(2*_mass)*t)*cos(sqrt(fabs(_stiffness/_mass-pow(_damping/(2*_mass), 2.0)))*t/(d/self.settlingDuration)))*(c-b)+b;
        });
    } else if (self.fromValue && self.byValue) {
        super.values = AnimationValuesForCAKeyframeAnimationWithFrames(self.fromValue, ToValueByValueWithValue(self.fromValue, self.byValue, YES), self.settlingDuration, self.timingFunction, ^double (double t, double b, double c, double d) {
            return (1-exp(-_damping/(2*_mass)*t)*cos(sqrt(fabs(_stiffness/_mass-pow(_damping/(2*_mass), 2.0)))*t/(d/self.settlingDuration)))*(c-b)+b;
        });
    } else if (self.byValue && self.toValue) {
        super.values = AnimationValuesForCAKeyframeAnimationWithFrames(ToValueByValueWithValue(self.toValue, self.byValue, NO), self.toValue, self.settlingDuration, self.timingFunction, ^double (double t, double b, double c, double d) {
            return (1-exp(-_damping/(2*_mass)*t)*cos(sqrt(fabs(_stiffness/_mass-pow(_damping/(2*_mass), 2.0)))*t/(d/self.settlingDuration)))*(c-b)+b;
        });
    }
}
@end
