//
//  UIView+AnimationChian.m
//  AXAnimationChain
//
//  Created by devedbox on 2016/12/10.
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

#import "UIView+ChainAnimator.h"
#import <objc/runtime.h>

static char *kAXManagedChainAnimators = "__managed";

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

- (NSArray<AXChainAnimator *> *)managedChainAnimators {
    return objc_getAssociatedObject(self, kAXManagedChainAnimators) ?: @[];
}

- (void)addChainAnimator:(AXChainAnimator *)animator {
    animator.animatedView = self;
    
    NSMutableArray *managed = [objc_getAssociatedObject(self, kAXManagedChainAnimators) mutableCopy] ?: [NSMutableArray array];
    [managed addObject:animator];
    
    objc_setAssociatedObject(self, kAXManagedChainAnimators, [managed copy], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)animateChain {
    for (AXChainAnimator *animator in self.managedChainAnimators) {
        [animator start];
    }
}
@end
