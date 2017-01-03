//
//  CAMediaTimingFunction+Extends.h
//  AXAnimationChain
//
//  Created by devedbox on 2017/1/3.
//  Copyright © 2017年 devedbox. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
/// Timing functions for easings: http://easings.net/zh-cn
@interface CAMediaTimingFunction (Extends)
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
@end
