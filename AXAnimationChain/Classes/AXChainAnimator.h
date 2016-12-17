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
@protocol AXMediaTimingDelegate <NSObject>
// CAMediaTiming protocol reachable.
- (nullable instancetype)beginTime:(NSTimeInterval)beginTime;
- (nullable instancetype)duration:(NSTimeInterval)duration;
- (nullable instancetype)speed:(CGFloat)speed;
- (nullable instancetype)timeOffset:(NSTimeInterval)timeOffset;
- (nullable instancetype)repeatCount:(CGFloat)repeatCount;
- (nullable instancetype)repeatDuration:(NSTimeInterval)repeatDuration;
- (nullable instancetype)autoreverses;
- (nullable instancetype)fillMode:(NSString *)fillMode;
@end

@protocol AXBasicChainAnimatorDelegate;
@protocol AXKeyframeChainAnimatorDelegate;
@protocol AXSpringChainAnimatorDelegate;
@protocol AXTransitionChainAnimatorDelegate;

@protocol AXAnimatorChainDelegate <NSObject>
/// Father animator object.
@property(weak,   nonatomic, nullable) id<AXAnimatorChainDelegate> superAnimator;
/// Child animator object.
@property(strong, nonatomic, nullable) id<AXAnimatorChainDelegate> childAnimator;
/// Brothers animator objects.
@property(strong, nonatomic, nullable) NSArray<id<AXAnimatorChainDelegate>> *combinedAnimators;
/// Core animation of the animator.
@property(readonly, nonatomic) CAAnimation *animation;
/// Basic animator. Begin with basic animation.
@property(readonly, nonatomic) id<AXBasicChainAnimatorDelegate> basic;
/// Key frame animator. Begin with keyframe animation.
@property(readonly, nonatomic) id<AXKeyframeChainAnimatorDelegate> keyframe;
/// Spring animator. Begin with spring animation.
@property(readonly, nonatomic) id<AXSpringChainAnimatorDelegate> spring;
/// Transition animator. Begin with transition animation.
@property(readonly, nonatomic) id<AXTransitionChainAnimatorDelegate> transition;
// Chain releationship manager.
- (nullable instancetype)beginWith:(id<AXAnimatorChainDelegate>)animator;
- (nullable instancetype)nextTo:(id<AXAnimatorChainDelegate>)animator;
- (nullable instancetype)combineWith:(id<AXAnimatorChainDelegate>)animator;
- (void)start;
@end

@protocol AXChainAnimatorDelegate <AXMediaTimingDelegate, AXAnimatorChainDelegate>

// CAMediaTimingFunction reachable. Default using default function.
- (nullable instancetype)linear;
- (nullable instancetype)easeIn;
- (nullable instancetype)easeOut;
- (nullable instancetype)easeInOut;
@end

@protocol AXPropertyChainAnimatorDelegate <AXChainAnimatorDelegate>
// Animated property.
- (nullable instancetype)property:(NSString *)property;
@end

@protocol AXBasicChainAnimatorDelegate <AXPropertyChainAnimatorDelegate>
- (nullable instancetype)fromValue:(id)fromValue;
- (nullable instancetype)toValue:(id)toValue;
- (nullable instancetype)byValue:(id)byValue;
@end

@protocol AXKeyframeChainAnimatorDelegate <AXPropertyChainAnimatorDelegate>
- (nullable instancetype)values:(nullable NSArray<id> *)values;
- (nullable instancetype)path:(nullable UIBezierPath *)path;
- (nullable instancetype)keyTimes:(nullable NSArray<NSNumber *> *)keyTimes;
- (nullable instancetype)timingFunctions:(nullable NSArray<CAMediaTimingFunction *> *)timingFunctions;
- (nullable instancetype)calculationMode:(NSString *)calculationMode;
- (nullable instancetype)tensionValues:(nullable NSArray<NSNumber *> *)tensionValues;
- (nullable instancetype)continuityValues:(nullable NSArray<NSNumber *> *)continuityValues;
- (nullable instancetype)biasValues:(nullable NSArray<NSNumber *> *)biasValues;
- (nullable instancetype)rotationMode:(nullable NSString *)rotationMode;
@end

@protocol AXSpringChainAnimatorDelegate <AXBasicChainAnimatorDelegate>
- (nullable instancetype)mass:(CGFloat)mass;
- (nullable instancetype)stiffness:(CGFloat)stiffness;
- (nullable instancetype)damping:(CGFloat)damping;
- (nullable instancetype)initialVelocity:(CGFloat)initialVelocity;
@end

@protocol AXTransitionChainAnimatorDelegate <AXChainAnimatorDelegate>
- (nullable instancetype)type:(NSString *)type;
- (nullable instancetype)subtype:(NSString *)subtype;
- (nullable instancetype)startProgress:(CGFloat)startProgress;
- (nullable instancetype)endProgress:(CGFloat)endProgress;
- (nullable instancetype)filter:(id)filter;
@end

@interface AXChainAnimator : NSObject <AXChainAnimatorDelegate>
/// Father animator.
@property(weak,   nonatomic, nullable) AXChainAnimator *superAnimator;
/// Next to animator.
@property(strong, nonatomic, nullable) AXChainAnimator *childAnimator;
/// Combined animators.
@property(strong, nonatomic, nullable) NSArray<AXChainAnimator *> *combinedAnimators;
/// Animated view.
@property(weak, nonatomic) UIView *animatedView;
/// Create a animator with a specific core animation object.
+ (instancetype)animatorWithAnimation:(CAAnimation *)animation;

- (nullable instancetype)beginWith:(nonnull AXChainAnimator *)animator;
- (nullable instancetype)nextTo:(nonnull AXChainAnimator *)animator;
- (nullable instancetype)combineWith:(nonnull AXChainAnimator *)animator;
@end

@interface AXBasicChainAnimator : AXChainAnimator <AXBasicChainAnimatorDelegate>
/// Core animation.
@property(readonly, nonatomic) CABasicAnimation *animation;
@end

@interface AXKeyframeChainAnimator : AXChainAnimator <AXKeyframeChainAnimatorDelegate>
/// Core animation.
@property(readonly, nonatomic) CAKeyframeAnimation *animation;
@end

@interface AXSpringChainAnimator : AXBasicChainAnimator <AXSpringChainAnimatorDelegate>
/// Core animation.
@property(readonly, nonatomic) CASpringAnimation *animation;
@end

@interface AXTransitionChainAnimator : AXChainAnimator <AXTransitionChainAnimatorDelegate>
/// Core animation.
@property(readonly, nonatomic) CATransition *animation;
@end

@interface AXChainAnimator (Animator)
/// Basic animator. Begin with basic animation.
@property(readonly, nonatomic, null_resettable) AXBasicChainAnimator *basic;
/// Key frame animator. Begin with keyframe animation.
@property(readonly, nonatomic, null_resettable) AXKeyframeChainAnimator *keyframe;
/// Spring animator. Begin with spring animation.
@property(readonly, nonatomic, null_resettable) AXSpringChainAnimator *spring;
/// Transition animator. Begin with transition animation.
@property(readonly, nonatomic, null_resettable) AXTransitionChainAnimator *transition;
@end
NS_ASSUME_NONNULL_END
