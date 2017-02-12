//
//  AXAnimationChain.m
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

#import "AXChainAnimator.h"
#import "CAMediaTimingFunction+Extends.h"
#import "CAAnimation+Convertable.h"
NS_ASSUME_NONNULL_BEGIN
@interface AXChainAnimator () <CAAnimationDelegate>
{
    @protected
    /// Is animations in traansaction.
    BOOL _inTransaction;
    /// Complete sel action.
    SEL _completionAction;
    /// Complete block handler.
    dispatch_block_t _completionBlock;
    /// Complete target object.
    NSObject *__weak _completionTarget;
}
/// Set animation object to the animator.
- (void)_setAnimation:(CAAnimation *)animation;
/// Set combined animators to the combined animators.
- (void)_setCombinedAnimators:(NSArray<AXChainAnimator *> *)combinedAnimators;
@end

@interface AXKeyframeChainAnimator ()
/// Timing function flags.
@property(copy, nonatomic, nullable) NSString *timingFunctionFlags;
@end

static NSString *const kAXKeyframeTimgingFunctionFlagGravity = @"gravity";

@implementation AXChainAnimator
@synthesize animation = _animation;
+ (instancetype)animatorWithAnimation:(CAAnimation *)animation {
    id obj = [[self.class alloc] init];
    NSAssert([obj respondsToSelector:@selector(_setAnimation:)], @"Object cannot be created.");
    [obj performSelector:@selector(_setAnimation:) withObject:animation];
    return obj;
}

- (instancetype)init {
    if (self = [super init]) {
        [self _setAnimation:[self _defaultAnimation]];
    }
    return self;
}

- (instancetype)initWithAnimator:(__kindof AXChainAnimator *)animator {
    if (self = [super init]) {
        [self _setAnimation:animator.animation];
        self.superAnimator = animator.superAnimator;
        self.childAnimator = animator.childAnimator;
        self.combinedAnimators = animator.combinedAnimators;
        self.animatedView = animator.animatedView;
    }
    return self;
}

#pragma mark - ChainHandler.
- (instancetype)beginWith:(nonnull AXChainAnimator *)animator {
    if ([animator isKindOfClass:[AXTransitionChainAnimator class]] || [self isKindOfClass:[AXTransitionChainAnimator class]]) return animator;
    if ([animator isKindOfClass:[AXKeyframeChainAnimator class]]) {
        if ([self isKindOfClass:[AXKeyframeChainAnimator class]]) return self;
        
        if ([self isKindOfClass:[AXBasicChainAnimator class]]) {
            [animator _setAnimation:[CAKeyframeAnimation animationWithBasic:(CABasicAnimation *)self.animation]];
        } else if ([self isKindOfClass:[AXSpringChainAnimator class]]) {
            [animator _setAnimation:[CAKeyframeAnimation animationWithSpring:(CASpringAnimation *)self.animation]];
        }
    } else if ([animator isKindOfClass:[AXBasicChainAnimator class]] && ![animator isKindOfClass:[AXSpringChainAnimator class]]) {
        if ([self isKindOfClass:[AXBasicChainAnimator class]] && ![animator isKindOfClass:[AXSpringChainAnimator class]]) return self;
        
        if ([self isKindOfClass:[AXKeyframeChainAnimator class]]) {
            [animator _setAnimation:[CABasicAnimation animationWithKeyframe:(CAKeyframeAnimation *)self.animation]];
        } else if ([self isKindOfClass:[AXSpringChainAnimator class]]) {
            [animator _setAnimation:[CABasicAnimation animationWithSpring:(CASpringAnimation *)self.animation]];
        }
    } else if ([animator isKindOfClass:[AXSpringChainAnimator class]]) {
        if ([self isKindOfClass:[AXSpringChainAnimator class]]) return self;
        
        if ([self isKindOfClass:[AXKeyframeChainAnimator class]]) {
            [animator _setAnimation:[CASpringAnimation animationWithKeyframe:(CAKeyframeAnimation *)self.animation]];
        } else if ([self isKindOfClass:[AXBasicChainAnimator class]]) {
            [animator _setAnimation:[CASpringAnimation animationWithBasic:(CABasicAnimation *)self.animation]];
        }
    }
    return animator;
}

- (AXBasicChainAnimator *)beginBasic {
   return (AXBasicChainAnimator *)[self beginWith:[self _basicAnimator]];
}

- (AXSpringChainAnimator *)beginSpring {
    return (AXSpringChainAnimator *)[self beginWith:[self _springAnimator]];
}

- (AXKeyframeChainAnimator *)beginKeyframe {
    return (AXKeyframeChainAnimator *)[self beginWith:[self _keyframeAnimator]];
}
/*
- (instancetype)beginTransition {
    return [self beginWith:[self _transitionAnimator]];
} */

- (instancetype)nextTo:(nonnull AXChainAnimator *)animator {
    // Get supper animator.
    AXChainAnimator *superAnimator = animator.superAnimator?:animator;
    // Get super super animator.
    AXChainAnimator *superSuperAnimator = superAnimator;
    
    while (superAnimator) {
        superAnimator = superAnimator.superAnimator;
        if (superAnimator) {
            superSuperAnimator = superAnimator;
            if (superAnimator == self) { // If super animator contains SELF then ignore the animator and return.
                return animator;
            }
        }
    }
    // Find the super super animator of SELF.
    AXChainAnimator *ssuper = self;
    while (ssuper) {
        if (!ssuper.superAnimator) {
            break;
        }
        ssuper = ssuper.superAnimator;
    }
    AXChainAnimator *child = ssuper;
    // Find the last child animator.
    while (child) {
        AXChainAnimator *_child = child.childAnimator;
        if (!_child) {// Append the next to animator to the last child animator.
            child.childAnimator = superSuperAnimator;
            child.childAnimator.superAnimator = child;
            break;
        }
        child = _child;
    }

    return superSuperAnimator;
}

- (instancetype)nextToBasic {
    return [self nextTo:[self _basicAnimator]];
}

- (instancetype)nextToSpring {
    return [self nextTo:[self _springAnimator]];
}

- (instancetype)nextToKeyframe {
    return [self nextTo:[self _keyframeAnimator]];
}

- (instancetype)nextToTransition {
    return [self nextTo:[self _transitionAnimator]];
}

- (instancetype)combineWith:(nonnull AXChainAnimator *)animator {
    // Get the mutable copy of combined animators.
    NSMutableArray *animators = [_combinedAnimators mutableCopy];
    // Initialize a new container of combined animators.
    if (!animators) animators = [NSMutableArray array];
    // Get the super super animator of the combined animator.
    AXChainAnimator *superAnimator = animator.superAnimator?:animator;
    AXChainAnimator *superSuperAnimator = superAnimator;
    while (superAnimator) {
        superAnimator = superAnimator.superAnimator;
        if (superAnimator) {// Combine the super super animator instead of animator.
            superSuperAnimator = superAnimator;
        }
    }
    if ([animators containsObject:animator]) return animator;
    [animators addObject:superSuperAnimator];
    // Set the super animator to SELF.
    animator.superAnimator = self;
    _combinedAnimators = [animators mutableCopy];
    return animator;
}

- (instancetype)combineBasic {
    return [self combineWith:[self _basicAnimator]];
}

- (instancetype)combineSpring {
    return [self combineWith:[self _springAnimator]];
}

- (instancetype)combineKeyframe {
    return [self combineWith:[self _keyframeAnimator]];
}

- (instancetype)combineTransition {
    return [self combineWith:[self _transitionAnimator]];
}
#pragma mark - Getters.
- (AXBasicChainAnimator *)_basicAnimator {
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    AXBasicChainAnimator *basic = [AXBasicChainAnimator animatorWithAnimation:animation];
    basic.animatedView = _animatedView;
    return basic;
}

- (AXKeyframeChainAnimator *)_keyframeAnimator {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    AXKeyframeChainAnimator *keyframe = [AXKeyframeChainAnimator animatorWithAnimation:animation];
    keyframe.animatedView = _animatedView;
    return keyframe;
}

- (AXSpringChainAnimator *)_springAnimator {
    CASpringAnimation *animation = [CASpringAnimation animation];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    AXSpringChainAnimator *spring = [AXSpringChainAnimator animatorWithAnimation:animation];
    spring.animatedView = _animatedView;
    return spring;
}

- (AXTransitionChainAnimator *)_transitionAnimator {
    CATransition *animation = [CATransition animation];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    AXTransitionChainAnimator *transition = [AXTransitionChainAnimator animatorWithAnimation:animation];
    transition.animatedView = _animatedView;
    return transition;
}

- (AXBasicChainAnimator *)basic {
    return [self _basicAnimator];
}

- (AXKeyframeChainAnimator *)keyframe {
    return [self _keyframeAnimator];
}

- (AXSpringChainAnimator *)spring {
    return [self _springAnimator];
}

- (AXTransitionChainAnimator *)transition {
    return [self _transitionAnimator];
}

- (AXChainAnimator *)topAnimator {
    AXChainAnimator *child = self;
    // Find the last child animator.
    while (child) {
        AXChainAnimator *_child = child.childAnimator;
        if (!_child) {// Return the result.
            return child;
        }
        child = _child;
    }
    return child;
}

- (instancetype)moveAnchorToPoint:(CGPoint)point {
    if (self.animatedView) {
        [self.animatedView.layer moveAnchorToPoint:point];
    }
    return self;
}

- (instancetype)anchorToDefault {
    if (self.animatedView) {
        [self.animatedView.layer anchorToDefault];
    }
    return self;
}

- (instancetype)anchorToCenter {
    if (self.animatedView) {
        [self.animatedView.layer anchorToCenter];
    }
    return self;
}

- (instancetype)anchorToTop {
    if (self.animatedView) {
        [self.animatedView.layer anchorToTop];
    }
    return self;
}

- (instancetype)anchorToLeft {
    if (self.animatedView) {
        [self.animatedView.layer anchorToLeft];
    }
    return self;
}

- (instancetype)anchorToBottom {
    if (self.animatedView) {
        [self.animatedView.layer anchorToBottom];
    }
    return self;
}

- (instancetype)anchorToRight {
    if (self.animatedView) {
        [self.animatedView.layer anchorToRight];
    }
    return self;
}

- (instancetype)anchorToLeftTop {
    if (self.animatedView) {
        [self.animatedView.layer anchorToLeftTop];
    }
    return self;
}

- (instancetype)anchorToLeftBottom {
    if (self.animatedView) {
        [self.animatedView.layer anchorToLeftBottom];
    }
    return self;
}

- (instancetype)anchorToRightTop {
    if (self.animatedView) {
        [self.animatedView.layer anchorToRightTop];
    }
    return self;
}

- (instancetype)anchorToRightBottom {
    if (self.animatedView) {
        [self.animatedView.layer anchorToRightBottom];
    }
    return self;
}
#pragma mark - AXAnimatorChainDelegate.
- (void)start {
    NSAssert(_animatedView, @"Animation chain cannot be created because animated view is null.");
    AXChainAnimator *superAnimator = _superAnimator;
    AXChainAnimator *superSuperAnimator = _superAnimator;
    while (superAnimator) {
        superAnimator = superAnimator.superAnimator;
        if (superAnimator) {
            superSuperAnimator = superAnimator;
        }
    }
    if (superSuperAnimator) {
        [superSuperAnimator start];
    } else {
        [self _beginAnimating];
        if (!_childAnimator) [self _clear];
    }
}

- (void)_beginAnimating {
    if (_inTransaction) return;
    [CATransaction flush];
    [CATransaction begin];
    /* _inTransaction = YES; */
    [CATransaction setDisableActions:YES];
    /* CAAnimation *animation = [self _animationGroups];
    [_animatedView.layer addAnimation:animation forKey:[NSString stringWithFormat:@"%p", self]]; */
    
    [CATransaction setCompletionBlock:^() {
        /* _inTransaction = NO; */
        if (_childAnimator && [_animatedView.layer animationForKey:[NSString stringWithFormat:@"%p", _animation]]/* && [UIApplication sharedApplication].applicationState == UIApplicationStateActive*/) {
            [_childAnimator _beginAnimating];
        }
    }];
    
    [self _addAnimationsToAnimatedLayer];
    
    [CATransaction commit];
}

- (void)_addAnimationsToAnimatedLayer {
    if ([_animation isKindOfClass:CASpringAnimation.class]) {
        if (!_animation.duration && [_animation respondsToSelector:@selector(settlingDuration)]) {
            _animation.duration = [(CASpringAnimation *)_animation settlingDuration];
        }
    }/* else if ([self isKindOfClass:AXKeyframeChainAnimator.class]) { // Handle the custom timing functions.
        AXKeyframeChainAnimator *animator = (AXKeyframeChainAnimator *)self;
        if ([animator.timingFunctionFlags isEqualToString:kAXKeyframeTimgingFunctionFlagGravity]) {
            if (!_animation.duration) {
                
            }
        }
    } */
    [_animatedView.layer addAnimation:_animation forKey:[NSString stringWithFormat:@"%p", _animation]];
    for (AXChainAnimator *animator in _combinedAnimators) {
        [animator _addAnimationsToAnimatedLayer];
    }
}

- (instancetype)target:(nullable NSObject *)target {
    _completionTarget = target;
    return self;
}

- (instancetype)complete:(nullable SEL)completion {
    _completionAction = completion;
    return self;
}

- (instancetype)completeWithBlock:(dispatch_block_t)completion {
    _completionBlock = [completion copy];
    return self;
}
#pragma mark - CAAnimationDelegate.
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)finished {
    if (/* finished && */_completionTarget != nil && _completionAction != NULL) {
        [_completionTarget performSelectorOnMainThread:_completionAction withObject:self waitUntilDone:NO modes:@[NSDefaultRunLoopMode]];
    }
    // Trigger completion block.
    if (_completionBlock) {
        if ([NSThread isMainThread]) {
            _completionBlock();
        } else dispatch_async(dispatch_get_main_queue(), _completionBlock);
    }
}

#pragma mark - Property.
- (instancetype)beginTime:(NSTimeInterval)beginTime {
    _animation.beginTime = beginTime+CACurrentMediaTime();
    return self;
}

- (instancetype)duration:(NSTimeInterval)duration {
    _animation.duration = duration;
    return self;
}

- (instancetype)speed:(CGFloat)speed {
    _animation.speed = speed;
    return self;
}

- (instancetype)timeOffset:(NSTimeInterval)timeOffset {
    _animation.timeOffset = timeOffset;
    return self;
}

- (instancetype)repeatCount:(CGFloat)repeatCount {
    _animation.repeatCount = repeatCount;
    return self;
}

- (instancetype)repeatDuration:(NSTimeInterval)repeatDuration {
    _animation.repeatDuration = repeatDuration;
    return self;
}

- (instancetype)autoreverses {
    _animation.autoreverses = YES;
    return self;
}

- (instancetype)fillMode:(NSString *)fillMode {
    _animation.fillMode = [fillMode copy];
    return self;
}

- (instancetype)removedOnCompletion {
    if (!_animation.removedOnCompletion) _animation.removedOnCompletion = YES;
    return self;
}

- (instancetype)linear {
    _animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    return self;
}

- (instancetype)easeIn {
    _animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    return self;
}

- (instancetype)easeOut {
    _animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    return self;
}

- (instancetype)easeInOut {
    _animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return self;
}

- (instancetype)easeInSine {
    _animation.timingFunction = [CAMediaTimingFunction easeInSine];
    return self;
}

- (instancetype)easeOutSine {
    _animation.timingFunction = [CAMediaTimingFunction easeOutSine];
    return self;
}

- (instancetype)easeInOutSine {
    _animation.timingFunction = [CAMediaTimingFunction easeInOutSine];
    return self;
}

- (instancetype)easeInQuad {
    _animation.timingFunction = [CAMediaTimingFunction easeInQuad];
    return self;
}

- (instancetype)easeOutQuad {
    _animation.timingFunction = [CAMediaTimingFunction easeOutQuad];
    return self;
}

- (instancetype)easeInOutQuad {
    _animation.timingFunction = [CAMediaTimingFunction easeInOutQuad];
    return self;
}

- (instancetype)easeInCubic {
    _animation.timingFunction = [CAMediaTimingFunction easeInCubic];
    return self;
}

- (instancetype)easeOutCubic {
    _animation.timingFunction = [CAMediaTimingFunction easeOutCubic];
    return self;
}

- (instancetype)easeInOutCubic {
    _animation.timingFunction = [CAMediaTimingFunction easeInOutCubic];
    return self;
}

- (instancetype)easeInQuart {
    _animation.timingFunction = [CAMediaTimingFunction easeInQuart];
    return self;
}

- (instancetype)easeOutQuart {
    _animation.timingFunction = [CAMediaTimingFunction easeOutQuart];
    return self;
}

- (instancetype)easeInOutQuart {
    _animation.timingFunction = [CAMediaTimingFunction easeInOutQuart];
    return self;
}

- (instancetype)easeInQuint {
    _animation.timingFunction = [CAMediaTimingFunction easeInQuint];
    return self;
}

- (instancetype)easeOutQuint {
    _animation.timingFunction = [CAMediaTimingFunction easeOutQuint];
    return self;
}

- (instancetype)easeInOutQuint {
    _animation.timingFunction = [CAMediaTimingFunction easeInOutQuint];
    return self;
}

- (instancetype)easeInExpo {
    _animation.timingFunction = [CAMediaTimingFunction easeInExpo];
    return self;
}

- (instancetype)easeOutExpo {
    _animation.timingFunction = [CAMediaTimingFunction easeOutExpo];
    return self;
}

- (instancetype)easeInOutExpo {
    _animation.timingFunction = [CAMediaTimingFunction easeInOutExpo];
    return self;
}

- (instancetype)easeInCirc {
    _animation.timingFunction = [CAMediaTimingFunction easeInCirc];
    return self;
}

- (instancetype)easeOutCirc {
    _animation.timingFunction = [CAMediaTimingFunction easeOutCirc];
    return self;
}

- (instancetype)easeInOutCirc {
    _animation.timingFunction = [CAMediaTimingFunction easeInOutCirc];
    return self;
}

- (instancetype)easeInBack {
    _animation.timingFunction = [CAMediaTimingFunction easeInBack];
    return self;
}

- (instancetype)easeOutBack {
    _animation.timingFunction = [CAMediaTimingFunction easeOutBack];
    return self;
}

- (instancetype)easeInOutBack {
    _animation.timingFunction = [CAMediaTimingFunction easeInOutBack];
    return self;
}

#pragma mark - Private.
- (void)_setCombinedAnimators:(NSArray<AXChainAnimator *> *)combinedAnimators {
    _combinedAnimators = [combinedAnimators copy];
}

- (void)_setAnimation:(CAAnimation *)animation {
    if (_animation == animation) return;
    _animation = [animation copy];
    // Set delegate to SELF.
    if (_animation.delegate != self) _animation.delegate = self;
}

- (CAAnimation *)_defaultAnimation {
    CAAnimation *animation = [CAAnimation animation];
    animation.removedOnCompletion = NO;
    return animation;
}

- (nonnull CAAnimation *)_animationGroups {
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeBoth;
    group.animations = @[_animation];
    // Calculate the animation duration of animation.
    NSTimeInterval _duration = [self _animationDurationForAnimation:_animation];
    group.duration = _duration;
    
    [self _animationGroupsForCombinedWithGroup:&group];
    [self _animationGroupsForNextToWithGroup:&group];
    
    return group;
}

- (void)_animationGroupsForCombinedWithGroup:(CAAnimationGroup **)group {
    NSMutableArray *animations = [(*group).animations mutableCopy];
    NSTimeInterval duration = (*group).duration;
    
    for (AXChainAnimator *animator in _combinedAnimators) {
        CAAnimation *animation = [animator animation];
        [animations addObject:animation];
        // Fixs the spring animation of duration.
        if ([animation isMemberOfClass:CASpringAnimation.class]) {
            CASpringAnimation *springAnimation = (CASpringAnimation *)animation;
            if (springAnimation.duration) {
                springAnimation.duration = MIN(springAnimation.duration, springAnimation.settlingDuration);
            } else {
                springAnimation.duration = springAnimation.settlingDuration;
            }
        }
        // Calculate the animation duration of animation.
        NSTimeInterval _duration = [self _animationDurationForAnimation:animation];
        duration = MAX(duration, _duration);
        if (animator.combinedAnimators) {
            [(*group) setAnimations:animations];
            (*group).duration = duration;
            [animator _animationGroupsForCombinedWithGroup:group];
            animations = [(*group).animations mutableCopy];
            duration = (*group).duration;
        } else if (animator.childAnimator) {
            [(*group) setAnimations:animations];
            (*group).duration = duration;
            [animator _animationGroupsForNextToWithGroup:group];
            animations = [(*group).animations mutableCopy];
            duration = (*group).duration;
        }
    }
    
    [(*group) setAnimations:animations];
    (*group).duration = duration;
}

- (void)_animationGroupsForNextToWithGroup:(CAAnimationGroup **)group {
    AXChainAnimator *animator = self.childAnimator;
    while (animator) {
        CAAnimation *nextAnimation = [animator animation];
        // Fixs the spring animation of duration.
        if ([nextAnimation isMemberOfClass:CASpringAnimation.class]) {
            CASpringAnimation *springAnimation = (CASpringAnimation *)nextAnimation;
            if (springAnimation.duration) {
                springAnimation.duration = MIN(springAnimation.duration, springAnimation.settlingDuration);
            } else {
                springAnimation.duration = springAnimation.settlingDuration;
            }
        }
        nextAnimation.beginTime += (*group).duration;
        (*group).duration += [self _animationDurationForAnimation:nextAnimation] + nextAnimation.beginTime;
        NSMutableArray *animations = [[(*group) animations] mutableCopy];
        [animations addObject:nextAnimation];
        (*group).animations = animations;
        animator = animator.childAnimator;
    }
}

- (NSTimeInterval)_animationDurationForAnimation:(CAAnimation *)animation {
    NSTimeInterval _duration;
    NSTimeInterval animationDuration = animation.duration;
    if (animation.repeatCount && animation.repeatDuration) {
        _duration = MIN(animationDuration/(animation.speed?:1)*animation.repeatCount, animation.repeatDuration/(animation.speed?:1))*(animation.autoreverses?2:1)+animation.beginTime;
    } else if (_animation.repeatCount) {
        _duration = animationDuration/(animation.speed?:1)*animation.repeatCount*(animation.autoreverses?2:1)+animation.beginTime;
    } else if (_animation.repeatDuration) {
        _duration = animation.repeatDuration/(animation.speed?:1)*(animation.autoreverses?2:1)+animation.beginTime;
    } else {
        _duration = animationDuration/(animation.speed?:1)*(animation.autoreverses?2:1)+animation.beginTime;
    }
    return _duration;
}

- (void)_clear {
    if (self.superAnimator) [self.superAnimator _clear]; else {
        self.childAnimator = nil;
        _combinedAnimators = nil;
        [self _setAnimation:[self _defaultAnimation]];
    }
}
@end

@implementation AXBasicChainAnimator
@dynamic animation;
#pragma mark - Override.
- (instancetype)beginWith:(AXChainAnimator *)animator {
    if ([animator isKindOfClass:self.class] && ![animator isKindOfClass:AXSpringChainAnimator.class]) return self;
    return [super beginWith:animator];
}
#pragma mark - Getters.
- (CABasicAnimation *)animation {
    return (CABasicAnimation *)[super animation];
}

#pragma mark - PropertyHandler.
- (instancetype)property:(NSString *)property {
    NSAssert([self.animation isKindOfClass:[CAPropertyAnimation class]], @"Cannot set property: %@ to animation because animation object is not subclass of CAPropertyAnimation", property);
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^\\s+$" options:0 error:NULL];
    NSAssert(property.length != 0 && [regex matchesInString:property options:0 range:NSMakeRange(0, property.length)].count == 0, @"Property to be animated can not be null");
    [self.animation setValue:property forKeyPath:@"keyPath"];
    return self;
}

- (id<AXBasicChainAnimatorDelegate>)fromValue:(id)fromValue {
    if (![self.animation respondsToSelector:@selector(setFromValue:)]) return self;
    if (self.animation.byValue && self.animation.toValue) return self;
    self.animation.fromValue = fromValue;
    return self;
}

- (id<AXBasicChainAnimatorDelegate>)byValue:(id)byValue {
    if (![self.animation respondsToSelector:@selector(setByValue:)]) return self;
    if (self.animation.fromValue && self.animation.toValue) return self;
    self.animation.byValue = byValue;
    return self;
}

- (id<AXBasicChainAnimatorDelegate>)toValue:(id)toValue {
    if (![self.animation respondsToSelector:@selector(setToValue:)]) return self;
    if (self.animation.fromValue && self.animation.byValue) return self;
    self.animation.toValue = toValue;
    return self;
}

- (AXKeyframeChainAnimator *)easeInElastic {
    AXKeyframeChainAnimator *keyframe = self._keyframeAnimator;
    [keyframe _setAnimation:[CAKeyframeAnimation animationWithBasic:(CABasicAnimation *)self.animation usingValuesFunction:[CAMediaTimingFunction easeInElasticValuesFuntion]]];
    [self _relinkAnimatorsWithAnimatorToReplace:keyframe];
    return keyframe;
}

- (AXKeyframeChainAnimator *)easeOutElastic {
    AXKeyframeChainAnimator *keyframe = self._keyframeAnimator;
    [keyframe _setAnimation:[CAKeyframeAnimation animationWithBasic:(CABasicAnimation *)self.animation usingValuesFunction:[CAMediaTimingFunction easeOutElasticValuesFuntion]]];
    [self _relinkAnimatorsWithAnimatorToReplace:keyframe];
    return keyframe;
}

- (AXKeyframeChainAnimator *)easeInOutElastic {
    AXKeyframeChainAnimator *keyframe = self._keyframeAnimator;
    [keyframe _setAnimation:[CAKeyframeAnimation animationWithBasic:(CABasicAnimation *)self.animation usingValuesFunction:[CAMediaTimingFunction easeInOutElasticValuesFuntion]]];
    [self _relinkAnimatorsWithAnimatorToReplace:keyframe];
    return keyframe;
}

- (AXKeyframeChainAnimator *)easeInBounce {
    AXKeyframeChainAnimator *keyframe = self._keyframeAnimator;
    [keyframe _setAnimation:[CAKeyframeAnimation animationWithBasic:(CABasicAnimation *)self.animation usingValuesFunction:[CAMediaTimingFunction easeInBounceValuesFuntion]]];
    [self _relinkAnimatorsWithAnimatorToReplace:keyframe];
    return keyframe;
}

- (AXKeyframeChainAnimator *)easeOutBounce {
    AXKeyframeChainAnimator *keyframe = self._keyframeAnimator;
    [keyframe _setAnimation:[CAKeyframeAnimation animationWithBasic:(CABasicAnimation *)self.animation usingValuesFunction:[CAMediaTimingFunction easeOutBounceValuesFuntion]]];
    [self _relinkAnimatorsWithAnimatorToReplace:keyframe];
    return keyframe;
}

- (AXKeyframeChainAnimator *)easeInOutBounce {
    AXKeyframeChainAnimator *keyframe = self._keyframeAnimator;
    [keyframe _setAnimation:[CAKeyframeAnimation animationWithBasic:(CABasicAnimation *)self.animation usingValuesFunction:[CAMediaTimingFunction easeInOutElasticValuesFuntion]]];
    [self _relinkAnimatorsWithAnimatorToReplace:keyframe];
    return keyframe;
}

- (AXKeyframeChainAnimator *)gravity {
    AXKeyframeChainAnimator *keyframe = self._keyframeAnimator;
    [keyframe _setAnimation:[CAKeyframeAnimation animationWithBasic:(CABasicAnimation *)self.animation usingValuesFunction:[CAMediaTimingFunction gravity]]];
    [keyframe setTimingFunctionFlags:kAXKeyframeTimgingFunctionFlagGravity];
    [self _relinkAnimatorsWithAnimatorToReplace:keyframe];
    return keyframe;
}

#pragma mark - Private.
- (void)_relinkAnimatorsWithAnimatorToReplace:(id<AXChainAnimatorDelegate>)animator {
    // Replace SELF in the super animator.
    if (self.superAnimator.childAnimator == self) {
        self.superAnimator.childAnimator = nil;
        [self.superAnimator nextTo:animator];
    } else if ([self.superAnimator.combinedAnimators containsObject:self]) {
        // Remove SELF from the super animator.
        NSMutableArray *combinedAnimators = [self.superAnimator.combinedAnimators mutableCopy];
        [combinedAnimators removeObject:self];
        [(AXChainAnimator *)self.superAnimator _setCombinedAnimators:[combinedAnimators copy]];
        
        // Combine new animator to the super animator.
        [self.superAnimator combineWith:animator];
    }
}
@end

@implementation AXKeyframeChainAnimator
@dynamic animation;
#pragma mark - Override.
- (instancetype)beginWith:(AXChainAnimator *)animator {
    if ([animator isKindOfClass:self.class]) return self;
    return [super beginWith:animator];
}
#pragma mark - Getters.
- (CAKeyframeAnimation *)animation {
    return (CAKeyframeAnimation *)[super animation];
}

#pragma mark - PropertiesHandler.
- (instancetype)property:(NSString *)property {
    NSAssert([self.animation isKindOfClass:[CAPropertyAnimation class]], @"Cannot set property: %@ to animation because animation object is not subclass of CAPropertyAnimation", property);
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^\\s+$" options:0 error:NULL];
    NSAssert(property.length != 0 && [regex matchesInString:property options:0 range:NSMakeRange(0, property.length)].count == 0, @"Property to be animated can not be null");
    [self.animation setValue:property forKeyPath:@"keyPath"];
    return self;
}

- (instancetype)values:(nullable NSArray<id> *)values {
    if (![self.animation respondsToSelector:@selector(setValues:)]) return self;
    self.animation.values = values;
    return self;
}

- (instancetype)path:(nullable UIBezierPath *)path {
    if (![self.animation respondsToSelector:@selector(setPath:)]) return self;
    self.animation.path = path.CGPath;
    return self;
}

- (instancetype)keyTimes:(nullable NSArray<NSNumber *> *)keyTimes {
    if (![self.animation respondsToSelector:@selector(setKeyTimes:)]) return self;
    self.animation.keyTimes = keyTimes;
    return self;
}

- (instancetype)timingFunctions:(nullable NSArray<CAMediaTimingFunction *> *)timingFunctions {
    if (![self.animation respondsToSelector:@selector(setTimingFunction:)]) return self;
    self.animation.timingFunctions = timingFunctions;
    return self;
}

- (instancetype)calculationMode:(NSString *)calculationMode {
    if (![self.animation respondsToSelector:@selector(setCalculationMode:)]) return self;
    self.animation.calculationMode = calculationMode;
    return self;
}

- (instancetype)tensionValues:(nullable NSArray<NSNumber *> *)tensionValues {
    if (![self.animation respondsToSelector:@selector(setTensionValues:)]) return self;
    self.animation.tensionValues = tensionValues;
    return self;
}

- (instancetype)continuityValues:(nullable NSArray<NSNumber *> *)continuityValues {
    if (![self.animation respondsToSelector:@selector(setContinuityValues:)]) return self;
    self.animation.continuityValues = continuityValues;
    return self;
}

- (instancetype)biasValues:(nullable NSArray<NSNumber *> *)biasValues {
    if (![self.animation respondsToSelector:@selector(setBiasValues:)]) return self;
    self.animation.biasValues = biasValues;
    return self;
}

- (instancetype)rotationMode:(nullable NSString *)rotationMode {
    if (![self.animation respondsToSelector:@selector(setRotationMode:)]) return self;
    self.animation.rotationMode = rotationMode;
    return self;
}
@end

@implementation AXSpringChainAnimator
@dynamic animation;
#pragma mark - Override.
- (instancetype)beginWith:(AXChainAnimator *)animator {
    if ([animator isKindOfClass:self.class]) return self;
    return [super beginWith:animator];
}
#pragma mark - Getters.
- (CASpringAnimation *)animation {
    return (CASpringAnimation *)[super animation];
}

#pragma mark - PropertiesHandler.
- (instancetype)mass:(CGFloat)mass {
    if (![self.animation respondsToSelector:@selector(setMass:)]) return self;
    self.animation.mass = mass;
    return self;
}

- (instancetype)stiffness:(CGFloat)stiffness {
    if (![self.animation respondsToSelector:@selector(setStiffness:)]) return self;
    self.animation.stiffness = stiffness;
    return self;
}

- (instancetype)damping:(CGFloat)damping {
    if (![self.animation respondsToSelector:@selector(setDamping:)]) return self;
    self.animation.damping = damping;
    return self;
}

- (instancetype)initialVelocity:(CGFloat)initialVelocity {
    if (![self.animation respondsToSelector:@selector(setInitialVelocity:)]) return self;
    self.animation.initialVelocity = initialVelocity;
    return self;
}
@end

@implementation AXTransitionChainAnimator
@dynamic animation;
#pragma mark - Override.
- (instancetype)beginWith:(AXChainAnimator *)animator {
    if ([animator isKindOfClass:self.class]) return self;
    return [super beginWith:animator];
}
#pragma mark - Getters.
- (CATransition *)animation {
    return (CATransition *)[super animation];
}

#pragma mark - PropertiesHandler.
- (instancetype)type:(NSString *)type {
    if (![self.animation respondsToSelector:@selector(setType:)]) return self;
    self.animation.type = type;
    return self;
}

- (instancetype)subtype:(NSString *)subtype {
    if (![self.animation respondsToSelector:@selector(setSubtype:)]) return self;
    self.animation.subtype = subtype;
    return self;
}

- (instancetype)startProgress:(CGFloat)startProgress {
    if (![self.animation respondsToSelector:@selector(setStartProgress:)]) return self;
    self.animation.startProgress = startProgress;
    return self;
}

- (instancetype)endProgress:(CGFloat)endProgress {
    if (![self.animation respondsToSelector:@selector(setEndProgress:)]) return self;
    self.animation.endProgress = endProgress;
    return self;
}

- (instancetype)filter:(id)filter {
    if (![self.animation respondsToSelector:@selector(setFilter:)]) return self;
    self.animation.filter = filter;
    return self;
}
@end
NS_ASSUME_NONNULL_END
