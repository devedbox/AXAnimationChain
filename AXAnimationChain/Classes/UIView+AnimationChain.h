//
//  UIView+AnimationChian.h
//  AXAnimationChain
//
//  Created by devedbox on 2016/12/10.
//  Copyright © 2016年 devedbox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXChainAnimator.h"
#import "AXChainAnimator+Block.h"
NS_ASSUME_NONNULL_BEGIN
@protocol AXAnimationChainViewDelegate <NSObject>
/// Animation chain object.
@property(readonly, nonatomic, nonnull) id<AXAnimatorChainDelegate> animationChain;
@end

@interface UIView (AnimationChain) <AXAnimationChainViewDelegate>
/// Animation chain object.
@property(readonly, nonatomic, nonnull) AXChainAnimator *animationChain;
@end
NS_ASSUME_NONNULL_END
