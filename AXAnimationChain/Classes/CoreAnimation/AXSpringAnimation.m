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

extern NSArray * CAKeyframeValuesWithFrames(id fromValue, id toValue, NSTimeInterval duration, CAMediaTimingFunction *timing, _ function);
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
    super.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
}

- (void)setMass:(CGFloat)mass {
    _mass = mass;
    [self _setValues];
}

- (void)setStiffness:(CGFloat)stiffness {
    _stiffness = stiffness;
    [self _setValues];
}

- (void)setDamping:(CGFloat)damping {
    _damping = damping;
    [self _setValues];
}

- (void)setInitialVelocity:(CGFloat)initialVelocity {
    _initialVelocity = initialVelocity;
    [self _setValues];
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
    double beta = _damping/(2*_mass);
    double omega0 = sqrt(_stiffness/_mass);
    
    double flag = -(log(0.001))/MIN(beta, omega0);
    double duration = -(log(0.0004))/MIN(beta, omega0);
    
    return (flag+duration)/2;
}

- (void)_setValues {
    /*
    self.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]; */
    
    id fromValue;
    id toValue;
    if (self.fromValue && self.toValue) {
        fromValue = self.fromValue;
        toValue = self.toValue;
    } else if (self.fromValue && self.byValue) {
        fromValue = self.fromValue;
        toValue = ToValueByValueWithValue(self.fromValue, self.byValue, YES);
    } else if (self.byValue && self.toValue) {
        fromValue = ToValueByValueWithValue(self.toValue, self.byValue, NO);
        toValue = self.toValue;
    }
    
    if (fromValue && toValue) {
        super.values = CAKeyframeValuesWithFrames(fromValue, toValue, self.settlingDuration, self.timingFunction, ^double (double t, double b, double c, double d) {
            t = t/d*self.settlingDuration;
            double beta = _damping/(2*_mass);
            double omega0 = sqrt(_stiffness/_mass);
            double omega  = sqrt(fabs(pow(omega0, 2.0)-pow(beta, 2.0)));
            if (beta >= omega0) {
                beta = beta > omega0 ? omega0 : beta;
                return (1-exp(-beta*t)*(1-(_initialVelocity-beta)*t))*(c-b)+b;
            } else {
                return (1-exp(-beta*t)*(cos(omega*t)-sin(omega*t)*((_initialVelocity-beta)/omega)))*(c-b)+b;
            }
        });
    }
}
@end
