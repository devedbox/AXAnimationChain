//
//  AXAnimationChain.m
//  AXAnimationChain
//
//  Created by devedbox on 2016/12/10.
//  Copyright © 2016年 devedbox. All rights reserved.
//

#import "AXAnimationChain.h"
#import "AXAnimationChainAnimator+Block.h"
NS_ASSUME_NONNULL_BEGIN
@interface AXAnimationChainAnimator ()
{
    @protected
    /// Is animations in traansaction.
    BOOL _inTransaction;
}
/// Father animator.
@property(weak,   nonatomic, nullable) AXAnimationChainAnimator *fatherAnimator;
/// Next to animator.
@property(strong, nonatomic, nullable) AXAnimationChainAnimator *nextToAnimator;
/// Combined animators.
@property(strong, nonatomic, nullable) NSArray<AXAnimationChainAnimator *> *combinedAnimators;
/// Set animation object to the animator.
- (void)_setAnimation:(CAAnimation *)animation;
@end

@implementation AXAnimationChainAnimator
@synthesize animation = _animation;
+ (instancetype)animatorWithAnimation:(CAAnimation *)animation {
    id obj = [[self.class alloc] init];
    NSAssert([obj respondsToSelector:@selector(_setAnimation:)], @"Object cannot be created.");
    [obj performSelector:@selector(_setAnimation:) withObject:animation];
    return obj;
}

#pragma mark - ChainHandler.
- (nullable instancetype)beginWith:(nonnull AXAnimationChainAnimator *)animator {
    [self _setAnimation:animator.animation];
    return self;
}

- (nullable instancetype)nextTo:(nonnull AXAnimationChainAnimator *)animator {
    AXAnimationChainAnimator *fatherAnimator = animator.fatherAnimator?:animator;
    AXAnimationChainAnimator *superFatherAnimator = fatherAnimator;
    while (fatherAnimator) {
        fatherAnimator = fatherAnimator.fatherAnimator;
        if (fatherAnimator) {
            superFatherAnimator = fatherAnimator;
            if (fatherAnimator == self) {
                return animator;
            }
        }
    }
    _nextToAnimator = superFatherAnimator;
    _nextToAnimator.fatherAnimator = self;
    return _nextToAnimator;
}

- (nullable instancetype)combineWith:(nonnull AXAnimationChainAnimator *)animator {
    NSMutableArray *animators = [_combinedAnimators mutableCopy];
    if (!animators) animators = [NSMutableArray array];
    AXAnimationChainAnimator *fatherAnimator = animator.fatherAnimator?:animator;
    AXAnimationChainAnimator *superFatherAnimator = fatherAnimator;
    while (fatherAnimator) {
        fatherAnimator = fatherAnimator.fatherAnimator;
        if (fatherAnimator) {
            superFatherAnimator = fatherAnimator;
        }
    }
    [animators addObject:superFatherAnimator];
    animator.fatherAnimator = self;
    _combinedAnimators = [NSSet setWithArray:animators].allObjects;
    return animator;
}

#pragma mark - Getters.
- (AXBasicAnimator *)basic {
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    AXBasicAnimator *basic = [AXBasicAnimator animatorWithAnimation:animation];
    basic.animatedView = _animatedView;
    return basic;
}

- (AXKeyframeAnimator *)keyframe {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    AXKeyframeAnimator *keyframe = [AXKeyframeAnimator animatorWithAnimation:animation];
    keyframe.animatedView = _animatedView;
    return keyframe;
}

- (AXSpringAnimator *)spring {
    CASpringAnimation *animation = [CASpringAnimation animation];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    AXSpringAnimator *spring = [AXSpringAnimator animatorWithAnimation:animation];
    spring.animatedView = _animatedView;
    return spring;
}
#pragma mark - AXAnimationChainDelegate.
- (void)start {
    NSAssert(_animatedView, @"Animation chain cannot be created because animated view is null.");
    AXAnimationChainAnimator *father = _fatherAnimator;
    AXAnimationChainAnimator *superFather = _fatherAnimator;
    while (father) {
        father = father.fatherAnimator;
        if (father) {
            superFather = father;
        }
    }
    if (superFather) {
        [superFather start];
    } else {
        if (_inTransaction) return;
        [CATransaction begin];
        _inTransaction = YES;
        [CATransaction setDisableActions:YES];
        [CATransaction setCompletionBlock:^{
            NSLog(@"%s", __FUNCTION__);
            _inTransaction = NO;
        }];
        CAAnimation *animation = [self _animationGroups];
        [_animatedView.layer addAnimation:animation forKey:[NSString stringWithFormat:@"%p", self]];
        
        [CATransaction commit];
    }
}

- (nullable instancetype)property:(NSString *)property {
    NSAssert([_animation isKindOfClass:[CAPropertyAnimation class]], @"Cannot set property: %@ to animation because animation object is not subclass of CAPropertyAnimation", property);
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^\\s+$" options:0 error:NULL];
    NSAssert(property.length != 0 && [regex matchesInString:property options:0 range:NSMakeRange(0, property.length)].count == 0, @"Property to be animated can not be null");
    [_animation setValue:property forKeyPath:@"keyPath"];
    return self;
}

- (nullable instancetype)beginTime:(NSTimeInterval)beginTime {
    _animation.beginTime = beginTime;
    return self;
}

- (nullable instancetype)duration:(NSTimeInterval)duration {
    _animation.duration = duration;
    return self;
}

- (nullable instancetype)speed:(CGFloat)speed {
    _animation.speed = speed;
    return self;
}

- (nullable instancetype)timeOffset:(NSTimeInterval)timeOffset {
    _animation.timeOffset = timeOffset;
    return self;
}

- (nullable instancetype)repeatCount:(CGFloat)repeatCount {
    _animation.repeatCount = repeatCount;
    return self;
}

- (nullable instancetype)repeatDuration:(NSTimeInterval)repeatDuration {
    _animation.repeatDuration = repeatDuration;
    return self;
}

- (nullable instancetype)autoreverses {
    _animation.autoreverses = YES;
    return self;
}

- (nullable instancetype)fillMode:(NSString *)fillMode {
    _animation.fillMode = [fillMode copy];
    return self;
}

- (nullable instancetype)linear {
    _animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    return self;
}

- (nullable instancetype)easeIn {
    _animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    return self;
}

- (nullable instancetype)easeOut {
    _animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    return self;
}

- (nullable instancetype)easeInOut {
    _animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return self;
}

#pragma mark - BlockReachable.
- (AXAnimationChainAnimator *(^)(AXAnimationChainAnimator *))beginWith {
    return ^AXAnimationChainAnimator* (AXAnimationChainAnimator *animator) {
        return [self beginWith:animator];
    };
}

- (AXAnimationChainAnimator *(^)(AXAnimationChainAnimator *))nextTo {
    return ^AXAnimationChainAnimator* (AXAnimationChainAnimator *animator) {
        return [self nextTo:animator];
    };
}

- (AXAnimationChainAnimator *(^)(AXAnimationChainAnimator *))combineWith {
    return ^AXAnimationChainAnimator* (AXAnimationChainAnimator *animator) {
        return [self combineWith:animator];
    };
}

- (AXAnimationChainAnimator *(^)(NSTimeInterval))beginTime {
    return ^AXAnimationChainAnimator* (NSTimeInterval beginTime) {
        return [self beginTime:beginTime];
    };
}

- (AXAnimationChainAnimator *(^)(NSTimeInterval))duration {
    return ^AXAnimationChainAnimator* (NSTimeInterval duration) {
        return [self duration:duration];
    };
}

- (AXAnimationChainAnimator *(^)(CGFloat))speed {
    return ^AXAnimationChainAnimator* (CGFloat speed) {
        return [self speed:speed];
    };
}

- (AXAnimationChainAnimator *(^)(NSTimeInterval))timeOffset {
    return ^AXAnimationChainAnimator* (NSTimeInterval timeOffset) {
        return [self timeOffset:timeOffset];
    };
}

- (AXAnimationChainAnimator *(^)(CGFloat))repeatCount {
    return ^AXAnimationChainAnimator* (CGFloat repeatCount) {
        return [self repeatCount:repeatCount];
    };
}

- (AXAnimationChainAnimator *(^)(NSTimeInterval))repeatDuration {
    return ^AXAnimationChainAnimator* (NSTimeInterval repeatDuration) {
        return [self repeatDuration:repeatDuration];
    };
}

- (AXAnimationChainAnimator *(^)(NSString *))fillMode {
    return ^AXAnimationChainAnimator* (NSString *fillMode) {
        return [self fillMode:fillMode];
    };
}

- (AXAnimationChainAnimator *(^)(NSString *))property {
    return ^AXAnimationChainAnimator* (NSString *property) {
        return [self property:property];
    };
}

- (dispatch_block_t)animate {
    return ^() {
        [self start];
    };
}
#pragma mark - Private.
- (void)_setAnimation:(CAAnimation *)animation {
    if (_animation == animation) return;
    _animation = [animation copy];
}

- (nonnull CAAnimation *)_animationGroups {
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.removedOnCompletion = _animation.removedOnCompletion;
    group.fillMode = _animation.fillMode;
    group.timingFunction = _animation.timingFunction;
    group.animations = @[_animation];
    group.duration = _animation.duration;
    
    [self _animationGroupsForCombinedWithGroup:&group];
    [self _animationGroupsForNextToWithGroup:&group];
    
    return group;
}

- (void)_animationGroupsForCombinedWithGroup:(CAAnimationGroup **)group {
    NSMutableArray *animations = [(*group).animations mutableCopy];
    NSTimeInterval duration = (*group).duration;
    
    for (AXAnimationChainAnimator *animator in _combinedAnimators) {
        CAAnimation *animation = [animator animation];
        [animations addObject:animation];
        duration = MAX(duration, animation.duration);
        if (animator.combinedAnimators) {
            [(*group) setAnimations:animations];
            (*group).duration = duration;
            [animator _animationGroupsForCombinedWithGroup:group];
            animations = [(*group).animations mutableCopy];
            duration = (*group).duration;
        } else if (animator.nextToAnimator) {
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
    AXAnimationChainAnimator *animator = self.nextToAnimator;
    while (animator) {
        CAAnimation *nextAnimation = [animator animation];
        nextAnimation.beginTime += (*group).duration;
        (*group).duration += nextAnimation.duration;
        NSMutableArray *animations = [[(*group) animations] mutableCopy];
        [animations addObject:nextAnimation];
        (*group).animations = animations;
        animator = animator.nextToAnimator;
    }
}
@end

@implementation AXBasicAnimator
@dynamic animation;
#pragma mark - Override.

#pragma mark - Getters.
- (CABasicAnimation *)animation {
    return (CABasicAnimation *)[super animation];
}

#pragma mark - PropertyHandler.
- (nullable id<AXBasicAnimationDelegate>)fromValue:(id)fromValue {
    if (self.animation.byValue && self.animation.toValue) return nil;
    self.animation.fromValue = fromValue;
    return self;
}

- (nullable id<AXBasicAnimationDelegate>)byValue:(id)byValue {
    if (self.animation.fromValue && self.animation.toValue) return nil;
    self.animation.byValue = byValue;
    return self;
}

- (nullable id<AXBasicAnimationDelegate>)toValue:(id)toValue {
    if (self.animation.fromValue && self.animation.byValue) return nil;
    self.animation.toValue = toValue;
    return self;
}

#pragma mark - BlockReachable.
- (AXBasicAnimator *(^)(AXBasicAnimator *))beginWith {
    return ^AXBasicAnimator* (AXBasicAnimator *animator) {
        return [self beginWith:animator];
    };
}

- (AXBasicAnimator *(^)(AXBasicAnimator *))nextTo {
    return ^AXBasicAnimator* (AXBasicAnimator *animator) {
        return [self nextTo:animator];
    };
}

- (AXBasicAnimator *(^)(AXBasicAnimator *))combineWith {
    return ^AXBasicAnimator* (AXBasicAnimator *animator) {
        return [self combineWith:animator];
    };
}

- (AXBasicAnimator *(^)(NSTimeInterval))beginTime {
    return ^AXBasicAnimator* (NSTimeInterval beginTime) {
        return [self beginTime:beginTime];
    };
}

- (AXBasicAnimator *(^)(NSTimeInterval))duration {
    return ^AXBasicAnimator* (NSTimeInterval duration) {
        return [self duration:duration];
    };
}

- (AXBasicAnimator *(^)(CGFloat))speed {
    return ^AXBasicAnimator* (CGFloat speed) {
        return [self speed:speed];
    };
}

- (AXBasicAnimator *(^)(NSTimeInterval))timeOffset {
    return ^AXBasicAnimator* (NSTimeInterval timeOffset) {
        return [self timeOffset:timeOffset];
    };
}

- (AXBasicAnimator *(^)(CGFloat))repeatCount {
    return ^AXBasicAnimator* (CGFloat repeatCount) {
        return [self repeatCount:repeatCount];
    };
}

- (AXBasicAnimator *(^)(NSTimeInterval))repeatDuration {
    return ^AXBasicAnimator* (NSTimeInterval repeatDuration) {
        return [self repeatDuration:repeatDuration];
    };
}

- (AXBasicAnimator *(^)(NSString *))fillMode {
    return ^AXBasicAnimator* (NSString *fillMode) {
        return [self fillMode:fillMode];
    };
}

- (AXBasicAnimator *(^)(NSString *))property {
    return ^AXBasicAnimator* (NSString *property) {
        return [self property:property];
    };
}

- (AXBasicAnimator *(^)(id))fromValue {
    return ^AXBasicAnimator* (id fromValue) {
        return [self fromValue:fromValue];
    };
}

- (AXBasicAnimator *(^)(id))toValue {
    return ^AXBasicAnimator* (id toValue) {
        return [self toValue:toValue];
    };
}

- (AXBasicAnimator *(^)(id))byValue {
    return ^AXBasicAnimator* (id byValue) {
        return [self byValue:byValue];
    };
}
@end

@implementation AXKeyframeAnimator
@dynamic animation;
#pragma mark - Getters.
- (CAKeyframeAnimation *)animation {
    return (CAKeyframeAnimation *)[super animation];
}
@end

@implementation AXSpringAnimator
@dynamic animation;
#pragma mark - Getters.
- (CASpringAnimation *)animation {
    return (CASpringAnimation *)[super animation];
}
@end
NS_ASSUME_NONNULL_END
