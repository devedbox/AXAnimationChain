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
    keyframe.fillMode = basicAnimation.fillMode;
    keyframe.keyPath = basicAnimation.keyPath;
    return keyframe;
}
@end
static NSArray * NSNumberValuesBetweenNumbersAndDuration(CGFloat beginNumber, CGFloat endNumber, NSTimeInterval duration) {
    // 60 FPS per second.
    NSUInteger components = (NSUInteger)ceil(60 * duration) + 2;
    
    NSMutableArray *numbers = [NSMutableArray arrayWithCapacity:components];
    
    const double increment = 1.0 / (double)(components - 1);
    
    double progress = 0.0,
    v = 0.0,
    value = 0.0;
    
    NSUInteger i;
    for (i = 0; i < components; i++)
    {
        /*
         v = self.functionBlock(duration * progress * 1000, 0, 1, duration * 1000);
         */
        value = beginNumber + v * (beginNumber - endNumber);
        
        [numbers addObject:@(value)];
        
        progress += increment;
    }
    
    return numbers;
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

static NSArray * animationValuesForCAKeyframeAnimationWithFrames(id fromValue, id byValue, id toValue, NSTimeInterval duration) {
    id beginValue;
    id endValue;
    beginValue = fromValue;
    endValue = toValue;
    if ([beginValue isKindOfClass:[NSNumber class]] && [beginValue isKindOfClass:[NSNumber class]]) {
        return NSNumberValuesBetweenNumbersAndDuration([beginValue floatValue], [endValue floatValue], duration);
    } else if ([beginValue isKindOfClass:[UIColor class]] && [endValue isKindOfClass:[UIColor class]]) {
        const CGFloat *fromComponents = CGColorGetComponents(((UIColor*)beginValue).CGColor);
        const CGFloat *toComponents = CGColorGetComponents(((UIColor*)endValue).CGColor);
        return UIColorValuesWithComponents(NSNumberValuesBetweenNumbersAndDuration(fromComponents[0], toComponents[0], duration), NSNumberValuesBetweenNumbersAndDuration(fromComponents[1], toComponents[1], duration), NSNumberValuesBetweenNumbersAndDuration(fromComponents[2], toComponents[2], duration), NSNumberValuesBetweenNumbersAndDuration(fromComponents[3], toComponents[3], duration));
    } else if ([beginValue isKindOfClass:[NSValue class]] && [endValue isKindOfClass:[NSValue class]]) {
        NSString *valueType = [NSString stringWithCString:[beginValue objCType] encoding:NSStringEncodingConversionAllowLossy];
        if ([valueType rangeOfString:@"CGRect"].location == 1) {
            CGRect fromRect = [beginValue CGRectValue];
            CGRect toRect = [endValue CGRectValue];
            return CGRectValuesWithComponents(NSNumberValuesBetweenNumbersAndDuration(fromRect.origin.x, toRect.origin.x, duration), NSNumberValuesBetweenNumbersAndDuration(fromRect.origin.y, toRect.origin.y, duration), NSNumberValuesBetweenNumbersAndDuration(fromRect.size.width, toRect.size.width, duration), NSNumberValuesBetweenNumbersAndDuration(fromRect.size.height, toRect.size.height, duration));
            
        } else if ([valueType rangeOfString:@"CGPoint"].location == 1) {
            CGPoint fromPoint = [beginValue CGPointValue];
            CGPoint toPoint = [endValue CGPointValue];
            return CGPointValuesWithComponents(NSNumberValuesBetweenNumbersAndDuration(fromPoint.x, toPoint.x, duration), NSNumberValuesBetweenNumbersAndDuration(fromPoint.y, toPoint.y, duration));
            
        } else if ([valueType rangeOfString:@"CATransform3D"].location == 1) {
            CATransform3D fromTransform = [beginValue CATransform3DValue];
            CATransform3D toTransform = [endValue CATransform3DValue];
            return CATransform3DValuesWithComponents(NSNumberValuesBetweenNumbersAndDuration(fromTransform.m11, toTransform.m11, duration), NSNumberValuesBetweenNumbersAndDuration(fromTransform.m12, toTransform.m12, duration), NSNumberValuesBetweenNumbersAndDuration(fromTransform.m13, toTransform.m13, duration), NSNumberValuesBetweenNumbersAndDuration(fromTransform.m14, toTransform.m14, duration), NSNumberValuesBetweenNumbersAndDuration(fromTransform.m21, toTransform.m21, duration), NSNumberValuesBetweenNumbersAndDuration(fromTransform.m22, toTransform.m22, duration), NSNumberValuesBetweenNumbersAndDuration(fromTransform.m23, toTransform.m23, duration), NSNumberValuesBetweenNumbersAndDuration(fromTransform.m24, toTransform.m24, duration), NSNumberValuesBetweenNumbersAndDuration(fromTransform.m31, toTransform.m31, duration), NSNumberValuesBetweenNumbersAndDuration(fromTransform.m32, toTransform.m32, duration), NSNumberValuesBetweenNumbersAndDuration(fromTransform.m33, toTransform.m33, duration), NSNumberValuesBetweenNumbersAndDuration(fromTransform.m34, toTransform.m34, duration), NSNumberValuesBetweenNumbersAndDuration(fromTransform.m41, toTransform.m41, duration), NSNumberValuesBetweenNumbersAndDuration(fromTransform.m42, toTransform.m42, duration), NSNumberValuesBetweenNumbersAndDuration(fromTransform.m43, toTransform.m43, duration), NSNumberValuesBetweenNumbersAndDuration(fromTransform.m44, toTransform.m44, duration));
        } else if ([valueType rangeOfString:@"CGSize"].location == 1) {
            CGSize fromSize = [beginValue CGSizeValue];
            CGSize toSize = [beginValue CGSizeValue];
            return CGSizeValuesWithComponents(NSNumberValuesBetweenNumbersAndDuration(fromSize.width, toSize.width, duration), NSNumberValuesBetweenNumbersAndDuration(fromSize.height, toSize.height, duration));
        }
    }
    return nil;
}