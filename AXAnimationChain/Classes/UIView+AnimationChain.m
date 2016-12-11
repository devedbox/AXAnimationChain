//
//  UIView+AnimationChian.m
//  AXAnimationChain
//
//  Created by devedbox on 2016/12/10.
//  Copyright © 2016年 devedbox. All rights reserved.
//

#import "UIView+AnimationChain.h"
#import <objc/runtime.h>

@implementation UIView (AnimationChain)
- (AXAnimationChainAnimator *)animationChain {
    AXAnimationChainAnimator *chain = objc_getAssociatedObject(self, _cmd);
    if (!chain) {
        chain = [[AXAnimationChainAnimator alloc] init];
        chain.animatedView = self;
        objc_setAssociatedObject(self, _cmd, chain, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return chain;
}
@end
