//
//  UIView+AnimationChian.h
//  AXAnimationChain
//
//  Created by devedbox on 2016/12/10.
//  Copyright © 2016年 devedbox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXAnimationChain.h"
#import "AXAnimationChainAnimator+Block.h"
NS_ASSUME_NONNULL_BEGIN
@protocol AXAnimationChainViewDelegate <NSObject>
/// Animation chain object.
@property(readonly, nonatomic, nonnull) id<AXAnimationChainDelegate> animationChain;
@end

@interface UIView (AnimationChain) <AXAnimationChainViewDelegate>
/// Animation chain object.
@property(readonly, nonatomic, nonnull) AXAnimationChainAnimator *animationChain;
@end
NS_ASSUME_NONNULL_END
