//
//  UIView+AnimationChain.m
//  AXAnimationChain
//
//  Created by devedbox on 2016/12/22.
//  Copyright © 2016年 devedbox. All rights reserved.
//

#import "UIView+AnimationChain.h"
#import "UIView+ChainAnimator.h"

@implementation UIView (AnimationChain)

- (UIView *(^)(CGRect))boundsTo {
    return ^UIView* (CGRect toBounds) {
        return self;
    };
}
@end
