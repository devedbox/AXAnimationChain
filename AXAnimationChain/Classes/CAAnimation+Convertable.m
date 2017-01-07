//
//  CAAnimation+Convertable.m
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

#import "CAAnimation+Convertable.h"

@implementation CAAnimation (Convertable)

@end

typedef double (^_)(double t, double b, double c, double d);

static NSArray * NSNumberValuesBetweenNumbersAndDuration(CGFloat beginNumber, CGFloat endNumber, NSTimeInterval duration, CAMediaTimingFunction *timing, _ function) {
    // 69 FPS per second.
    NSUInteger components = (NSUInteger)ceil(69 * duration)+2;
    
    NSMutableArray *numbers = [NSMutableArray arrayWithCapacity:components];
    
    const double increment = 1.0 / (double)(components - 1);
    
    double progress = 0.0,
    v = 0.0,
    value = 0.0;
    
    NSUInteger i;
    // Add the begin number to the numbers in case of losing first frame.
    [numbers addObject:@(beginNumber)];
    for (i = 1; i < components; i++)
    {
        v = timing.valuesFuntion(duration * progress * 1000, 0, 1, duration * 1000);
        value = beginNumber + v * (endNumber - beginNumber);
        
        [numbers addObject:@(value)];
        
        progress += increment;
    }
    // Add the end number to the numbers in case of losing last frame.
    [numbers addObject:@(endNumber)];
    
    return [numbers copy];
}

static NSArray * UIColorValuesWithComponents(NSArray *redValues, NSArray *greenValues, NSArray *blueValues, NSArray *alphaValues) {
    if (!(redValues.count == blueValues.count && redValues.count == greenValues.count && redValues.count == alphaValues.count)) return nil;
    
    NSUInteger numberOfColors = redValues.count;
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:numberOfColors];
    UIColor *value;
    
    for (NSInteger i = 1; i < numberOfColors; i++) {
        value = [UIColor colorWithRed:[[redValues objectAtIndex:i] floatValue]
                                green:[[greenValues objectAtIndex:i] floatValue]
                                 blue:[[blueValues objectAtIndex:i] floatValue]
                                alpha:[[alphaValues objectAtIndex:i] floatValue]];
        [values addObject:(id)value.CGColor];
    }
    return values;
}

static NSArray * CGRectValuesWithComponents(NSArray *xValues, NSArray *yValues, NSArray *widths, NSArray *heights) {
    if (!(xValues.count == yValues.count && xValues.count == widths.count && xValues.count == heights.count)) return nil;
    
    NSUInteger numberOfRects = xValues.count;
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:numberOfRects];
    CGRect value;
    
    for (NSInteger i = 1; i < numberOfRects; i++) {
        value = CGRectMake(
                           [[xValues objectAtIndex:i] floatValue],
                           [[yValues objectAtIndex:i] floatValue],
                           [[widths objectAtIndex:i] floatValue],
                           [[heights objectAtIndex:i] floatValue]
                           );
        [values addObject:[NSValue valueWithCGRect:value]];
    }
    return values;
}

static NSArray * CGPointValuesWithComponents(NSArray *xValues, NSArray *yValues) {
    if (xValues.count != yValues.count) return nil;
    
    NSUInteger numberOfPoints = xValues.count;
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:numberOfPoints];
    CGPoint value;
    
    for (NSInteger i = 1; i < numberOfPoints; i++) {
        value = CGPointMake(
                            [[xValues objectAtIndex:i] floatValue],
                            [[yValues objectAtIndex:i] floatValue]
                            );
        [values addObject:[NSValue valueWithCGPoint:value]];
    }
    return values;
}

static NSArray * CGSizeValuesWithComponents(NSArray *widthValues, NSArray *heightValues) {
    if (widthValues.count != heightValues.count) return nil;
    
    NSUInteger numberOfSizes = widthValues.count;
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:numberOfSizes];
    CGSize value;
    
    for (NSInteger i = 1; i < numberOfSizes; i++) {
        value = CGSizeMake(
                           [[widthValues objectAtIndex:i] floatValue],
                           [[heightValues objectAtIndex:i] floatValue]
                           );
        [values addObject:[NSValue valueWithCGSize:value]];
    }
    return values;
}

static NSArray * CATransform3DValuesWithComponents(NSArray *m11, NSArray *m12, NSArray *m13, NSArray *m14, NSArray *m21, NSArray *m22, NSArray *m23, NSArray *m24, NSArray *m31, NSArray *m32, NSArray *m33, NSArray *m34, NSArray *m41, NSArray *m42, NSArray *m43, NSArray *m44) {
    NSUInteger numberOfTransforms = m11.count;
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:numberOfTransforms];
    CATransform3D value;
    
    for (NSInteger i = 1; i < numberOfTransforms; i++) {
        value = CATransform3DIdentity;
        value.m11 = [[m11 objectAtIndex:i] floatValue];
        value.m12 = [[m12 objectAtIndex:i] floatValue];
        value.m13 = [[m13 objectAtIndex:i] floatValue];
        value.m14 = [[m14 objectAtIndex:i] floatValue];
        
        value.m21 = [[m21 objectAtIndex:i] floatValue];
        value.m22 = [[m22 objectAtIndex:i] floatValue];
        value.m23 = [[m23 objectAtIndex:i] floatValue];
        value.m24 = [[m24 objectAtIndex:i] floatValue];
        
        value.m31 = [[m31 objectAtIndex:i] floatValue];
        value.m32 = [[m32 objectAtIndex:i] floatValue];
        value.m33 = [[m33 objectAtIndex:i] floatValue];
        value.m44 = [[m34 objectAtIndex:i] floatValue];
        
        value.m41 = [[m41 objectAtIndex:i] floatValue];
        value.m42 = [[m42 objectAtIndex:i] floatValue];
        value.m43 = [[m43 objectAtIndex:i] floatValue];
        value.m44 = [[m44 objectAtIndex:i] floatValue];
        
        [values addObject:[NSValue valueWithCATransform3D:value]];
    }
    return values;
}

static NSArray * AnimationValuesForCAKeyframeAnimationWithFrames(id fromValue, id toValue, NSTimeInterval duration, CAMediaTimingFunction *timing) {
    id beginValue;
    id endValue;
    beginValue = fromValue;
    endValue = toValue;
    if ([beginValue isKindOfClass:[NSNumber class]] && [endValue isKindOfClass:[NSNumber class]]) {
        return NSNumberValuesBetweenNumbersAndDuration([beginValue floatValue], [endValue floatValue], duration, timing, NULL);
    } else if ([beginValue isKindOfClass:[UIColor class]] && [endValue isKindOfClass:[UIColor class]]) {
        const CGFloat *fromComponents = CGColorGetComponents(((UIColor*)beginValue).CGColor);
        const CGFloat *toComponents = CGColorGetComponents(((UIColor*)endValue).CGColor);
        return UIColorValuesWithComponents(NSNumberValuesBetweenNumbersAndDuration(fromComponents[0], toComponents[0], duration, timing, NULL), NSNumberValuesBetweenNumbersAndDuration(fromComponents[1], toComponents[1], duration, timing, NULL), NSNumberValuesBetweenNumbersAndDuration(fromComponents[2], toComponents[2], duration, timing, NULL), NSNumberValuesBetweenNumbersAndDuration(fromComponents[3], toComponents[3], duration, timing, NULL));
    } else if ([beginValue isKindOfClass:[NSValue class]] && [endValue isKindOfClass:[NSValue class]]) {
        NSString *valueType = [NSString stringWithCString:[beginValue objCType] encoding:NSStringEncodingConversionAllowLossy];
        if ([valueType rangeOfString:@"CGRect"].location == 1) {
            CGRect fromRect = [beginValue CGRectValue];
            CGRect toRect = [endValue CGRectValue];
            return CGRectValuesWithComponents(NSNumberValuesBetweenNumbersAndDuration(fromRect.origin.x, toRect.origin.x, duration, timing, NULL), NSNumberValuesBetweenNumbersAndDuration(fromRect.origin.y, toRect.origin.y, duration, timing, NULL), NSNumberValuesBetweenNumbersAndDuration(fromRect.size.width, toRect.size.width, duration, timing, NULL), NSNumberValuesBetweenNumbersAndDuration(fromRect.size.height, toRect.size.height, duration, timing, NULL));
            
        } else if ([valueType rangeOfString:@"CGPoint"].location == 1) {
            CGPoint fromPoint = [beginValue CGPointValue];
            CGPoint toPoint = [endValue CGPointValue];
            return CGPointValuesWithComponents(NSNumberValuesBetweenNumbersAndDuration(fromPoint.x, toPoint.x, duration, timing, NULL), NSNumberValuesBetweenNumbersAndDuration(fromPoint.y, toPoint.y, duration, timing, NULL));
            
        } else if ([valueType rangeOfString:@"CATransform3D"].location == 1) {
            CATransform3D fromTransform = [beginValue CATransform3DValue];
            CATransform3D toTransform = [endValue CATransform3DValue];
            return CATransform3DValuesWithComponents(NSNumberValuesBetweenNumbersAndDuration(fromTransform.m11, toTransform.m11, duration, timing, NULL), NSNumberValuesBetweenNumbersAndDuration(fromTransform.m12, toTransform.m12, duration, timing, NULL), NSNumberValuesBetweenNumbersAndDuration(fromTransform.m13, toTransform.m13, duration, timing, NULL), NSNumberValuesBetweenNumbersAndDuration(fromTransform.m14, toTransform.m14, duration, timing, NULL), NSNumberValuesBetweenNumbersAndDuration(fromTransform.m21, toTransform.m21, duration, timing, NULL), NSNumberValuesBetweenNumbersAndDuration(fromTransform.m22, toTransform.m22, duration, timing, NULL), NSNumberValuesBetweenNumbersAndDuration(fromTransform.m23, toTransform.m23, duration, timing, NULL), NSNumberValuesBetweenNumbersAndDuration(fromTransform.m24, toTransform.m24, duration, timing, NULL), NSNumberValuesBetweenNumbersAndDuration(fromTransform.m31, toTransform.m31, duration, timing, NULL), NSNumberValuesBetweenNumbersAndDuration(fromTransform.m32, toTransform.m32, duration, timing, NULL), NSNumberValuesBetweenNumbersAndDuration(fromTransform.m33, toTransform.m33, duration, timing, NULL), NSNumberValuesBetweenNumbersAndDuration(fromTransform.m34, toTransform.m34, duration, timing, NULL), NSNumberValuesBetweenNumbersAndDuration(fromTransform.m41, toTransform.m41, duration, timing, NULL), NSNumberValuesBetweenNumbersAndDuration(fromTransform.m42, toTransform.m42, duration, timing, NULL), NSNumberValuesBetweenNumbersAndDuration(fromTransform.m43, toTransform.m43, duration, timing, NULL), NSNumberValuesBetweenNumbersAndDuration(fromTransform.m44, toTransform.m44, duration, timing, NULL));
        } else if ([valueType rangeOfString:@"CGSize"].location == 1) {
            CGSize fromSize = [beginValue CGSizeValue];
            CGSize toSize = [endValue CGSizeValue];
            return CGSizeValuesWithComponents(NSNumberValuesBetweenNumbersAndDuration(fromSize.width, toSize.width, duration, timing, NULL), NSNumberValuesBetweenNumbersAndDuration(fromSize.height, toSize.height, duration, timing, NULL));
        }
    }
    return nil;
}

static id ToValueByValueWithValue(id value, id byValue, BOOL plus) {
    if (!value) @throw @"From value can not be nil.";
    if (!byValue) @throw @"By value can not be nil";
    if ([value isKindOfClass:[NSNumber class]] && [byValue isKindOfClass:[NSNumber class]]) {
        return @([value floatValue]+[byValue floatValue]*(plus?1:-1));
    } else if ([value isKindOfClass:[UIColor class]] && [byValue isKindOfClass:[UIColor class]]) {
        const CGFloat *components = CGColorGetComponents(((UIColor*)value).CGColor);
        const CGFloat *byComponents = CGColorGetComponents(((UIColor*)byValue).CGColor);
        return [[UIColor alloc] initWithRed:components[0]+byComponents[0]*(plus?1:-1) green:components[1]+byComponents[1]*(plus?1:-1) blue:components[2]+byComponents[2]*(plus?1:-1) alpha:components[3]+byComponents[3]*(plus?1:-1)];
    } else if ([value isKindOfClass:[NSValue class]] && [byValue isKindOfClass:[NSValue class]]) {
        NSString *valueType = [NSString stringWithCString:[value objCType] encoding:NSStringEncodingConversionAllowLossy];
        if ([valueType rangeOfString:@"CGRect"].location == 1) {
            CGRect rect = [value CGRectValue];
            CGRect byRect = [byValue CGRectValue];
            return [NSValue valueWithCGRect:CGRectMake(rect.origin.x+byRect.origin.x*(plus?1:-1), rect.origin.y+byRect.origin.y*(plus?1:-1), rect.size.width+byRect.size.width*(plus?1:-1), rect.size.height+byRect.size.height*(plus?1:-1))];
            
        } else if ([valueType rangeOfString:@"CGPoint"].location == 1) {
            CGPoint point = [value CGPointValue];
            CGPoint byPoint = [byValue CGPointValue];
            return [NSValue valueWithCGPoint:CGPointMake(point.x+byPoint.x*(plus?1:-1), point.y+byPoint.y*(plus?1:-1))];
            
        } else if ([valueType rangeOfString:@"CATransform3D"].location == 1) {
            CATransform3D transform = [value CATransform3DValue];
            CATransform3D byTransform = [byValue CATransform3DValue];
            
            transform.m11+=byTransform.m11*(plus?1:-1);
            transform.m12+=byTransform.m12*(plus?1:-1);
            transform.m13+=byTransform.m13*(plus?1:-1);
            transform.m14+=byTransform.m14*(plus?1:-1);
            transform.m21+=byTransform.m21*(plus?1:-1);
            transform.m22+=byTransform.m22*(plus?1:-1);
            transform.m23+=byTransform.m23*(plus?1:-1);
            transform.m24+=byTransform.m24*(plus?1:-1);
            transform.m31+=byTransform.m31*(plus?1:-1);
            transform.m32+=byTransform.m32*(plus?1:-1);
            transform.m33+=byTransform.m33*(plus?1:-1);
            transform.m34+=byTransform.m34*(plus?1:-1);
            transform.m41+=byTransform.m41*(plus?1:-1);
            transform.m42+=byTransform.m42*(plus?1:-1);
            transform.m43+=byTransform.m43*(plus?1:-1);
            transform.m44+=byTransform.m44*(plus?1:-1);
            
            return [NSValue valueWithCATransform3D:byTransform];
        } else if ([valueType rangeOfString:@"CGSize"].location == 1) {
            CGSize size = [value CGSizeValue];
            CGSize bySize = [byValue CGSizeValue];
            return [NSValue valueWithCGSize:CGSizeMake(size.width+bySize.width*(plus?1:-1), size.height+bySize.height*(plus?1:-1))];
        }
    }
    return value;
}

@implementation CAKeyframeAnimation (Convertable)
+ (instancetype)animationWithBasic:(CABasicAnimation *)basicAnimation {
    CAKeyframeAnimation *keyframe = [CAKeyframeAnimation animation];
    keyframe.beginTime = basicAnimation.beginTime;
    keyframe.duration = basicAnimation.duration;
    keyframe.speed = basicAnimation.speed;
    keyframe.timeOffset = basicAnimation.timeOffset;
    keyframe.repeatCount = basicAnimation.repeatCount;
    keyframe.repeatDuration= basicAnimation.repeatDuration;
    keyframe.autoreverses = basicAnimation.autoreverses;
    keyframe.removedOnCompletion = basicAnimation.removedOnCompletion;
    keyframe.fillMode = basicAnimation.fillMode;
    keyframe.keyPath = basicAnimation.keyPath;
    keyframe.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    if (basicAnimation.fromValue && basicAnimation.toValue) {
        keyframe.values = AnimationValuesForCAKeyframeAnimationWithFrames(basicAnimation.fromValue, basicAnimation.toValue, basicAnimation.duration, basicAnimation.timingFunction);
    } else if (basicAnimation.fromValue && basicAnimation.byValue) {
        keyframe.values = AnimationValuesForCAKeyframeAnimationWithFrames(basicAnimation.fromValue, ToValueByValueWithValue(basicAnimation.fromValue, basicAnimation.byValue, YES), basicAnimation.duration, basicAnimation.timingFunction);
    } else if (basicAnimation.byValue && basicAnimation.toValue) {
        keyframe.values = AnimationValuesForCAKeyframeAnimationWithFrames(ToValueByValueWithValue(basicAnimation.toValue, basicAnimation.byValue, NO), basicAnimation.toValue, basicAnimation.duration, basicAnimation.timingFunction);
    } /* else if (basicAnimation.fromValue) {
        keyframe.values = AnimationValuesForCAKeyframeAnimationWithFrames(basicAnimation.fromValue, basicAnimation.fromValue, basicAnimation.duration, basicAnimation.timingFunction);
    } else if (basicAnimation.toValue) {
        keyframe.values = AnimationValuesForCAKeyframeAnimationWithFrames(basicAnimation.toValue, basicAnimation.toValue, basicAnimation.duration, basicAnimation.timingFunction);
    } else if (basicAnimation.byValue) {
        keyframe.values = AnimationValuesForCAKeyframeAnimationWithFrames(basicAnimation.byValue, basicAnimation.byValue, basicAnimation.duration, basicAnimation.timingFunction);
    } */ else {
       @throw [NSException exceptionWithName:@"com.devedbox.animationchain_convertable" reason:@"Animation of CABasicAnimation to convert must contain at least two of the 'fromValue, byValue, toValue'." userInfo:nil];
    }
    return keyframe;
}
@end
