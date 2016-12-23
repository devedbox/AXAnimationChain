//
//  UIView+AnimationChain.m
//  AXAnimationChain
//
//  Created by devedbox on 2016/12/22.
//  Copyright © 2016年 devedbox. All rights reserved.
//

#import "UIView+AnimationChain.h"
#import "UIView+ChainAnimator.h"

@interface UIView (AnimationChain_Private)
@end

@implementation UIView (AnimationChain)
- (UIView *(^)(CGPoint))originTo {
    return ^UIView* (CGPoint toOrigin) {
        self.chainAnimator.combineBasic.property(@"position").toValue([NSValue valueWithCGPoint:[self _positionFromOrigin:toOrigin]]);
        return self;
    };
}

- (UIView *(^)(CGFloat))originXTo {
    return ^UIView* (CGFloat toOriginX) {
        self.chainAnimator.combineBasic.property(@"position.x").toValue([NSValue valueWithCGPoint:[self _positionFromOrigin:CGPointMake(toOriginX, self.layer.position.y)]]);
        return self;
    };
}

- (UIView *(^)(CGFloat))originYTo {
    return ^UIView* (CGFloat toOriginY) {
        self.chainAnimator.combineBasic.property(@"position.y").toValue([NSValue valueWithCGPoint:[self _positionFromOrigin:CGPointMake(self.layer.position.x, toOriginY)]]);
        return self;
    };
}

- (UIView *(^)(CGPoint))centerTo {
    return ^UIView* (CGPoint toCenter) {
        self.chainAnimator.combineBasic.property(@"position").toValue([NSValue valueWithCGPoint:toCenter]);
        return self;
    };
}

- (UIView *(^)(CGRect))frameTo {
    return ^UIView* (CGRect toFrame) {
        return self.originTo(toFrame.origin).sizeTo(toFrame.size);
    };
}

- (UIView *(^)(CGRect))boundsTo {
    return ^UIView* (CGRect toBounds) {
        return self.sizeTo(CGSizeMake(CGRectGetWidth(toBounds), CGRectGetHeight(toBounds)));
    };
}

- (UIView *(^)(CGSize))sizeTo {
    return ^UIView* (CGSize toSize) {
        self.chainAnimator.combineBasic.property(@"bounds.size").toValue([NSValue valueWithCGSize:toSize]);
        return self;
    };
}

- (UIView *(^)(CGFloat))widthTo {
    return ^UIView* (CGFloat toWidth) {
        self.chainAnimator.combineBasic.property(@"bounds.size").toValue([NSValue valueWithCGSize:CGSizeMake(toWidth, CGRectGetHeight(self.layer.bounds))]);
        return self;
    };
}

- (UIView *(^)(CGFloat))heightTo {
    return ^UIView* (CGFloat toHeight) {
        self.chainAnimator.combineBasic.property(@"bounds.size").toValue([NSValue valueWithCGSize:CGSizeMake(CGRectGetWidth(self.layer.bounds), toHeight)]);
        return self;
    };
}

- (UIView *(^)(CGFloat))opacityTo {
    return ^UIView* (CGFloat toOpacity) {
        self.chainAnimator.combineBasic.property(@"opacity").toValue(@(toOpacity));
        return self;
    };
}

- (UIView *(^)(UIColor *))backgroundColorTo {
    return ^UIView* (UIColor *toBackgroundColor) {
        self.chainAnimator.combineBasic.property(@"backgroundColor").toValue(toBackgroundColor);
        return self;
    };
}

- (UIView *(^)(UIColor *))borderColorTo {
    return ^UIView* (UIColor *toBorderColor) {
        self.chainAnimator.combineBasic.property(@"borderColor").toValue(toBorderColor);
        return self;
    };
}

- (UIView *(^)(CGFloat))borderWidthTo {
    return ^UIView* (CGFloat toBorderWidth) {
        self.chainAnimator.combineBasic.property(@"borderWidth").toValue(@(toBorderWidth));
        return self;
    };
}

- (UIView *(^)(CGFloat))cornerRadiusTo {
    return ^UIView* (CGFloat toCornerRadius) {
        self.chainAnimator.combineBasic.property(@"cornerRadius").toValue(@(toCornerRadius));
        return self;
    };
}

- (UIView *(^)(CGFloat))scaleTo {
    return ^UIView* (CGFloat toScale) {
        self.chainAnimator.combineBasic.property(@"transform.scale").toValue(@(toScale));
        return self;
    };
}

- (UIView *(^)(CGFloat))scaleXTo {
    return ^UIView* (CGFloat toScaleX) {
        self.chainAnimator.combineBasic.property(@"transform.scale.x").toValue(@(toScaleX));
        return self;
    };
}

- (UIView *(^)(CGFloat))scaleYTo {
    return ^UIView* (CGFloat toScaleY) {
        self.chainAnimator.combineBasic.property(@"transform.scale.y").toValue(@(toScaleY));
        return self;
    };
}


- (dispatch_block_t)animate {
    return self.chainAnimator.animate;
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
@end
