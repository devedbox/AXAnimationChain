//
//  AXAnimationChain.h
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
NS_ASSUME_NONNULL_BEGIN
@protocol AXMediaTimingDelegate <NSObject>
// CAMediaTiming protocol reachable.
- (instancetype)beginTime:(NSTimeInterval)beginTime;
- (instancetype)duration:(NSTimeInterval)duration;
- (instancetype)speed:(CGFloat)speed;
- (instancetype)timeOffset:(NSTimeInterval)timeOffset;
- (instancetype)repeatCount:(CGFloat)repeatCount;
- (instancetype)repeatDuration:(NSTimeInterval)repeatDuration;
- (instancetype)autoreverses;
- (instancetype)fillMode:(NSString *)fillMode;
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
/// Begin with a new animator with a specific animation.
///
/// @param animator animator to begin with.
/// @return a new animator.
///
- (instancetype)beginWith:(id<AXAnimatorChainDelegate>)animator;
/// Next to a animator as the node of the chain.
///
/// @param animator aimator to be nexted to.
/// @return the next-to animator.
///
- (instancetype)nextTo:(id<AXAnimatorChainDelegate>)animator;
/// Combine with a animator to the node of the receiver.
///
/// @param animator animator to be combined with.
/// @return the combined animator.
///
- (instancetype)combineWith:(id<AXAnimatorChainDelegate>)animator;
/// Start animating the animation chain.
///
- (void)start;
/// Add target to the specific animator.
///
/// @param target the target will trigger the completion SEL.
/// @return SELF.
///
- (instancetype)target:(nullable NSObject *)target;
/// Add completion selector to the animator.
///
/// @param completion completion selector of the target.
/// @return SELF.
///
- (instancetype)complete:(nullable SEL)completion;
/// Called when animator has finished using block on main thread.
///
/// @param completion completion block of the complete action.
/// @return SELF.
///
- (instancetype)completeWithBlock:(dispatch_block_t)completion;
@end

@protocol AXChainAnimatorDelegate <AXMediaTimingDelegate, AXAnimatorChainDelegate>

// CAMediaTimingFunction reachable. Default using default function.
- (instancetype)linear;
- (instancetype)easeIn;
- (instancetype)easeOut;
- (instancetype)easeInOut;

- (instancetype)easeInSine;
- (instancetype)easeOutSine;
- (instancetype)easeInOutSine;
- (instancetype)easeInQuad;
- (instancetype)easeOutQuad;
- (instancetype)easeInOutQuad;
- (instancetype)easeInCubic;
- (instancetype)easeOutCubic;
- (instancetype)easeInOutCubic;
- (instancetype)easeInQuart;
- (instancetype)easeOutQuart;
- (instancetype)easeInOutQuart;
- (instancetype)easeInQuint;
- (instancetype)easeOutQuint;
- (instancetype)easeInOutQuint;
- (instancetype)easeInExpo;
- (instancetype)easeOutExpo;
- (instancetype)easeInOutExpo;
- (instancetype)easeInCirc;
- (instancetype)easeOutCirc;
- (instancetype)easeInOutCirc;
- (instancetype)easeInBack;
- (instancetype)easeOutBack;
- (instancetype)easeInOutBack;
@end

@protocol AXPropertyChainAnimatorDelegate <AXChainAnimatorDelegate>
// Animated property.
- (instancetype)property:(NSString *)property;
@end

@protocol AXKeyframeChainAnimatorDelegate;

@protocol AXBasicChainAnimatorDelegate <AXPropertyChainAnimatorDelegate>
- (instancetype)fromValue:(id)fromValue;
- (instancetype)toValue:(id)toValue;
- (instancetype)byValue:(id)byValue;

// Effects converting to Keyframe animation.
- (id<AXKeyframeChainAnimatorDelegate>)easeInElastic;
- (id<AXKeyframeChainAnimatorDelegate>)easeOutElastic;
- (id<AXKeyframeChainAnimatorDelegate>)easeInOutElastic;
- (id<AXKeyframeChainAnimatorDelegate>)easeInBounce;
- (id<AXKeyframeChainAnimatorDelegate>)easeOutBounce;
- (id<AXKeyframeChainAnimatorDelegate>)easeInOutBounce;
@end

@protocol AXKeyframeChainAnimatorDelegate <AXPropertyChainAnimatorDelegate>
- (instancetype)values:(nullable NSArray<id> *)values;
- (instancetype)path:(nullable UIBezierPath *)path;
- (instancetype)keyTimes:(nullable NSArray<NSNumber *> *)keyTimes;
- (instancetype)timingFunctions:(nullable NSArray<CAMediaTimingFunction *> *)timingFunctions;
- (instancetype)calculationMode:(NSString *)calculationMode;
- (instancetype)tensionValues:(nullable NSArray<NSNumber *> *)tensionValues;
- (instancetype)continuityValues:(nullable NSArray<NSNumber *> *)continuityValues;
- (instancetype)biasValues:(nullable NSArray<NSNumber *> *)biasValues;
- (instancetype)rotationMode:(nullable NSString *)rotationMode;
@end

@protocol AXSpringChainAnimatorDelegate <AXBasicChainAnimatorDelegate>
- (instancetype)mass:(CGFloat)mass;
- (instancetype)stiffness:(CGFloat)stiffness;
- (instancetype)damping:(CGFloat)damping;
- (instancetype)initialVelocity:(CGFloat)initialVelocity;
@end

@protocol AXTransitionChainAnimatorDelegate <AXChainAnimatorDelegate>
- (instancetype)type:(NSString *)type;
- (instancetype)subtype:(NSString *)subtype;
- (instancetype)startProgress:(CGFloat)startProgress;
- (instancetype)endProgress:(CGFloat)endProgress;
- (instancetype)filter:(id)filter;
@end

@class AXBasicChainAnimator;
@class AXSpringChainAnimator;
@class AXKeyframeChainAnimator;
@class AXTransitionChainAnimator;

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

- (instancetype)beginWith:(nonnull AXChainAnimator *)animator;
- (instancetype)nextTo:(nonnull AXChainAnimator *)animator;
- (instancetype)combineWith:(nonnull AXChainAnimator *)animator;

- (AXBasicChainAnimator *)beginBasic;
- (AXSpringChainAnimator *)beginSpring;
- (AXKeyframeChainAnimator *)beginKeyframe;
/*
- (instancetype)beginTransition; */
- (AXBasicChainAnimator *)combineBasic;
- (AXSpringChainAnimator *)combineSpring;
- (AXKeyframeChainAnimator *)combineKeyframe;
- (AXTransitionChainAnimator *)combineTransition;
- (AXBasicChainAnimator *)nextToBasic;
- (AXSpringChainAnimator *)nextToSpring;
- (AXKeyframeChainAnimator *)nextToKeyframe;
- (AXTransitionChainAnimator *)nextToTransition;
@end

@interface AXBasicChainAnimator : AXChainAnimator <AXBasicChainAnimatorDelegate>
/// Core animation.
@property(readonly, nonatomic) CABasicAnimation *animation;

- (AXKeyframeChainAnimator *)easeInElastic;
- (AXKeyframeChainAnimator *)easeOutElastic;
- (AXKeyframeChainAnimator *)easeInOutElastic;
- (AXKeyframeChainAnimator *)easeInBounce;
- (AXKeyframeChainAnimator *)easeOutBounce;
- (AXKeyframeChainAnimator *)easeInOutBounce;
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

@interface AXChainAnimator (TopAnimator)
/// Top animator. Might be SELF if there is not any child animator.
@property(readonly, nonatomic, nonnull) __kindof AXChainAnimator *topAnimator;
@end
NS_ASSUME_NONNULL_END
