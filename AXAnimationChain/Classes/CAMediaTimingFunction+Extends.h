//
//  CAMediaTimingFunction+Extends.h
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
/// Timing functions for easings: http://easings.net/zh-cn
@interface CAMediaTimingFunction (Extends)
// System default:
+ (instancetype)defaultTimingFunction;
+ (instancetype)linear;
+ (instancetype)easeIn;
+ (instancetype)easeOut;
+ (instancetype)easeInOut;

+ (instancetype)easeInSine;
+ (instancetype)easeOutSine;
+ (instancetype)easeInOutSine;
+ (instancetype)easeInQuad;
+ (instancetype)easeOutQuad;
+ (instancetype)easeInOutQuad;
+ (instancetype)easeInCubic;
+ (instancetype)easeOutCubic;
+ (instancetype)easeInOutCubic;
+ (instancetype)easeInQuart;
+ (instancetype)easeOutQuart;
+ (instancetype)easeInOutQuart;
+ (instancetype)easeInQuint;
+ (instancetype)easeOutQuint;
+ (instancetype)easeInOutQuint;
+ (instancetype)easeInExpo;
+ (instancetype)easeOutExpo;
+ (instancetype)easeInOutExpo;
+ (instancetype)easeInCirc;
+ (instancetype)easeOutCirc;
+ (instancetype)easeInOutCirc;
+ (instancetype)easeInBack;
+ (instancetype)easeOutBack;
+ (instancetype)easeInOutBack;

- (double (^)(double t, double b, double c, double d))valuesFuntion;

+ (double (^)(double t, double b, double c, double d, double mass, double stiffness, double damping))springValuesFunction;

+ (double (^)(double t, double b, double c, double d))easeInElasticValuesFuntion;
+ (double (^)(double t, double b, double c, double d))easeOutElasticValuesFuntion;
+ (double (^)(double t, double b, double c, double d))easeInOutElasticValuesFuntion;
+ (double (^)(double t, double b, double c, double d))easeInBounceValuesFuntion;
+ (double (^)(double t, double b, double c, double d))easeOutBounceValuesFuntion;
+ (double (^)(double t, double b, double c, double d))easeInOutBounceValuesFuntion;
@end
