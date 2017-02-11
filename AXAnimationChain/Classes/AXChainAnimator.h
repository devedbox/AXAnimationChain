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
/// CAMediaTiming protocol reachable.
@protocol AXMediaTimingDelegate <NSObject>
/// Set the begin time of the animation object with a time interval.
///
/// @param beginTime a time interval since the super object.
/// @return Original instance object.
///
/// @see <QuartzCore/CAMediaTiming.h>
- (instancetype)beginTime:(NSTimeInterval)beginTime;
/// Set the duration of the animation object with a time interval.
///
/// @param duration time duration.
/// @return Original instance object.
///
/// @see <QuartzCore/CAMediaTiming.h>
- (instancetype)duration:(NSTimeInterval)duration;
/// Set the speed of the animation object of a speed value.
///
/// @param speed a float value of the speed.
/// @return Original instance object.
///
/// @see <QuartzCore/CAMediaTiming.h>
- (instancetype)speed:(CGFloat)speed;
/// Set the time offset of animation object with a time interval.
///
/// @param timeOffset a double value of timg offset.
/// @return Original instance object.
///
/// @see <QuartzCore/CAMediaTiming.h>
- (instancetype)timeOffset:(NSTimeInterval)timeOffset;
/// Set the repeat count of the core animation. Work like `reeapDuration:`.
///
/// @param repeatCount repeat count of the core animation.
/// @return the receiver.
///
/// @see <QuartzCore/CAMediaTiming.h>
- (instancetype)repeatCount:(CGFloat)repeatCount;
/// Set the repeat duration of the core animation. Work like `reeapCount:`.
///
/// @param repeatDuration repeat duration of the core animation.
/// @return the receiver.
///
/// @see <QuartzCore/CAMediaTiming.h>
- (instancetype)repeatDuration:(NSTimeInterval)repeatDuration;
/// Set the autoreverses of the core animation.
///
/// @return the receiver.
///
/// @see <QuartzCore/CAMediaTiming.h>
- (instancetype)autoreverses;
/// Set the fill mode of the core animation.
///
/// @param fillMode fill mode of the core animation.
/// @return the receiver.
///
/// @see <QuartzCore/CAMediaTiming.h>
- (instancetype)fillMode:(NSString *)fillMode;
/// Remove the animation when the animator has finished the animating. Defaults to NO.
/// @discusstion This way is not recommended to chain the animations because that
///              if the begining animation is finished and removed, the result will
///              effect the next animators.
- (instancetype)removedOnCompletion;
@end

@protocol AXBasicChainAnimatorDelegate;
@protocol AXKeyframeChainAnimatorDelegate;
@protocol AXSpringChainAnimatorDelegate;
@protocol AXTransitionChainAnimatorDelegate;

/// Animator chain defines.
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
/// Chain animator defines.
@protocol AXChainAnimatorDelegate <AXMediaTimingDelegate, AXAnimatorChainDelegate>
// CAMediaTimingFunction reachable. Default using default function:
/// Using linear timing function.
- (instancetype)linear;
/// Using ease in timing function.
- (instancetype)easeIn;
/// Using ease out timing function.
- (instancetype)easeOut;
/// Using ease in out timing function.
- (instancetype)easeInOut;
// Custom tming functions like CSS3:
/// Using ease in sine timing function.
- (instancetype)easeInSine;
/// Using ease out sine timing function.
- (instancetype)easeOutSine;
/// Using ease in out sine timing function.
- (instancetype)easeInOutSine;
/// Using ease in quad timing function.
- (instancetype)easeInQuad;
/// Using ease out quad timing function.
- (instancetype)easeOutQuad;
/// Using ease in out quad timing function.
- (instancetype)easeInOutQuad;
/// Using ease in cubic timing function.
- (instancetype)easeInCubic;
/// Using ease out cubic timing function.
- (instancetype)easeOutCubic;
/// Using ease in out cubic timing function.
- (instancetype)easeInOutCubic;
/// Using ease in quart timing function.
- (instancetype)easeInQuart;
/// Using ease out quart timing function.
- (instancetype)easeOutQuart;
/// Using ease in out quart timing function.
- (instancetype)easeInOutQuart;
/// Using ease in quint timing function.
- (instancetype)easeInQuint;
/// Using ease out quint timing function.
- (instancetype)easeOutQuint;
/// Using ease in out quint timing function.
- (instancetype)easeInOutQuint;
/// Using ease in expo timing function.
- (instancetype)easeInExpo;
/// Using ease out expo timing function.
- (instancetype)easeOutExpo;
/// Using ease in out expo timing function.
- (instancetype)easeInOutExpo;
/// Using ease in circ timing function.
- (instancetype)easeInCirc;
/// Using ease out circ timing function.
- (instancetype)easeOutCirc;
/// Using ease in out circ timing function.
- (instancetype)easeInOutCirc;
/// Using ease in back timing function.
- (instancetype)easeInBack;
/// Using ease out back timing function.
- (instancetype)easeOutBack;
/// Using ease in out back timing function.
- (instancetype)easeInOutBack;
@end
/// CAPropertyAnimation reachable.
@protocol AXPropertyChainAnimatorDelegate <AXChainAnimatorDelegate>
/// Set animated property key path value.
///
/// @param property a key path of animatable properties.
/// @return the receiver.
///
- (instancetype)property:(NSString *)property;
@end

@protocol AXKeyframeChainAnimatorDelegate;
/// CABasicAnimation reachable.
@protocol AXBasicChainAnimatorDelegate <AXPropertyChainAnimatorDelegate>
/// Set fromValue of the basic animation.
///
/// @param fromValue animation from value.
/// @return the receiver.
///
- (instancetype)fromValue:(id)fromValue;
/// Set toValue of the basic animation.
///
/// @param toValue animation to value.
/// @return the receiver.
///
- (instancetype)toValue:(id)toValue;
/// Set byValue of the basic animation.
///
/// @param byValue animation by value.
/// @return the receiver.
///
- (instancetype)byValue:(id)byValue;

// Effects converting to Keyframe animation.
/// Using ease in elastic timing function.
- (id<AXKeyframeChainAnimatorDelegate>)easeInElastic;
/// Using ease out elastic timing function.
- (id<AXKeyframeChainAnimatorDelegate>)easeOutElastic;
/// Using ease in out elastic timing function.
- (id<AXKeyframeChainAnimatorDelegate>)easeInOutElastic;
/// Using ease in bounce timing function.
- (id<AXKeyframeChainAnimatorDelegate>)easeInBounce;
/// Using ease out bounce timing function.
- (id<AXKeyframeChainAnimatorDelegate>)easeOutBounce;
/// Using ease in out bounce timing function.
- (id<AXKeyframeChainAnimatorDelegate>)easeInOutBounce;
/// Using gravity timing function.
- (id<AXKeyframeChainAnimatorDelegate>)gravity;
@end
/// CAKeyframeAnimation reachable.
@protocol AXKeyframeChainAnimatorDelegate <AXPropertyChainAnimatorDelegate>
/// Set values of the core keyframe animation.
///
/// @param values values of the keyframe animation.
/// @return the receiver.
///
- (instancetype)values:(nullable NSArray<id> *)values;
/// Set the path of the core keyframe animation.
///
/// @param path path setted to the keyframe animation.
/// @return the receiver.
///
- (instancetype)path:(nullable UIBezierPath *)path;
/// Set the key times to the core keyframe animation.
///
/// @param keyTimes key times setted to the keyframe animation.
/// @return the receiver.
///
- (instancetype)keyTimes:(nullable NSArray<NSNumber *> *)keyTimes;
/// Set timing functions to the core keyframe animation.
///
/// @param timingFunctions timing functions setted to the keyframe animation.
/// @return the receiver.
///
- (instancetype)timingFunctions:(nullable NSArray<CAMediaTimingFunction *> *)timingFunctions;
/// Set calculation mode to the core keyframe animation.
///
/// @param calculationMode calculation mode setted to keyframe animation.
/// @return the receiver.
///
- (instancetype)calculationMode:(NSString *)calculationMode;
/// Set tension values to the core keyframe animation.
///
/// @param tensionValues tension values setted to the keyframe animation.
/// @return the receiver.
///
- (instancetype)tensionValues:(nullable NSArray<NSNumber *> *)tensionValues;
/// Set the continuity valyes to the core keyframe animation.
///
/// @param continuityValues continuity values setted to the keyframe animation.
/// @return the receiver.
///
- (instancetype)continuityValues:(nullable NSArray<NSNumber *> *)continuityValues;
/// Set bias values to the core keyframe animation.
///
/// @param biasValues bias values setted to the keyframe animation.
/// @return the receiver.
///
- (instancetype)biasValues:(nullable NSArray<NSNumber *> *)biasValues;
/// Set the rotation mode to the core keyframe animation.
///
/// @param rotationMode rotation mode setted to the keyframe animation.
/// @return the receiver.
///
- (instancetype)rotationMode:(nullable NSString *)rotationMode;
@end
/// CASpringAnimation/AXSpringAnimation reachable.
@protocol AXSpringChainAnimatorDelegate <AXBasicChainAnimatorDelegate>
/// Set the mass to the core spring animation.
///
/// @param mass mass setted to the spring animation.
/// @return the receiver.
///
- (instancetype)mass:(CGFloat)mass;
/// Set the stiffness to the core spring animation.
///
/// @param stiffness seiffness setted to the spring animation.
/// @return the receiver.
///
- (instancetype)stiffness:(CGFloat)stiffness;
/// Set the damping to the core spring animation.
///
/// @param damping damping setted to the spring animation.
/// @return the receiver.
///
- (instancetype)damping:(CGFloat)damping;
/// Set the initial velocity to the core spring animation.
///
/// @param initialVelocity initial velocity setted to the spring animation.
/// @return the receiver.
///
- (instancetype)initialVelocity:(CGFloat)initialVelocity;
@end
/// CATransitionAnimation reachable.
@protocol AXTransitionChainAnimatorDelegate <AXChainAnimatorDelegate>
/// Set type to the core transition animation.
///
/// @param type tpye setted to the transtion animation.
/// @return the receiver.
///
- (instancetype)type:(NSString *)type;
/// Set subtype to the core transition animation.
///
/// @param subtype subtype setted to the transition animation.
/// @return the receiver.
///
- (instancetype)subtype:(NSString *)subtype;
/// Set the start progress to the core transition animation.
///
/// @param startProgress start progress setted to the transition animation.
/// @return the receiver.
///
- (instancetype)startProgress:(CGFloat)startProgress;
/// Set the end progress to the core transition animation.
///
/// @param endProgress end progress setted to the transition animaton.
/// @return the receiver.
///
- (instancetype)endProgress:(CGFloat)endProgress;
/// Set the filter to the core transition animation.
///
/// @param filter filter setted to the transition animation.
/// @return the receiver.
///
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
/// Begin with a new animator and replace the receiver animator.
- (instancetype)beginWith:(nonnull AXChainAnimator *)animator;
/// Link a new animator to the child animator of the receiver animator.
- (instancetype)nextTo:(nonnull AXChainAnimator *)animator;
/// Link a new animator to the combined animators of the receiver animator.
- (instancetype)combineWith:(nonnull AXChainAnimator *)animator;
/// Begin with a basic animator.
- (AXBasicChainAnimator *)beginBasic;
/// Begin with a spring animator.
- (AXSpringChainAnimator *)beginSpring;
/// Begin with a keyframe animator.
///
/// @return a new keyframe animator.
- (AXKeyframeChainAnimator *)beginKeyframe;
/*
- (instancetype)beginTransition; */
/// Combine with a basic animator and return the animator.
- (AXBasicChainAnimator *)combineBasic;
/// Combine with a spring animator and return the animator.
- (AXSpringChainAnimator *)combineSpring;
/// Combine with a keyframe animator.
- (AXKeyframeChainAnimator *)combineKeyframe;
/// Combine with a transition animator.
- (AXTransitionChainAnimator *)combineTransition;
/// Next to a basic animator.
- (AXBasicChainAnimator *)nextToBasic;
/// Next to a spring animator.
- (AXSpringChainAnimator *)nextToSpring;
/// Next to a keyframe animator.
- (AXKeyframeChainAnimator *)nextToKeyframe;
/// Next to a transition animator.
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

- (AXKeyframeChainAnimator *)gravity;
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

@interface AXChainAnimator (AnchorPoint)
/// Move anchor to a new anchor point. This will change the position of the layer.
///
/// @param point a new anchor point. Between [0, 1].
- (instancetype)moveAnchorToPoint:(CGPoint)point;
/// Move anchor point to default anchor value.
- (instancetype)anchorToDefault;
/// Move anchor point to center point.
- (instancetype)anchorToCenter;
/// Move anchor point to top.
- (instancetype)anchorToTop;
/// Move anchor point to left.
- (instancetype)anchorToLeft;
/// Move anchor point to bottom.
- (instancetype)anchorToBottom;
/// Move anchor point to right.
- (instancetype)anchorToRight;
/// Move anchor point to left-top.
- (instancetype)anchorToLeftTop;
/// Move anchor point to left-bottom.
- (instancetype)anchorToLeftBottom;
/// Move anchor point to right-top.
- (instancetype)anchorToRightTop;
/// Move anchor point to right-bottom.
- (instancetype)anchorToRightBottom;
@end
NS_ASSUME_NONNULL_END
