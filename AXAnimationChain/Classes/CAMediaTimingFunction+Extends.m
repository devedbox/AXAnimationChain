//
//  CAMediaTimingFunction+Extends.m
//  AXAnimationChain
//
//  Created by devedbox on 2017/1/3.
//  Copyright © 2017年 devedbox. All rights reserved.
//

#import "CAMediaTimingFunction+Extends.h"

@implementation CAMediaTimingFunction (Extends)
+ (instancetype)easeInSince {
    return [self functionWithControlPoints:0.47 :0 :0.745 :0.715];
}

+ (instancetype)easeOutSince {
    return [self functionWithControlPoints:0.39 :0.575 :0.565 :1];
}

+ (instancetype)easeInOutSine {
    return [self functionWithControlPoints:0.445 :0.05 :0.55 :0.95];
}

+ (instancetype)easeInQuad {
    return [self functionWithControlPoints:0.55 :0.085 :0.68 :0.53];
}

+ (instancetype)easeOutQuad {
    return [self functionWithControlPoints:0.25 :0.46 :0.45 :0.94];
}

+ (instancetype)easeInOutQuad {
    return [self functionWithControlPoints:0.455 :0.03 :0.515 :0.955];
}

+ (instancetype)easeInCubic {
    return [self functionWithControlPoints:0.55 :0.055 :0.675 :0.19];
}

+ (instancetype)easeOutCubic {
    return [self functionWithControlPoints:0.215 :0.61 :0.355 :1];
}

+ (instancetype)easeInOutCubic {
    return [self functionWithControlPoints:0.645 :0.045 :0.355 :1];
}

+ (instancetype)easeInQuart {
    return [self functionWithControlPoints:0.895 :0.03 :0.685 :0.22];
}

+ (instancetype)easeOutQuart {
    return [self functionWithControlPoints:0.165 :0.84 :0.44 :1];
}

+ (instancetype)easeInOutQuart {
    return [self functionWithControlPoints:0.77 :0 :0.175 :1];
}

+ (instancetype)easeInQuint {
    return [self functionWithControlPoints:0.755 :0.05 :0.855 :0.06];
}

+ (instancetype)easeOutQuint {
    return [self functionWithControlPoints:0.23 :1 :0.32 :1];
}

+ (instancetype)easeInOutQuint {
    return [self functionWithControlPoints:0.86 :0 :0.07 :1];
}

+ (instancetype)easeInExpo {
    return [self functionWithControlPoints:0.95 :0.05 :0.795 :0.035];
}

+ (instancetype)easeOutExpo {
    return [self functionWithControlPoints:0.19 :1 :0.22 :1];
}

+ (instancetype)easeInOutExpo {
    return [self functionWithControlPoints:1 :0 :0 :1];
}

+ (instancetype)easeInCirc {
    return [self functionWithControlPoints:0.6 :0.04 :0.98 :0.335];
}

+ (instancetype)easeOutCirc {
    return [self functionWithControlPoints:0.075 :0.82 :0.165 :1];
}

+ (instancetype)easeInOutCirc {
    return [self functionWithControlPoints:0.785 :0.135 :0.15 :0.86];
}

+ (instancetype)easeInBack {
    return [self functionWithControlPoints:0.6 :-0.28 :0.735 :0.045];
}

+ (instancetype)easeOutBack {
    return [self functionWithControlPoints:0.175 :0.885 :0.32 :1.275];
}

+ (instancetype)easeInOutBack {
    return [self functionWithControlPoints:0.68 :-0.55 :0.265 :1.55];
}
@end
