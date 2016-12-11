//
//  AXAnimationChainAnimator+Block.h
//  AXAnimationChain
//
//  Created by devedbox on 2016/12/11.
//  Copyright © 2016年 devedbox. All rights reserved.
//

#import "AXAnimationChain.h"

@interface AXAnimationChainAnimator (Block)
/// Begin with block reachable.
- (AXAnimationChainAnimator * (^)(AXAnimationChainAnimator *animator))beginWith;
/// Next to block reachable.
- (AXAnimationChainAnimator * (^)(AXAnimationChainAnimator *animator))nextTo;
/// Combine with block reachable.
- (AXAnimationChainAnimator * (^)(AXAnimationChainAnimator *animator))combineWith;
/// Begin time block reachable.
- (AXAnimationChainAnimator * (^)(NSTimeInterval beginTime))beginTime;
/// Duration block reachable.
- (AXAnimationChainAnimator * (^)(NSTimeInterval duration))duration;
/// Speed block reachable.
- (AXAnimationChainAnimator * (^)(CGFloat speed))speed;
/// TimeOffset block reachable.
- (AXAnimationChainAnimator * (^)(NSTimeInterval timeOffset))timeOffset;
/// RepeatCount block reachable.
- (AXAnimationChainAnimator * (^)(CGFloat repeatCount))repeatCount;
/// RepeatDuration block reachable.
- (AXAnimationChainAnimator * (^)(NSTimeInterval repeatDuration))repeatDuration;
/// FillMode block reachable.
- (AXAnimationChainAnimator * (^)(NSString *fillMode))fillMode;
/// Property block reachable.
- (AXAnimationChainAnimator * (^)(NSString *property))property;
/// Start block reachable. Same as call the method `-start`
- (dispatch_block_t)animate;
@end

@interface AXBasicAnimator (Block)
/// Begin with block reachable.
- (AXBasicAnimator * (^)(AXBasicAnimator *animator))beginWith;
/// Next to block reachable.
- (AXBasicAnimator * (^)(AXBasicAnimator *animator))nextTo;
/// Combine with block reachable.
- (AXBasicAnimator * (^)(AXBasicAnimator *animator))combineWith;
/// Begin time block reachable.
- (AXBasicAnimator * (^)(NSTimeInterval beginTime))beginTime;
/// Duration block reachable.
- (AXBasicAnimator * (^)(NSTimeInterval duration))duration;
/// Speed block reachable.
- (AXBasicAnimator * (^)(CGFloat speed))speed;
/// TimeOffset block reachable.
- (AXBasicAnimator * (^)(NSTimeInterval timeOffset))timeOffset;
/// RepeatCount block reachable.
- (AXBasicAnimator * (^)(CGFloat repeatCount))repeatCount;
/// RepeatDuration block reachable.
- (AXBasicAnimator * (^)(NSTimeInterval repeatDuration))repeatDuration;
/// FillMode block reachable.
- (AXBasicAnimator * (^)(NSString *fillMode))fillMode;
/// Property block reachable.
- (AXBasicAnimator * (^)(NSString *property))property;
/// FromValue block reachable.
- (AXBasicAnimator * (^)(id fromValue))fromValue;
/// ToValue block reachable.
- (AXBasicAnimator * (^)(id toValue))toValue;
/// ByValue block reachable.
- (AXBasicAnimator * (^)(id byValue))byValue;
@end
