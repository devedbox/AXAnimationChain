//
//  UIView+AnimationChain.m
//  AXAnimationChain
//
//  Created by devedbox on 2016/12/22.
//  Copyright © 2016年 devedbox. All rights reserved.
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

#import "UIView+AnimationChain.h"
#import "UIView+ChainAnimator.h"
#import "AXChainAnimator+Block.h"
#import <objc/runtime.h>

@interface UIView (AnimationChain_Private)
/// After time interval context.
@property(strong, nonatomic) NSNumber *afterContext;
/// Wait context.
@property(strong, nonatomic) NSObject *waitContext;
/// Animator context.
@property(strong, nonatomic) NSString *animatorContext;
@end

static NSString *const kAXAnimatorContextBasic = @"basic";
static NSString *const kAXAnimatorContextSpring = @"spring";
static NSString *const kAXAnimatorContextNone = @"normal";

@implementation UIView (AnimationChain)
#pragma mark - Getters.
- (NSNumber *)afterContext {
    return objc_getAssociatedObject(self, _cmd);
}

- (NSObject *)waitContext {
    return objc_getAssociatedObject(self, _cmd);
}

- (NSString *)animatorContext {
    return objc_getAssociatedObject(self, _cmd);
}
#pragma mark - Setters.
- (void)setAfterContext:(NSNumber *)afterContext {
    objc_setAssociatedObject(self, @selector(afterContext), afterContext, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setWaitContext:(NSObject *)waitContext {
    objc_setAssociatedObject(self, @selector(waitContext), waitContext, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setAnimatorContext:(NSString *)animatorContext {
    objc_setAssociatedObject(self, @selector(animatorContext), [animatorContext copy], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark - To values.
- (UIView *(^)(CGPoint))originTo {
    return ^UIView* (CGPoint toOrigin) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"position").beginTime([self.afterContext doubleValue]).toValue([NSValue valueWithCGPoint:[self _positionFromOrigin:toOrigin]]);;
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"position").beginTime([self.afterContext doubleValue]).toValue([NSValue valueWithCGPoint:[self _positionFromOrigin:toOrigin]]);;
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))originXTo {
    return ^UIView* (CGFloat toOriginX) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"position.x").beginTime([self.afterContext doubleValue]).toValue([NSValue valueWithCGPoint:[self _positionFromOrigin:CGPointMake(toOriginX, self.layer.position.y)]]);
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"position.x").beginTime([self.afterContext doubleValue]).toValue([NSValue valueWithCGPoint:[self _positionFromOrigin:CGPointMake(toOriginX, self.layer.position.y)]]);
        }
        return self;
    };
}

- (UIView *(^)(CGFloat))originYTo {
    return ^UIView* (CGFloat toOriginY) {
        [self setAnimatorContext:kAXAnimatorContextNone];if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"position.y").beginTime([self.afterContext doubleValue]).toValue([NSValue valueWithCGPoint:[self _positionFromOrigin:CGPointMake(self.layer.position.x, toOriginY)]]);
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"position.y").beginTime([self.afterContext doubleValue]).toValue([NSValue valueWithCGPoint:[self _positionFromOrigin:CGPointMake(self.layer.position.x, toOriginY)]]);
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGPoint))centerTo {
    return ^UIView* (CGPoint toCenter) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"position").beginTime([self.afterContext doubleValue]).toValue([NSValue valueWithCGPoint:toCenter]);
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"position").beginTime([self.afterContext doubleValue]).toValue([NSValue valueWithCGPoint:toCenter]);
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))centerXTo {
    return ^UIView* (CGFloat toCenterX) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"position").beginTime([self.afterContext doubleValue]).toValue([NSValue valueWithCGPoint:CGPointMake(toCenterX, self.layer.position.y)]);
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"position").beginTime([self.afterContext doubleValue]).toValue([NSValue valueWithCGPoint:CGPointMake(toCenterX, self.layer.position.y)]);
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))centerYTo {
    return ^UIView* (CGFloat toCenterY) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"position.y").beginTime([self.afterContext doubleValue]).toValue([NSValue valueWithCGPoint:CGPointMake(self.layer.position.x, toCenterY)]);
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"position.y").beginTime([self.afterContext doubleValue]).toValue([NSValue valueWithCGPoint:CGPointMake(self.layer.position.x, toCenterY)]);
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGRect))frameTo {
    return ^UIView* (CGRect toFrame) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.spring.originTo(toFrame.origin).chainAnimator.topAnimator.combinedAnimators.lastObject.beginTime([self.afterContext doubleValue]);
            [self spring];
            self.spring.sizeTo(toFrame.size).chainAnimator.topAnimator.combinedAnimators.lastObject.beginTime([self.afterContext doubleValue]);
        } else {
            self.originTo(toFrame.origin).chainAnimator.topAnimator.combinedAnimators.lastObject.beginTime([self.afterContext doubleValue]);
            self.sizeTo(toFrame.size).chainAnimator.topAnimator.combinedAnimators.lastObject.beginTime([self.afterContext doubleValue]);
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGRect))boundsTo {
    return ^UIView* (CGRect toBounds) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.spring.sizeTo(CGSizeMake(CGRectGetWidth(toBounds), CGRectGetHeight(toBounds))).chainAnimator.topAnimator.combinedAnimators.lastObject.beginTime([self.afterContext doubleValue]);
        } else {
            self.sizeTo(CGSizeMake(CGRectGetWidth(toBounds), CGRectGetHeight(toBounds))).chainAnimator.topAnimator.combinedAnimators.lastObject.beginTime([self.afterContext doubleValue]);
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGSize))sizeTo {
    return ^UIView* (CGSize toSize) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"bounds.size").beginTime([self.afterContext doubleValue]).toValue([NSValue valueWithCGSize:toSize]);
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"bounds.size").beginTime([self.afterContext doubleValue]).toValue([NSValue valueWithCGSize:toSize]);
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))widthTo {
    return ^UIView* (CGFloat toWidth) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"bounds.size").beginTime([self.afterContext doubleValue]).toValue([NSValue valueWithCGSize:CGSizeMake(toWidth, CGRectGetHeight(self.layer.bounds))]);
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"bounds.size").beginTime([self.afterContext doubleValue]).toValue([NSValue valueWithCGSize:CGSizeMake(toWidth, CGRectGetHeight(self.layer.bounds))]);
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))heightTo {
    return ^UIView* (CGFloat toHeight) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"bounds.size").beginTime([self.afterContext doubleValue]).toValue([NSValue valueWithCGSize:CGSizeMake(CGRectGetWidth(self.layer.bounds), toHeight)]);
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"bounds.size").beginTime([self.afterContext doubleValue]).toValue([NSValue valueWithCGSize:CGSizeMake(CGRectGetWidth(self.layer.bounds), toHeight)]);
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))opacityTo {
    return ^UIView* (CGFloat toOpacity) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"opacity").beginTime([self.afterContext doubleValue]).toValue(@(toOpacity));
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"opacity").beginTime([self.afterContext doubleValue]).toValue(@(toOpacity));
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(UIColor *))backgroundColorTo {
    return ^UIView* (UIColor *toBackgroundColor) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"backgroundColor").beginTime([self.afterContext doubleValue]).toValue((__bridge id)toBackgroundColor.CGColor);
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"backgroundColor").beginTime([self.afterContext doubleValue]).toValue((__bridge id)toBackgroundColor.CGColor);
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(UIColor *))borderColorTo {
    return ^UIView* (UIColor *toBorderColor) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"borderColor").beginTime([self.afterContext doubleValue]).toValue((__bridge id)toBorderColor.CGColor);
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"borderColor").beginTime([self.afterContext doubleValue]).toValue((__bridge id)toBorderColor.CGColor);
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))borderWidthTo {
    return ^UIView* (CGFloat toBorderWidth) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"borderWidth").beginTime([self.afterContext doubleValue]).toValue(@(toBorderWidth));
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"borderWidth").beginTime([self.afterContext doubleValue]).toValue(@(toBorderWidth));
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))cornerRadiusTo {
    return ^UIView* (CGFloat toCornerRadius) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"cornerRadius").beginTime([self.afterContext doubleValue]).toValue(@(toCornerRadius));
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"cornerRadius").beginTime([self.afterContext doubleValue]).toValue(@(toCornerRadius));
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))scaleTo {
    return ^UIView* (CGFloat toScale) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"transform.scale").beginTime([self.afterContext doubleValue]).toValue(@(toScale));
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"transform.scale").beginTime([self.afterContext doubleValue]).toValue(@(toScale));
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))scaleXTo {
    return ^UIView* (CGFloat toScaleX) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"transform.scale.x").beginTime([self.afterContext doubleValue]).toValue(@(toScaleX));
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"transform.scale.x").beginTime([self.afterContext doubleValue]).toValue(@(toScaleX));
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))scaleYTo {
    return ^UIView* (CGFloat toScaleY) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"transform.scale.y").beginTime([self.afterContext doubleValue]).toValue(@(toScaleY));
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"transform.scale.y").beginTime([self.afterContext doubleValue]).toValue(@(toScaleY));
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))scaleZTo {
    return ^UIView* (CGFloat toScaleZ) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"transform.scale.z").beginTime([self.afterContext doubleValue]).toValue(@(toScaleZ));
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"transform.scale.z").beginTime([self.afterContext doubleValue]).toValue(@(toScaleZ));
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGPoint))anchorTo {
    return ^UIView* (CGPoint toAnchor) {
        CGPoint anchorPoint = toAnchor;
        if (CGPointEqualToPoint(anchorPoint, self.layer.anchorPoint)) {
            return self;
        }
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"anchorPoint").beginTime([self.afterContext doubleValue]).toValue([NSValue valueWithCGPoint:anchorPoint]);
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"anchorPoint").beginTime([self.afterContext doubleValue]).toValue([NSValue valueWithCGPoint:anchorPoint]);
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))rotateTo {
    return ^UIView* (CGFloat toRotate) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.combineSpring.property(@"transform.rotation").beginTime([self.afterContext doubleValue]).toValue(@(toRotate));
        } else {
            self.chainAnimator.combineBasic.property(@"transform.rotation").beginTime([self.afterContext doubleValue]).toValue(@(toRotate));
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))rotateXTo {
    return ^UIView* (CGFloat toRotateX) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.combineSpring.property(@"transform.rotation.x").beginTime([self.afterContext doubleValue]).toValue(@(toRotateX));
        } else {
            self.chainAnimator.combineBasic.property(@"transform.rotation.x").beginTime([self.afterContext doubleValue]).toValue(@(toRotateX));
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))rotateYTo {
    return ^UIView* (CGFloat toRotateY) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.combineSpring.property(@"transform.rotation.y").beginTime([self.afterContext doubleValue]).toValue(@(toRotateY));
        } else {
            self.chainAnimator.combineBasic.property(@"transform.rotation.y").beginTime([self.afterContext doubleValue]).toValue(@(toRotateY));
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))rotateZTo {
    return ^UIView* (CGFloat toRotateZ) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.combineSpring.property(@"transform.rotation.z").beginTime([self.afterContext doubleValue]).toValue(@(toRotateZ));
        } else {
            self.chainAnimator.combineBasic.property(@"transform.rotation.z").beginTime([self.afterContext doubleValue]).toValue(@(toRotateZ));
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGPoint))translateTo {
    return ^UIView* (CGPoint toTranslate) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.combineSpring.property(@"transform.translation").beginTime([self.afterContext doubleValue]).toValue([NSValue valueWithCGPoint:toTranslate]);
        } else {
            self.chainAnimator.combineBasic.property(@"transform.translation").beginTime([self.afterContext doubleValue]).toValue([NSValue valueWithCGPoint:toTranslate]);
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))translateXTo {
    return ^UIView* (CGFloat toTranslateX) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.combineSpring.property(@"transform.translation.x").beginTime([self.afterContext doubleValue]).toValue(@(toTranslateX));
        } else {
            self.chainAnimator.combineBasic.property(@"transform.translation.x").beginTime([self.afterContext doubleValue]).toValue(@(toTranslateX));
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))translateYTo {
    return ^UIView* (CGFloat toTranslateY) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.combineSpring.property(@"transform.translation.y").beginTime([self.afterContext doubleValue]).toValue(@(toTranslateY));
        } else {
            self.chainAnimator.combineBasic.property(@"transform.translation.y").beginTime([self.afterContext doubleValue]).toValue(@(toTranslateY));
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))translateZTo {
    return ^UIView* (CGFloat toTranslateZ) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.combineSpring.property(@"transform.translation.z").beginTime([self.afterContext doubleValue]).toValue(@(toTranslateZ));
        } else {
            self.chainAnimator.combineBasic.property(@"transform.translation.z").beginTime([self.afterContext doubleValue]).toValue(@(toTranslateZ));
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(UIImage *))imageTo {
    return ^UIView* (UIImage *toImage) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"contents").beginTime([self.afterContext doubleValue]).toValue((id)toImage.CGImage);
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"contents").beginTime([self.afterContext doubleValue]).toValue((id)toImage.CGImage);
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}
#pragma mark - By values.
- (UIView *(^)(CGPoint))originBy {
    return ^UIView* (CGPoint byOrigin) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"position").beginTime([self.afterContext doubleValue]).byValue([NSValue valueWithCGPoint:[self _positionFromOrigin:byOrigin]]);
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"position").beginTime([self.afterContext doubleValue]).byValue([NSValue valueWithCGPoint:[self _positionFromOrigin:byOrigin]]);
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))originXBy {
    return ^UIView* (CGFloat byOriginX) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"position.x").beginTime([self.afterContext doubleValue]).byValue([NSValue valueWithCGPoint:[self _positionFromOrigin:CGPointMake(byOriginX, self.layer.position.y)]]);
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"position.x").beginTime([self.afterContext doubleValue]).byValue([NSValue valueWithCGPoint:[self _positionFromOrigin:CGPointMake(byOriginX, self.layer.position.y)]]);
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))originYBy {
    return ^UIView* (CGFloat byOriginY) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"position.y").beginTime([self.afterContext doubleValue]).byValue([NSValue valueWithCGPoint:[self _positionFromOrigin:CGPointMake(self.layer.position.x, byOriginY)]]);
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"position.y").beginTime([self.afterContext doubleValue]).byValue([NSValue valueWithCGPoint:[self _positionFromOrigin:CGPointMake(self.layer.position.x, byOriginY)]]);
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGPoint))centerBy {
    return ^UIView* (CGPoint byCenter) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"position").beginTime([self.afterContext doubleValue]).byValue([NSValue valueWithCGPoint:byCenter]);
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"position").beginTime([self.afterContext doubleValue]).byValue([NSValue valueWithCGPoint:byCenter]);
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))centerXBy {
    return ^UIView* (CGFloat byCenterX) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"position").beginTime([self.afterContext doubleValue]).byValue([NSValue valueWithCGPoint:CGPointMake(byCenterX, 0)]);
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"position").beginTime([self.afterContext doubleValue]).byValue([NSValue valueWithCGPoint:CGPointMake(byCenterX, 0)]);
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))centerYBy {
    return ^UIView* (CGFloat byCenterY) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"position").beginTime([self.afterContext doubleValue]).byValue([NSValue valueWithCGPoint:CGPointMake(0, byCenterY)]);
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"position").beginTime([self.afterContext doubleValue]).byValue([NSValue valueWithCGPoint:CGPointMake(0, byCenterY)]);
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGRect))frameBy {
    return ^UIView* (CGRect byFrame) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.spring.originBy(byFrame.origin).chainAnimator.topAnimator.combinedAnimators.lastObject.beginTime([self.afterContext doubleValue]);
            self.spring.sizeBy(byFrame.size).chainAnimator.topAnimator.combinedAnimators.lastObject.beginTime([self.afterContext doubleValue]);
        } else {
            self.originBy(byFrame.origin).chainAnimator.topAnimator.combinedAnimators.lastObject.beginTime([self.afterContext doubleValue]);
            self.sizeBy(byFrame.size).chainAnimator.topAnimator.combinedAnimators.lastObject.beginTime([self.afterContext doubleValue]);
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGRect))boundsBy {
    return ^UIView* (CGRect byBounds) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.spring.sizeBy(CGSizeMake(CGRectGetWidth(byBounds), CGRectGetHeight(byBounds))).chainAnimator.topAnimator.combinedAnimators.lastObject.beginTime([self.afterContext doubleValue]);
        } else {
            self.sizeBy(CGSizeMake(CGRectGetWidth(byBounds), CGRectGetHeight(byBounds))).chainAnimator.topAnimator.combinedAnimators.lastObject.beginTime([self.afterContext doubleValue]);
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGSize))sizeBy {
    return ^UIView* (CGSize bySize) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"bounds.size").beginTime([self.afterContext doubleValue]).byValue([NSValue valueWithCGSize:bySize]);
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"bounds.size").beginTime([self.afterContext doubleValue]).byValue([NSValue valueWithCGSize:bySize]);
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))widthBy {
    return ^UIView* (CGFloat byWidth) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"bounds.size").beginTime([self.afterContext doubleValue]).byValue([NSValue valueWithCGSize:CGSizeMake(byWidth, CGRectGetHeight(self.layer.bounds))]);
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"bounds.size").beginTime([self.afterContext doubleValue]).byValue([NSValue valueWithCGSize:CGSizeMake(byWidth, CGRectGetHeight(self.layer.bounds))]);
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))heightBy {
    return ^UIView* (CGFloat byHeight) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"bounds.size").beginTime([self.afterContext doubleValue]).byValue([NSValue valueWithCGSize:CGSizeMake(CGRectGetWidth(self.layer.bounds), byHeight)]);
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"bounds.size").beginTime([self.afterContext doubleValue]).byValue([NSValue valueWithCGSize:CGSizeMake(CGRectGetWidth(self.layer.bounds), byHeight)]);
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))opacityBy {
    return ^UIView* (CGFloat byOpacity) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"opacity").beginTime([self.afterContext doubleValue]).byValue(@(byOpacity));
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"opacity").beginTime([self.afterContext doubleValue]).byValue(@(byOpacity));
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(UIColor *))backgroundColorBy {
    return ^UIView* (UIColor *byBackgroundColor) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"backgroundColor").beginTime([self.afterContext doubleValue]).byValue((__bridge id)byBackgroundColor.CGColor);
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"backgroundColor").beginTime([self.afterContext doubleValue]).byValue((__bridge id)byBackgroundColor.CGColor);
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(UIColor *))borderColorBy {
    return ^UIView* (UIColor *byBorderColor) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"borderColor").beginTime([self.afterContext doubleValue]).byValue((__bridge id)byBorderColor.CGColor);
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"borderColor").beginTime([self.afterContext doubleValue]).byValue((__bridge id)byBorderColor.CGColor);
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))borderWidthBy {
    return ^UIView* (CGFloat byBorderWidth) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"borderWidth").beginTime([self.afterContext doubleValue]).byValue(@(byBorderWidth));
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"borderWidth").beginTime([self.afterContext doubleValue]).byValue(@(byBorderWidth));
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))cornerRadiusBy {
    return ^UIView* (CGFloat byCornerRadius) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"cornerRadius").beginTime([self.afterContext doubleValue]).byValue(@(byCornerRadius));
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"cornerRadius").beginTime([self.afterContext doubleValue]).byValue(@(byCornerRadius));
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))scaleBy {
    return ^UIView* (CGFloat byScale) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"transform.scale").beginTime([self.afterContext doubleValue]).byValue(@(byScale));
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"transform.scale").beginTime([self.afterContext doubleValue]).byValue(@(byScale));
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))scaleXBy {
    return ^UIView* (CGFloat byScaleX) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"transform.scale.x").beginTime([self.afterContext doubleValue]).byValue(@(byScaleX));
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"transform.scale.x").beginTime([self.afterContext doubleValue]).byValue(@(byScaleX));
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))scaleYBy {
    return ^UIView* (CGFloat byScaleY) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"transform.scale.y").beginTime([self.afterContext doubleValue]).byValue(@(byScaleY));
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"transform.scale.y").beginTime([self.afterContext doubleValue]).byValue(@(byScaleY));
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))scaleZBy {
    return ^UIView* (CGFloat byScaleZ) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"transform.scale.z").beginTime([self.afterContext doubleValue]).byValue(@(byScaleZ));
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"transform.scale.z").beginTime([self.afterContext doubleValue]).byValue(@(byScaleZ));
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGPoint))anchorBy {
    return ^UIView* (CGPoint byAnchor) {
        CGPoint anchorPoint = byAnchor;
        if (CGPointEqualToPoint(anchorPoint, self.layer.anchorPoint)) {
            return self;
        }
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.topAnimator.combineSpring.property(@"anchorPoint").beginTime([self.afterContext doubleValue]).byValue([NSValue valueWithCGPoint:anchorPoint]);
        } else {
            self.chainAnimator.topAnimator.combineBasic.property(@"anchorPoint").beginTime([self.afterContext doubleValue]).byValue([NSValue valueWithCGPoint:anchorPoint]);
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))rotateBy {
    return ^UIView* (CGFloat byRotate) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.combineSpring.property(@"transform.rotation").beginTime([self.afterContext doubleValue]).byValue(@(byRotate));
        } else {
            self.chainAnimator.combineBasic.property(@"transform.rotation").beginTime([self.afterContext doubleValue]).byValue(@(byRotate));
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))rotateXBy {
    return ^UIView* (CGFloat byRotateX) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.combineSpring.property(@"transform.rotation.x").beginTime([self.afterContext doubleValue]).byValue(@(byRotateX));
        } else {
            self.chainAnimator.combineBasic.property(@"transform.rotation.x").beginTime([self.afterContext doubleValue]).byValue(@(byRotateX));
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))rotateYBy {
    return ^UIView* (CGFloat byRotateY) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.combineSpring.property(@"transform.rotation.y").beginTime([self.afterContext doubleValue]).byValue(@(byRotateY));
        } else {
            self.chainAnimator.combineBasic.property(@"transform.rotation.y").beginTime([self.afterContext doubleValue]).byValue(@(byRotateY));
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))rotateZBy {
    return ^UIView* (CGFloat byRotateZ) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.combineSpring.property(@"transform.rotation.z").beginTime([self.afterContext doubleValue]).byValue(@(byRotateZ));
        } else {
            self.chainAnimator.combineBasic.property(@"transform.rotation.z").beginTime([self.afterContext doubleValue]).byValue(@(byRotateZ));
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGPoint))translateBy {
    return ^UIView* (CGPoint byTranslate) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.combineSpring.property(@"transform.translation").beginTime([self.afterContext doubleValue]).byValue([NSValue valueWithCGPoint:byTranslate]);
        } else {
            self.chainAnimator.combineBasic.property(@"transform.translation").beginTime([self.afterContext doubleValue]).byValue([NSValue valueWithCGPoint:byTranslate]);
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))translateXBy {
    return ^UIView* (CGFloat byTranslateX) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.combineSpring.property(@"transform.translation.x").beginTime([self.afterContext doubleValue]).byValue(@(byTranslateX));
        } else {
            self.chainAnimator.combineBasic.property(@"transform.translation.x").beginTime([self.afterContext doubleValue]).byValue(@(byTranslateX));
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))translateYBy {
    return ^UIView* (CGFloat byTranslateY) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.combineSpring.property(@"transform.translation.y").beginTime([self.afterContext doubleValue]).byValue(@(byTranslateY));
        } else {
            self.chainAnimator.combineBasic.property(@"transform.translation.y").beginTime([self.afterContext doubleValue]).byValue(@(byTranslateY));
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}

- (UIView *(^)(CGFloat))translateZBy {
    return ^UIView* (CGFloat byTranslateZ) {
        if ([self.animatorContext isEqualToString:kAXAnimatorContextSpring]) {
            self.chainAnimator.combineSpring.property(@"transform.translation.z").beginTime([self.afterContext doubleValue]).byValue(@(byTranslateZ));
        } else {
            self.chainAnimator.combineBasic.property(@"transform.translation.z").beginTime([self.afterContext doubleValue]).byValue(@(byTranslateZ));
        }
        [self setAnimatorContext:kAXAnimatorContextNone];
        return self;
    };
}
- (dispatch_block_t)animate {
    [self _resetContexts];
    return self.chainAnimator.topAnimator.animate;
}

#pragma mark - Timing control.
- (UIView *(^)(NSTimeInterval))duration {
    return ^UIView* (NSTimeInterval duration) {
        self.chainAnimator.topAnimator.combinedAnimators.lastObject.duration(duration);
        return self;
    };
}

- (UIView *(^)(NSTimeInterval))after {
    return ^UIView* (NSTimeInterval after) {
        NSTimeInterval duration = [self.afterContext doubleValue];
        [self setAfterContext:@(MAX(after+duration, 0))];
        return self;
    };
}

#pragma mark - Effects.
- (instancetype)linear {
    [self.chainAnimator.topAnimator.combinedAnimators.lastObject linear];
    return self;
}

- (instancetype)easeIn {
    [self.chainAnimator.topAnimator.combinedAnimators.lastObject easeIn];
    return self;
}

- (instancetype)easeOut {
    [self.chainAnimator.topAnimator.combinedAnimators.lastObject easeOut];
    return self;
}

- (instancetype)easeInOut {
    [self.chainAnimator.topAnimator.combinedAnimators.lastObject easeInOut];
    return self;
}

#pragma mark - Animation.
- (instancetype)basic {
    [self setAnimatorContext:kAXAnimatorContextBasic];
    return self;
}

- (instancetype)spring {
    [self setAnimatorContext:kAXAnimatorContextSpring];
    return self;
}

#pragma mark - Target-Action.
- (UIView *(^)(NSObject *))target {
    return ^UIView* (NSObject *target) {
        self.chainAnimator.topAnimator.combinedAnimators.lastObject.target(target);
        return self;
    };
}

- (UIView *(^)(SEL))complete {
    return ^UIView* (SEL completion) {
        self.chainAnimator.topAnimator.combinedAnimators.lastObject.complete(completion);
        return self;
    };
}

- (UIView *(^)(dispatch_block_t))completeBlock {
    return ^UIView* (dispatch_block_t completion) {
        self.chainAnimator.topAnimator.combinedAnimators.lastObject.completeWithBlock(completion);
        return self;
    };
}
#pragma mark - Private.
- (CGPoint)_positionFromOrigin:(CGPoint)origin {
    CGPoint anchor = self.layer.anchorPoint;
    CGSize size = self.bounds.size;
    CGPoint newPosition;
    newPosition.x = origin.x + anchor.x*size.width;
    newPosition.y = origin.y + anchor.y*size.height;
    return newPosition;
}

- (void)_resetContexts {
    // Reset after timing context.
    [self setAfterContext:nil];
}
@end
