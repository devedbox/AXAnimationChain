//
//  UIView+AnimationChian.m
//  AXAnimationChain
//
//  Created by devedbox on 2016/12/10.
//  Copyright © 2016年 devedbox. All rights reserved.
//

#import "UIView+ChainAnimator.h"
#import <objc/runtime.h>

@implementation UIView (ChainAnimator)
- (AXChainAnimator *)chainAnimator {
    AXChainAnimator *chain = objc_getAssociatedObject(self, _cmd);
    if (!chain) {
        chain = [[AXChainAnimator alloc] init];
        chain.animatedView = self;
        objc_setAssociatedObject(self, _cmd, chain, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return chain;
}
@end
