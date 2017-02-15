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
        self.chainAnimator.topAnimator.combineBasic.property(@"position").beginTime([self.afterContext doubleValue]).toValue([NSValue valueWithCGPoint:[self _positionFromOrigin:toOrigin]]);
        return self;
    };
}

- (UIView *(^)(CGFloat))originXTo {
    return ^UIView* (CGFloat toOriginX) {
        self.chainAnimator.topAnimator.combineBasic.property(@"position.x").beginTime([self.afterContext doubleValue]).toValue([NSValue valueWithCGPoint:[self _positionFromOrigin:CGPointMake(toOriginX, self.layer.position.y)]]);
        return self;
    };
}

- (UIView *(^)(CGFloat))originYTo {
    return ^UIView* (CGFloat toOriginY) {
        self.chainAnimator.topAnimator.combineBasic.property(@"position.y").beginTime([self.afterContext doubleValue]).toValue([NSValue valueWithCGPoint:[self _positionFromOrigin:CGPointMake(self.layer.position.x, toOriginY)]]);
        return self;
    };
}

- (UIView *(^)(CGPoint))centerTo {
    return ^UIView* (CGPoint toCenter) {
        self.chainAnimator.topAnimator.combineBasic.property(@"position").beginTime([self.afterContext doubleValue]).toValue([NSValue valueWithCGPoint:toCenter]);
        return self;
    };
}

- (UIView *(^)(CGFloat))centerXTo {
    return ^UIView* (CGFloat toCenterX) {
        self.chainAnimator.topAnimator.combineBasic.property(@"position").beginTime([self.afterContext doubleValue]).toValue([NSValue valueWithCGPoint:CGPointMake(toCenterX, self.layer.position.y)]);
        return self;
    };
}

- (UIView *(^)(CGFloat))centerYTo {
    return ^UIView* (CGFloat toCenterY) {
        self.chainAnimator.topAnimator.combineBasic.property(@"position.y").beginTime([self.afterContext doubleValue]).toValue([NSValue valueWithCGPoint:CGPointMake(self.layer.position.x, toCenterY)]);
        return self;
    };
}

- (UIView *(^)(CGRect))frameTo {
    return ^UIView* (CGRect toFrame) {
        self.originTo(toFrame.origin);
        self.sizeTo(toFrame.size);
        return self;
    };
}

- (UIView *(^)(CGRect))boundsTo {
    return ^UIView* (CGRect toBounds) {
        self.sizeTo(CGSizeMake(CGRectGetWidth(toBounds), CGRectGetHeight(toBounds)));
        return self;
    };
}

- (UIView *(^)(CGSize))sizeTo {
    return ^UIView* (CGSize toSize) {
        self.chainAnimator.topAnimator.combineBasic.property(@"bounds.size").beginTime([self.afterContext doubleValue]).toValue([NSValue valueWithCGSize:toSize]);
        return self;
    };
}

- (UIView *(^)(CGFloat))widthTo {
    return ^UIView* (CGFloat toWidth) {
        self.chainAnimator.topAnimator.combineBasic.property(@"bounds.size").beginTime([self.afterContext doubleValue]).toValue([NSValue valueWithCGSize:CGSizeMake(toWidth, CGRectGetHeight(self.layer.bounds))]);
        return self;
    };
}

- (UIView *(^)(CGFloat))heightTo {
    return ^UIView* (CGFloat toHeight) {
        self.chainAnimator.topAnimator.combineBasic.property(@"bounds.size").beginTime([self.afterContext doubleValue]).toValue([NSValue valueWithCGSize:CGSizeMake(CGRectGetWidth(self.layer.bounds), toHeight)]);
        return self;
    };
}

- (UIView *(^)(CGFloat))opacityTo {
    return ^UIView* (CGFloat toOpacity) {
        self.chainAnimator.topAnimator.combineBasic.property(@"opacity").beginTime([self.afterContext doubleValue]).toValue(@(toOpacity));
        return self;
    };
}

- (UIView *(^)(UIColor *))backgroundColorTo {
    return ^UIView* (UIColor *toBackgroundColor) {
        self.chainAnimator.topAnimator.combineBasic.property(@"backgroundColor").beginTime([self.afterContext doubleValue]).toValue((__bridge id)toBackgroundColor.CGColor);
        return self;
    };
}

- (UIView *(^)(UIColor *))borderColorTo {
    return ^UIView* (UIColor *toBorderColor) {
        self.chainAnimator.topAnimator.combineBasic.property(@"borderColor").beginTime([self.afterContext doubleValue]).toValue((__bridge id)toBorderColor.CGColor);
        return self;
    };
}

- (UIView *(^)(CGFloat))borderWidthTo {
    return ^UIView* (CGFloat toBorderWidth) {
        self.chainAnimator.topAnimator.combineBasic.property(@"borderWidth").beginTime([self.afterContext doubleValue]).toValue(@(toBorderWidth));
        return self;
    };
}

- (UIView *(^)(CGFloat))cornerRadiusTo {
    return ^UIView* (CGFloat toCornerRadius) {
        self.chainAnimator.topAnimator.combineBasic.property(@"cornerRadius").beginTime([self.afterContext doubleValue]).toValue(@(toCornerRadius));
        return self;
    };
}

- (UIView *(^)(CGFloat))scaleTo {
    return ^UIView* (CGFloat toScale) {
        self.chainAnimator.topAnimator.combineBasic.property(@"transform.scale").beginTime([self.afterContext doubleValue]).toValue(@(toScale));
        return self;
    };
}

- (UIView *(^)(CGFloat))scaleXTo {
    return ^UIView* (CGFloat toScaleX) {
        self.chainAnimator.topAnimator.combineBasic.property(@"transform.scale.x").beginTime([self.afterContext doubleValue]).toValue(@(toScaleX));
        return self;
    };
}

- (UIView *(^)(CGFloat))scaleYTo {
    return ^UIView* (CGFloat toScaleY) {
        self.chainAnimator.topAnimator.combineBasic.property(@"transform.scale.y").beginTime([self.afterContext doubleValue]).toValue(@(toScaleY));
        return self;
    };
}

- (UIView *(^)(CGFloat))scaleZTo {
    return ^UIView* (CGFloat toScaleZ) {
        self.chainAnimator.topAnimator.combineBasic.property(@"transform.scale.z").beginTime([self.afterContext doubleValue]).toValue(@(toScaleZ));
        return self;
    };
}
/*
- (UIView *(^)(CGPoint))anchorTo {
    return ^UIView* (CGPoint toAnchor) {
        CGPoint anchorPoint = toAnchor;
        if (CGPointEqualToPoint(anchorPoint, self.layer.anchorPoint)) {
            return self;
        }
        self.chainAnimator.topAnimator.combineBasic.property(@"anchorPoint").beginTime([self.afterContext doubleValue]).toValue([NSValue valueWithCGPoint:anchorPoint]);
        return self;
    };
} */

- (UIView *(^)(CGFloat))rotateTo {
    return ^UIView* (CGFloat toRotate) {
        self.chainAnimator.combineBasic.property(@"transform.rotation").beginTime([self.afterContext doubleValue]).toValue(@(toRotate));
        return self;
    };
}

- (UIView *(^)(CGFloat))rotateXTo {
    return ^UIView* (CGFloat toRotateX) {
        self.chainAnimator.combineBasic.property(@"transform.rotation.x").beginTime([self.afterContext doubleValue]).toValue(@(toRotateX));
        return self;
    };
}

- (UIView *(^)(CGFloat))rotateYTo {
    return ^UIView* (CGFloat toRotateY) {
        self.chainAnimator.combineBasic.property(@"transform.rotation.y").beginTime([self.afterContext doubleValue]).toValue(@(toRotateY));
        return self;
    };
}

- (UIView *(^)(CGFloat))rotateZTo {
    return ^UIView* (CGFloat toRotateZ) {
        self.chainAnimator.combineBasic.property(@"transform.rotation.z").beginTime([self.afterContext doubleValue]).toValue(@(toRotateZ));
        return self;
    };
}

- (UIView *(^)(CGPoint))translateTo {
    return ^UIView* (CGPoint toTranslate) {
        self.chainAnimator.combineBasic.property(@"transform.translation").beginTime([self.afterContext doubleValue]).toValue([NSValue valueWithCGPoint:toTranslate]);
        return self;
    };
}

- (UIView *(^)(CGFloat))translateXTo {
    return ^UIView* (CGFloat toTranslateX) {
        self.chainAnimator.combineBasic.property(@"transform.translation.x").beginTime([self.afterContext doubleValue]).toValue(@(toTranslateX));
        return self;
    };
}

- (UIView *(^)(CGFloat))translateYTo {
    return ^UIView* (CGFloat toTranslateY) {
        self.chainAnimator.combineBasic.property(@"transform.translation.y").beginTime([self.afterContext doubleValue]).toValue(@(toTranslateY));
        return self;
    };
}

- (UIView *(^)(CGFloat))translateZTo {
    return ^UIView* (CGFloat toTranslateZ) {
        self.chainAnimator.combineBasic.property(@"transform.translation.z").beginTime([self.afterContext doubleValue]).toValue(@(toTranslateZ));
        return self;
    };
}

- (UIView *(^)(UIImage *))imageTo {
    return ^UIView* (UIImage *toImage) {
        self.chainAnimator.topAnimator.combineBasic.property(@"contents").beginTime([self.afterContext doubleValue]).toValue((id)toImage.CGImage);
        return self;
    };
}
#pragma mark - By values.
- (UIView *(^)(CGPoint))originBy {
    return ^UIView* (CGPoint byOrigin) {
        self.chainAnimator.topAnimator.combineBasic.property(@"position").beginTime([self.afterContext doubleValue]).byValue([NSValue valueWithCGPoint:[self _positionFromOrigin:byOrigin]]);
        return self;
    };
}

- (UIView *(^)(CGFloat))originXBy {
    return ^UIView* (CGFloat byOriginX) {
        self.chainAnimator.topAnimator.combineBasic.property(@"position.x").beginTime([self.afterContext doubleValue]).byValue([NSValue valueWithCGPoint:[self _positionFromOrigin:CGPointMake(byOriginX, self.layer.position.y)]]);
        return self;
    };
}

- (UIView *(^)(CGFloat))originYBy {
    return ^UIView* (CGFloat byOriginY) {
        self.chainAnimator.topAnimator.combineBasic.property(@"position.y").beginTime([self.afterContext doubleValue]).byValue([NSValue valueWithCGPoint:[self _positionFromOrigin:CGPointMake(self.layer.position.x, byOriginY)]]);
        return self;
    };
}

- (UIView *(^)(CGPoint))centerBy {
    return ^UIView* (CGPoint byCenter) {
        self.chainAnimator.topAnimator.combineBasic.property(@"position").beginTime([self.afterContext doubleValue]).byValue([NSValue valueWithCGPoint:byCenter]);
        return self;
    };
}

- (UIView *(^)(CGFloat))centerXBy {
    return ^UIView* (CGFloat byCenterX) {
        self.chainAnimator.topAnimator.combineBasic.property(@"position").beginTime([self.afterContext doubleValue]).byValue([NSValue valueWithCGPoint:CGPointMake(byCenterX, 0)]);
        return self;
    };
}

- (UIView *(^)(CGFloat))centerYBy {
    return ^UIView* (CGFloat byCenterY) {
        self.chainAnimator.topAnimator.combineBasic.property(@"position").beginTime([self.afterContext doubleValue]).byValue([NSValue valueWithCGPoint:CGPointMake(0, byCenterY)]);
        return self;
    };
}

- (UIView *(^)(CGRect))frameBy {
    return ^UIView* (CGRect byFrame) {
        self.originBy(byFrame.origin);
        self.sizeBy(byFrame.size);
        return self;
    };
}

- (UIView *(^)(CGRect))boundsBy {
    return ^UIView* (CGRect byBounds) {
        self.sizeBy(CGSizeMake(CGRectGetWidth(byBounds), CGRectGetHeight(byBounds)));
        return self;
    };
}

- (UIView *(^)(CGSize))sizeBy {
    return ^UIView* (CGSize bySize) {
        self.chainAnimator.topAnimator.combineBasic.property(@"bounds.size").beginTime([self.afterContext doubleValue]).byValue([NSValue valueWithCGSize:bySize]);
        return self;
    };
}

- (UIView *(^)(CGFloat))widthBy {
    return ^UIView* (CGFloat byWidth) {
        self.chainAnimator.topAnimator.combineBasic.property(@"bounds.size").beginTime([self.afterContext doubleValue]).byValue([NSValue valueWithCGSize:CGSizeMake(byWidth, CGRectGetHeight(self.layer.bounds))]);
        return self;
    };
}

- (UIView *(^)(CGFloat))heightBy {
    return ^UIView* (CGFloat byHeight) {
        self.chainAnimator.topAnimator.combineBasic.property(@"bounds.size").beginTime([self.afterContext doubleValue]).byValue([NSValue valueWithCGSize:CGSizeMake(CGRectGetWidth(self.layer.bounds), byHeight)]);
        return self;
    };
}

- (UIView *(^)(CGFloat))opacityBy {
    return ^UIView* (CGFloat byOpacity) {
        self.chainAnimator.topAnimator.combineBasic.property(@"opacity").beginTime([self.afterContext doubleValue]).byValue(@(byOpacity));
        return self;
    };
}

- (UIView *(^)(UIColor *))backgroundColorBy {
    return ^UIView* (UIColor *byBackgroundColor) {
        self.chainAnimator.topAnimator.combineBasic.property(@"backgroundColor").beginTime([self.afterContext doubleValue]).byValue((__bridge id)byBackgroundColor.CGColor);
        return self;
    };
}

- (UIView *(^)(UIColor *))borderColorBy {
    return ^UIView* (UIColor *byBorderColor) {
        self.chainAnimator.topAnimator.combineBasic.property(@"borderColor").beginTime([self.afterContext doubleValue]).byValue((__bridge id)byBorderColor.CGColor);
        return self;
    };
}

- (UIView *(^)(CGFloat))borderWidthBy {
    return ^UIView* (CGFloat byBorderWidth) {
        self.chainAnimator.topAnimator.combineBasic.property(@"borderWidth").beginTime([self.afterContext doubleValue]).byValue(@(byBorderWidth));
        return self;
    };
}

- (UIView *(^)(CGFloat))cornerRadiusBy {
    return ^UIView* (CGFloat byCornerRadius) {
        self.chainAnimator.topAnimator.combineBasic.property(@"cornerRadius").beginTime([self.afterContext doubleValue]).byValue(@(byCornerRadius));
        return self;
    };
}

- (UIView *(^)(CGFloat))scaleBy {
    return ^UIView* (CGFloat byScale) {
        self.chainAnimator.topAnimator.combineBasic.property(@"transform.scale").beginTime([self.afterContext doubleValue]).byValue(@(byScale));
        return self;
    };
}

- (UIView *(^)(CGFloat))scaleXBy {
    return ^UIView* (CGFloat byScaleX) {
        self.chainAnimator.topAnimator.combineBasic.property(@"transform.scale.x").beginTime([self.afterContext doubleValue]).byValue(@(byScaleX));
        return self;
    };
}

- (UIView *(^)(CGFloat))scaleYBy {
    return ^UIView* (CGFloat byScaleY) {
        self.chainAnimator.topAnimator.combineBasic.property(@"transform.scale.y").beginTime([self.afterContext doubleValue]).byValue(@(byScaleY));
        return self;
    };
}

- (UIView *(^)(CGFloat))scaleZBy {
    return ^UIView* (CGFloat byScaleZ) {
        self.chainAnimator.topAnimator.combineBasic.property(@"transform.scale.z").beginTime([self.afterContext doubleValue]).byValue(@(byScaleZ));
        return self;
    };
}
/*
- (UIView *(^)(CGPoint))anchorBy {
    return ^UIView* (CGPoint byAnchor) {
        CGPoint anchorPoint = byAnchor;
        if (CGPointEqualToPoint(anchorPoint, self.layer.anchorPoint)) {
            return self;
        }
        self.chainAnimator.topAnimator.combineBasic.property(@"anchorPoint").beginTime([self.afterContext doubleValue]).byValue([NSValue valueWithCGPoint:anchorPoint]);
        return self;
    };
} */

- (UIView *(^)(CGFloat))rotateBy {
    return ^UIView* (CGFloat byRotate) {
        self.chainAnimator.combineBasic.property(@"transform.rotation").beginTime([self.afterContext doubleValue]).byValue(@(byRotate));
        return self;
    };
}

- (UIView *(^)(CGFloat))rotateXBy {
    return ^UIView* (CGFloat byRotateX) {
        self.chainAnimator.combineBasic.property(@"transform.rotation.x").beginTime([self.afterContext doubleValue]).byValue(@(byRotateX));
        return self;
    };
}

- (UIView *(^)(CGFloat))rotateYBy {
    return ^UIView* (CGFloat byRotateY) {
        self.chainAnimator.combineBasic.property(@"transform.rotation.y").beginTime([self.afterContext doubleValue]).byValue(@(byRotateY));
        return self;
    };
}

- (UIView *(^)(CGFloat))rotateZBy {
    return ^UIView* (CGFloat byRotateZ) {
        self.chainAnimator.combineBasic.property(@"transform.rotation.z").beginTime([self.afterContext doubleValue]).byValue(@(byRotateZ));
        return self;
    };
}

- (UIView *(^)(CGPoint))translateBy {
    return ^UIView* (CGPoint byTranslate) {
        self.chainAnimator.combineBasic.property(@"transform.translation").beginTime([self.afterContext doubleValue]).byValue([NSValue valueWithCGPoint:byTranslate]);
        return self;
    };
}

- (UIView *(^)(CGFloat))translateXBy {
    return ^UIView* (CGFloat byTranslateX) {
        self.chainAnimator.combineBasic.property(@"transform.translation.x").beginTime([self.afterContext doubleValue]).byValue(@(byTranslateX));
        return self;
    };
}

- (UIView *(^)(CGFloat))translateYBy {
    return ^UIView* (CGFloat byTranslateY) {
        self.chainAnimator.combineBasic.property(@"transform.translation.y").beginTime([self.afterContext doubleValue]).byValue(@(byTranslateY));
        return self;
    };
}

- (UIView *(^)(CGFloat))translateZBy {
    return ^UIView* (CGFloat byTranslateZ) {
        self.chainAnimator.combineBasic.property(@"transform.translation.z").beginTime([self.afterContext doubleValue]).byValue(@(byTranslateZ));
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
    AXChainAnimator *lastAnimator = self.chainAnimator.topAnimator.combinedAnimators.lastObject;
    [lastAnimator replaceCombinedAnimatorWithAnimator:[lastAnimator beginBasic]];
    return self;
}

- (instancetype)spring {
    AXChainAnimator *lastAnimator = self.chainAnimator.topAnimator.combinedAnimators.lastObject;
    [lastAnimator replaceCombinedAnimatorWithAnimator:[lastAnimator beginSpring]];
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
