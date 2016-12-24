//
//  AXChainAnimator+Block.h
//  AXAnimationChain
//
//  Created by devedbox on 2016/12/11.
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

@interface AXChainAnimator (Block)
/// Begin with block reachable.
- (AXChainAnimator * (^)(AXChainAnimator *animator))beginWith;
/// Next to block reachable.
- (AXChainAnimator * (^)(AXChainAnimator *animator))nextTo;
/// Combine with block reachable.
- (AXChainAnimator * (^)(AXChainAnimator *animator))combineWith;
/// Begin time block reachable.
- (AXChainAnimator * (^)(NSTimeInterval beginTime))beginTime;
/// Duration block reachable.
- (AXChainAnimator * (^)(NSTimeInterval duration))duration;
/// Speed block reachable.
- (AXChainAnimator * (^)(CGFloat speed))speed;
/// TimeOffset block reachable.
- (AXChainAnimator * (^)(NSTimeInterval timeOffset))timeOffset;
/// RepeatCount block reachable.
- (AXChainAnimator * (^)(CGFloat repeatCount))repeatCount;
/// RepeatDuration block reachable.
- (AXChainAnimator * (^)(NSTimeInterval repeatDuration))repeatDuration;
/// FillMode block reachable.
- (AXChainAnimator * (^)(NSString *fillMode))fillMode;
/// Start block reachable. Same as call the method `-start`
- (dispatch_block_t)animate;
@end

@interface AXBasicChainAnimator (Block)
/// Begin with block reachable.
- (AXBasicChainAnimator * (^)(AXBasicChainAnimator *animator))beginWith;
/// Next to block reachable.
- (AXBasicChainAnimator * (^)(AXBasicChainAnimator *animator))nextTo;
/// Combine with block reachable.
- (AXBasicChainAnimator * (^)(AXBasicChainAnimator *animator))combineWith;
/// Begin time block reachable.
- (AXBasicChainAnimator * (^)(NSTimeInterval beginTime))beginTime;
/// Duration block reachable.
- (AXBasicChainAnimator * (^)(NSTimeInterval duration))duration;
/// Speed block reachable.
- (AXBasicChainAnimator * (^)(CGFloat speed))speed;
/// TimeOffset block reachable.
- (AXBasicChainAnimator * (^)(NSTimeInterval timeOffset))timeOffset;
/// RepeatCount block reachable.
- (AXBasicChainAnimator * (^)(CGFloat repeatCount))repeatCount;
/// RepeatDuration block reachable.
- (AXBasicChainAnimator * (^)(NSTimeInterval repeatDuration))repeatDuration;
/// FillMode block reachable.
- (AXBasicChainAnimator * (^)(NSString *fillMode))fillMode;
/// Property block reachable.
- (AXBasicChainAnimator * (^)(NSString *property))property;
/// FromValue block reachable.
- (AXBasicChainAnimator * (^)(id fromValue))fromValue;
/// ToValue block reachable.
- (AXBasicChainAnimator * (^)(id toValue))toValue;
/// ByValue block reachable.
- (AXBasicChainAnimator * (^)(id byValue))byValue;
@end

@interface AXKeyframeChainAnimator (Block)
/// Begin with block reachable.
- (AXKeyframeChainAnimator * (^)(AXKeyframeChainAnimator *animator))beginWith;
/// Next to block reachable.
- (AXKeyframeChainAnimator * (^)(AXKeyframeChainAnimator *animator))nextTo;
/// Combine with block reachable.
- (AXKeyframeChainAnimator * (^)(AXKeyframeChainAnimator *animator))combineWith;
/// Begin time block reachable.
- (AXKeyframeChainAnimator * (^)(NSTimeInterval beginTime))beginTime;
/// Duration block reachable.
- (AXKeyframeChainAnimator * (^)(NSTimeInterval duration))duration;
/// Speed block reachable.
- (AXKeyframeChainAnimator * (^)(CGFloat speed))speed;
/// TimeOffset block reachable.
- (AXKeyframeChainAnimator * (^)(NSTimeInterval timeOffset))timeOffset;
/// RepeatCount block reachable.
- (AXKeyframeChainAnimator * (^)(CGFloat repeatCount))repeatCount;
/// RepeatDuration block reachable.
- (AXKeyframeChainAnimator * (^)(NSTimeInterval repeatDuration))repeatDuration;
/// FillMode block reachable.
- (AXKeyframeChainAnimator * (^)(NSString *fillMode))fillMode;
/// Property block reachable.
- (AXKeyframeChainAnimator * (^)(NSString *property))property;
/// Values block reachable.
- (AXKeyframeChainAnimator * (^)(NSArray<id> *values))values;
/// Path block reachable.
- (AXKeyframeChainAnimator * (^)(UIBezierPath *path))path;
/// KeyTimes block reachable.
- (AXKeyframeChainAnimator * (^)(NSArray<NSNumber *> *keyTimes))keyTimes;
/// TimingFunctions block reachable.
- (AXKeyframeChainAnimator * (^)(NSArray<CAMediaTimingFunction *> *timingFunctions))timingFunctions;
/// CalculationMode block reachable.
- (AXKeyframeChainAnimator * (^)(NSString *calculationMode))calculationMode;
/// TensionValues block reachable.
- (AXKeyframeChainAnimator * (^)(NSArray<NSNumber *> *tensionValues))tensionValues;
/// ContinuityValues block reachable.
- (AXKeyframeChainAnimator * (^)(NSArray<NSNumber *> *continuityValues))continuityValues;
/// BiasValues block reachable.
- (AXKeyframeChainAnimator * (^)(NSArray<NSNumber *> *biasValues))biasValues;
/// RotationMode block reachable.
- (AXKeyframeChainAnimator * (^)(NSString *rotationMode))rotationMode;
@end

@interface AXSpringChainAnimator (Block)
/// Begin with block reachable.
- (AXSpringChainAnimator * (^)(AXSpringChainAnimator *animator))beginWith;
/// Next to block reachable.
- (AXSpringChainAnimator * (^)(AXSpringChainAnimator *animator))nextTo;
/// Combine with block reachable.
- (AXSpringChainAnimator * (^)(AXSpringChainAnimator *animator))combineWith;
/// Begin time block reachable.
- (AXSpringChainAnimator * (^)(NSTimeInterval beginTime))beginTime;
/// Duration block reachable.
- (AXSpringChainAnimator * (^)(NSTimeInterval duration))duration;
/// Speed block reachable.
- (AXSpringChainAnimator * (^)(CGFloat speed))speed;
/// TimeOffset block reachable.
- (AXSpringChainAnimator * (^)(NSTimeInterval timeOffset))timeOffset;
/// RepeatCount block reachable.
- (AXSpringChainAnimator * (^)(CGFloat repeatCount))repeatCount;
/// RepeatDuration block reachable.
- (AXSpringChainAnimator * (^)(NSTimeInterval repeatDuration))repeatDuration;
/// FillMode block reachable.
- (AXSpringChainAnimator * (^)(NSString *fillMode))fillMode;
/// Property block reachable.
- (AXSpringChainAnimator * (^)(NSString *property))property;
/// FromValue block reachable.
- (AXSpringChainAnimator * (^)(id fromValue))fromValue;
/// ToValue block reachable.
- (AXSpringChainAnimator * (^)(id toValue))toValue;
/// ByValue block reachable.
- (AXSpringChainAnimator * (^)(id byValue))byValue;
/// Mass block reachable.
- (AXSpringChainAnimator * (^)(CGFloat mass))mass;
/// Stiffness block reachable.
- (AXSpringChainAnimator * (^)(CGFloat stiffness))stiffness;
/// Damping block reachable.
- (AXSpringChainAnimator * (^)(CGFloat damping))damping;
/// InitialVelocity block reachable.
- (AXSpringChainAnimator * (^)(CGFloat initialVelocity))initialVelocity;
@end

@interface AXTransitionChainAnimator (Block)
/// Begin with block reachable.
- (AXTransitionChainAnimator * (^)(AXTransitionChainAnimator *animator))beginWith;
/// Next to block reachable.
- (AXTransitionChainAnimator * (^)(AXTransitionChainAnimator *animator))nextTo;
/// Combine with block reachable.
- (AXTransitionChainAnimator * (^)(AXTransitionChainAnimator *animator))combineWith;
/// Begin time block reachable.
- (AXTransitionChainAnimator * (^)(NSTimeInterval beginTime))beginTime;
/// Duration block reachable.
- (AXTransitionChainAnimator * (^)(NSTimeInterval duration))duration;
/// Speed block reachable.
- (AXTransitionChainAnimator * (^)(CGFloat speed))speed;
/// TimeOffset block reachable.
- (AXTransitionChainAnimator * (^)(NSTimeInterval timeOffset))timeOffset;
/// RepeatCount block reachable.
- (AXTransitionChainAnimator * (^)(CGFloat repeatCount))repeatCount;
/// RepeatDuration block reachable.
- (AXTransitionChainAnimator * (^)(NSTimeInterval repeatDuration))repeatDuration;
/// FillMode block reachable.
- (AXTransitionChainAnimator * (^)(NSString *fillMode))fillMode;
/// Type block reachable.
- (AXTransitionChainAnimator * (^)(NSString *type))type;
/// Subtype block reachable.
- (AXTransitionChainAnimator * (^)(NSString *subtype))subtype;
/// StartProgress block reachable.
- (AXTransitionChainAnimator * (^)(CGFloat startProgress))startProgress;
/// EndProgress block reachable.
- (AXTransitionChainAnimator * (^)(CGFloat endProgress))endProgress;
/// Filter block reachable.
- (AXTransitionChainAnimator * (^)(id filter))filter;
@end
