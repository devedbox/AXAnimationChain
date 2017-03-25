//
//  UIView+AnimationChian.h
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

#import <UIKit/UIKit.h>
#import "AXChainAnimator.h"
NS_ASSUME_NONNULL_BEGIN
@protocol AXAnimationChainViewDelegate <NSObject>
/// Animation chain object.
@property(readonly, nonatomic, nonnull) id<AXAnimatorChainDelegate> chainAnimator;
@end

@interface UIView (ChainAnimator) <AXAnimationChainViewDelegate>
/// Default Animation chain object.
@property(readonly, nonatomic, nonnull) AXChainAnimator *chainAnimator;
/// Managed chain animators.
@property(readonly, nonatomic, nonnull) NSArray<AXChainAnimator *> *managedChainAnimators;
/// Add chain animator.
- (void)addChainAnimator:(nonnull AXChainAnimator *)animator;
/// Animate all the managed chain animators.
- (void)animateChain;
@end
NS_ASSUME_NONNULL_END
