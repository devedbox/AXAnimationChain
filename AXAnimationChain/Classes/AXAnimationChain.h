//
//  AXAnimationChain.h
//  AXAnimationChain
//
//  Created by devedbox on 2016/12/10.
//  Copyright © 2016年 devedbox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
NS_ASSUME_NONNULL_BEGIN
@protocol AXBasicAnimationDelegate;
@protocol AXKeyframeAnimationDelegate;
@protocol AXSpringAnimationDelegate;
@protocol AXAnimationChainDelegate <NSObject>
/// Core animation.
@property(readonly, nonatomic) CAAnimation *animation;
/// Basic animator. Begin with basic animation.
@property(readonly, nonatomic) id<AXBasicAnimationDelegate> basic;
/// Key frame animator. Begin with keyframe animation.
@property(readonly, nonatomic) id<AXKeyframeAnimationDelegate> keyframe;
/// Spring animator. Begin with spring animation.
@property(readonly, nonatomic) id<AXSpringAnimationDelegate> spring;
// Chain releationship manager.
- (nullable instancetype)beginWith:(id<AXAnimationChainDelegate>)animator;
- (nullable instancetype)nextTo:(id<AXAnimationChainDelegate>)animator;
- (nullable instancetype)combineWith:(id<AXAnimationChainDelegate>)animator;
- (void)start;
// CAMediaTiming protocol reachable.
- (nullable instancetype)beginTime:(NSTimeInterval)beginTime;
- (nullable instancetype)duration:(NSTimeInterval)duration;
- (nullable instancetype)speed:(CGFloat)speed;
- (nullable instancetype)timeOffset:(NSTimeInterval)timeOffset;
- (nullable instancetype)repeatCount:(CGFloat)repeatCount;
- (nullable instancetype)repeatDuration:(NSTimeInterval)repeatDuration;
- (nullable instancetype)autoreverses;
- (nullable instancetype)fillMode:(NSString *)fillMode;
// Animated property.
- (nullable instancetype)property:(NSString *)property;
// CAMediaTimingFunction reachable. Default using default function.
- (nullable instancetype)linear;
- (nullable instancetype)easeIn;
- (nullable instancetype)easeOut;
- (nullable instancetype)easeInOut;
@end
// For CABasicAnimation
@protocol AXBasicAnimationDelegate <AXAnimationChainDelegate>
- (nullable instancetype)fromValue:(id)fromValue;
- (nullable instancetype)toValue:(id)toValue;
- (nullable instancetype)byValue:(id)byValue;
@end
// For CAKeyframeAnimation
@protocol AXKeyframeAnimationDelegate <AXAnimationChainDelegate>
@end
// For CASpringAnimation
@protocol AXSpringAnimationDelegate <AXBasicAnimationDelegate>
@end

@class AXBasicAnimator;
@class AXKeyframeAnimator;
@class AXSpringAnimator;

@interface AXAnimationChainAnimator : NSObject <AXAnimationChainDelegate>
/// Animated view.
@property(weak, nonatomic) UIView *animatedView;
/// Create a animator with a specific core animation object.
+ (instancetype)animatorWithAnimation:(CAAnimation *)animation;

- (nullable instancetype)beginWith:(nonnull AXAnimationChainAnimator *)animator;
- (nullable instancetype)nextTo:(nonnull AXAnimationChainAnimator *)animator;
- (nullable instancetype)combineWith:(nonnull AXAnimationChainAnimator *)animator;
@end

@interface AXBasicAnimator : AXAnimationChainAnimator <AXBasicAnimationDelegate>
/// Core animation.
@property(readonly, nonatomic) CABasicAnimation *animation;
@end

@interface AXKeyframeAnimator : AXAnimationChainAnimator <AXKeyframeAnimationDelegate>
/// Core animation.
@property(readonly, nonatomic) CAKeyframeAnimation *animation;
@end

@interface AXSpringAnimator : AXBasicAnimator <AXSpringAnimationDelegate>
/// Core animation.
@property(readonly, nonatomic) CASpringAnimation *animation;
@end

@interface AXAnimationChainAnimator (Animator)
/// Basic animator. Begin with basic animation.
@property(readonly, nonatomic, null_resettable) AXBasicAnimator *basic;
/// Key frame animator. Begin with keyframe animation.
@property(readonly, nonatomic, null_resettable) AXKeyframeAnimator *keyframe;
/// Spring animator. Begin with spring animation.
@property(readonly, nonatomic, null_resettable) AXSpringAnimator *spring;
@end
NS_ASSUME_NONNULL_END
