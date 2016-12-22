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
@property(readonly, nonatomic, nonnull) id<AXAnimatorChainDelegate> chainAnimator;
@end

@interface UIView (ChainAnimator) <AXAnimationChainViewDelegate>
/// Animation chain object.
@property(readonly, nonatomic, nonnull) AXChainAnimator *chainAnimator;
@end
NS_ASSUME_NONNULL_END
