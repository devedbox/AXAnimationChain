//
//  AXChainAnimator+Block.m
//  AXAnimationChain
//
//  Created by devedbox on 2017/1/15.
//  Copyright © 2017年 devedbox. All rights reserved.
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

#import "AXChainAnimator+Block.h"

@implementation AXChainAnimator (Block)
- (AXChainAnimator *(^)(AXChainAnimator *))beginWith {
    return ^AXChainAnimator* (AXChainAnimator *animator) {
        return [self beginWith:animator];
    };
}

- (AXChainAnimator *(^)(AXChainAnimator *))nextTo {
    return ^AXChainAnimator* (AXChainAnimator *animator) {
        return [self nextTo:animator];
    };
}

- (AXChainAnimator *(^)(AXChainAnimator *))combineWith {
    return ^AXChainAnimator* (AXChainAnimator *animator) {
        return [self combineWith:animator];
    };
}

- (AXChainAnimator *(^)(NSTimeInterval))beginTime {
    return ^AXChainAnimator* (NSTimeInterval beginTime) {
        return [self beginTime:beginTime];
    };
}

- (AXChainAnimator *(^)(NSTimeInterval))duration {
    return ^AXChainAnimator* (NSTimeInterval duration) {
        return [self duration:duration];
    };
}

- (AXChainAnimator *(^)(CGFloat))speed {
    return ^AXChainAnimator* (CGFloat speed) {
        return [self speed:speed];
    };
}

- (AXChainAnimator *(^)(NSTimeInterval))timeOffset {
    return ^AXChainAnimator* (NSTimeInterval timeOffset) {
        return [self timeOffset:timeOffset];
    };
}

- (AXChainAnimator *(^)(CGFloat))repeatCount {
    return ^AXChainAnimator* (CGFloat repeatCount) {
        return [self repeatCount:repeatCount];
    };
}

- (AXChainAnimator *(^)(NSTimeInterval))repeatDuration {
    return ^AXChainAnimator* (NSTimeInterval repeatDuration) {
        return [self repeatDuration:repeatDuration];
    };
}

- (AXChainAnimator *(^)(NSString *))fillMode {
    return ^AXChainAnimator* (NSString *fillMode) {
        return [self fillMode:fillMode];
    };
}

- (AXChainAnimator *(^)(NSObject *))target {
    return ^AXChainAnimator* (NSObject *target) {
        return [self target:target];
    };
}

- (AXChainAnimator *(^)(SEL))complete {
    return ^AXChainAnimator* (SEL completion) {
        return [self complete:completion];
    };
}

- (AXChainAnimator *(^)(dispatch_block_t))completeWithBlock {
    return ^AXChainAnimator* (dispatch_block_t completion) {
        return [self completeWithBlock:completion];
    };
}

- (dispatch_block_t)animate {
    return ^() {
        [self start];
    };
}
@end

@implementation AXBasicChainAnimator (Block)
- (AXBasicChainAnimator *(^)(AXBasicChainAnimator *))beginWith {
    return ^AXBasicChainAnimator* (AXBasicChainAnimator *animator) {
        return [self beginWith:animator];
    };
}

- (AXBasicChainAnimator *(^)(AXBasicChainAnimator *))nextTo {
    return ^AXBasicChainAnimator* (AXBasicChainAnimator *animator) {
        return [self nextTo:animator];
    };
}

- (AXBasicChainAnimator *(^)(AXBasicChainAnimator *))combineWith {
    return ^AXBasicChainAnimator* (AXBasicChainAnimator *animator) {
        return [self combineWith:animator];
    };
}

- (AXBasicChainAnimator *(^)(NSTimeInterval))beginTime {
    return ^AXBasicChainAnimator* (NSTimeInterval beginTime) {
        return [self beginTime:beginTime];
    };
}

- (AXBasicChainAnimator *(^)(NSTimeInterval))duration {
    return ^AXBasicChainAnimator* (NSTimeInterval duration) {
        return [self duration:duration];
    };
}

- (AXBasicChainAnimator *(^)(CGFloat))speed {
    return ^AXBasicChainAnimator* (CGFloat speed) {
        return [self speed:speed];
    };
}

- (AXBasicChainAnimator *(^)(NSTimeInterval))timeOffset {
    return ^AXBasicChainAnimator* (NSTimeInterval timeOffset) {
        return [self timeOffset:timeOffset];
    };
}

- (AXBasicChainAnimator *(^)(CGFloat))repeatCount {
    return ^AXBasicChainAnimator* (CGFloat repeatCount) {
        return [self repeatCount:repeatCount];
    };
}

- (AXBasicChainAnimator *(^)(NSTimeInterval))repeatDuration {
    return ^AXBasicChainAnimator* (NSTimeInterval repeatDuration) {
        return [self repeatDuration:repeatDuration];
    };
}

- (AXBasicChainAnimator *(^)(NSString *))fillMode {
    return ^AXBasicChainAnimator* (NSString *fillMode) {
        return [self fillMode:fillMode];
    };
}

- (AXBasicChainAnimator *(^)(NSString *))property {
    return ^AXBasicChainAnimator* (NSString *property) {
        return [self property:property];
    };
}

- (AXBasicChainAnimator *(^)(id))fromValue {
    return ^AXBasicChainAnimator* (id fromValue) {
        return [self fromValue:fromValue];
    };
}

- (AXBasicChainAnimator *(^)(id))toValue {
    return ^AXBasicChainAnimator* (id toValue) {
        return [self toValue:toValue];
    };
}

- (AXBasicChainAnimator *(^)(id))byValue {
    return ^AXBasicChainAnimator* (id byValue) {
        return [self byValue:byValue];
    };
}

- (AXBasicChainAnimator *(^)(NSObject *))target {
    return ^AXBasicChainAnimator* (NSObject *target) {
        return [self target:target];
    };
}

- (AXBasicChainAnimator *(^)(SEL))complete {
    return ^AXBasicChainAnimator* (SEL completion) {
        return [self complete:completion];
    };
}

- (AXBasicChainAnimator *(^)(dispatch_block_t))completeWithBlock {
    return ^AXBasicChainAnimator* (dispatch_block_t completion) {
        return [self completeWithBlock:completion];
    };
}
@end

@implementation AXKeyframeChainAnimator (Block)
- (AXKeyframeChainAnimator *(^)(AXKeyframeChainAnimator *))beginWith {
    return ^AXKeyframeChainAnimator* (AXKeyframeChainAnimator *animator) {
        return [self beginWith:animator];
    };
}

- (AXKeyframeChainAnimator *(^)(AXKeyframeChainAnimator *))nextTo {
    return ^AXKeyframeChainAnimator* (AXKeyframeChainAnimator *animator) {
        return [self nextTo:animator];
    };
}

- (AXKeyframeChainAnimator *(^)(AXKeyframeChainAnimator *))combineWith {
    return ^AXKeyframeChainAnimator* (AXKeyframeChainAnimator *animator) {
        return [self combineWith:animator];
    };
}

- (AXKeyframeChainAnimator *(^)(NSTimeInterval))beginTime {
    return ^AXKeyframeChainAnimator* (NSTimeInterval beginTime) {
        return [self beginTime:beginTime];
    };
}

- (AXKeyframeChainAnimator *(^)(NSTimeInterval))duration {
    return ^AXKeyframeChainAnimator* (NSTimeInterval duration) {
        return [self duration:duration];
    };
}

- (AXKeyframeChainAnimator *(^)(CGFloat))speed {
    return ^AXKeyframeChainAnimator* (CGFloat speed) {
        return [self speed:speed];
    };
}

- (AXKeyframeChainAnimator *(^)(NSTimeInterval))timeOffset {
    return ^AXKeyframeChainAnimator* (NSTimeInterval timeOffset) {
        return [self timeOffset:timeOffset];
    };
}

- (AXKeyframeChainAnimator *(^)(CGFloat))repeatCount {
    return ^AXKeyframeChainAnimator* (CGFloat repeatCount) {
        return [self repeatCount:repeatCount];
    };
}

- (AXKeyframeChainAnimator *(^)(NSTimeInterval))repeatDuration {
    return ^AXKeyframeChainAnimator* (NSTimeInterval repeatDuration) {
        return [self repeatDuration:repeatDuration];
    };
}

- (AXKeyframeChainAnimator *(^)(NSString *))fillMode {
    return ^AXKeyframeChainAnimator* (NSString *fillMode) {
        return [self fillMode:fillMode];
    };
}

- (AXKeyframeChainAnimator *(^)(NSString *))property {
    return ^AXKeyframeChainAnimator* (NSString *property) {
        return [self property:property];
    };
}

- (AXKeyframeChainAnimator *(^)(NSArray<id> *))values {
    return ^AXKeyframeChainAnimator* (NSArray<id> *values) {
        return [self values:values];
    };
}

- (AXKeyframeChainAnimator *(^)(UIBezierPath *))path {
    return ^AXKeyframeChainAnimator* (UIBezierPath *path) {
        return [self path:path];
    };
}

- (AXKeyframeChainAnimator *(^)(NSArray<NSNumber *> *))keyTimes {
    return ^AXKeyframeChainAnimator* (NSArray<NSNumber *> *keyTimes) {
        return [self keyTimes:keyTimes];
    };
}

- (AXKeyframeChainAnimator *(^)(NSArray<CAMediaTimingFunction *> *))timingFunctions {
    return ^AXKeyframeChainAnimator* (NSArray<CAMediaTimingFunction *> *timingFunctions) {
        return [self timingFunctions:timingFunctions];
    };
}

- (AXKeyframeChainAnimator *(^)(NSString *))calculationMode {
    return ^AXKeyframeChainAnimator* (NSString *calculationMode) {
        return [self calculationMode:calculationMode];
    };
}

- (AXKeyframeChainAnimator *(^)(NSArray<NSNumber *> *))tensionValues {
    return ^AXKeyframeChainAnimator* (NSArray<NSNumber *> *tensionValues) {
        return [self tensionValues:tensionValues];
    };
}

- (AXKeyframeChainAnimator *(^)(NSArray<NSNumber *> *))continuityValues {
    return ^AXKeyframeChainAnimator* (NSArray<NSNumber *> *continuityValues) {
        return [self continuityValues:continuityValues];
    };
}

- (AXKeyframeChainAnimator *(^)(NSArray<NSNumber *> *))biasValues {
    return ^AXKeyframeChainAnimator* (NSArray<NSNumber *> *biasValues) {
        return [self biasValues:biasValues];
    };
}

- (AXKeyframeChainAnimator *(^)(NSString *))rotationMode {
    return ^AXKeyframeChainAnimator* (NSString *rotationMode) {
        return [self rotationMode:rotationMode];
    };
}


- (AXKeyframeChainAnimator *(^)(NSObject *))target {
    return ^AXKeyframeChainAnimator* (NSObject *target) {
        return [self target:target];
    };
}

- (AXKeyframeChainAnimator *(^)(SEL))complete {
    return ^AXKeyframeChainAnimator* (SEL completion) {
        return [self complete:completion];
    };
}

- (AXKeyframeChainAnimator *(^)(dispatch_block_t))completeWithBlock {
    return ^AXKeyframeChainAnimator* (dispatch_block_t completion) {
        return [self completeWithBlock:completion];
    };
}
@end

@implementation AXSpringChainAnimator (Block)
- (AXSpringChainAnimator *(^)(AXSpringChainAnimator *))beginWith {
    return ^AXSpringChainAnimator* (AXSpringChainAnimator *animator) {
        return [self beginWith:animator];
    };
}

- (AXSpringChainAnimator *(^)(AXSpringChainAnimator *))nextTo {
    return ^AXSpringChainAnimator* (AXSpringChainAnimator *animator) {
        return [self nextTo:animator];
    };
}

- (AXSpringChainAnimator *(^)(AXSpringChainAnimator *))combineWith {
    return ^AXSpringChainAnimator* (AXSpringChainAnimator *animator) {
        return [self combineWith:animator];
    };
}

- (AXSpringChainAnimator *(^)(NSTimeInterval))beginTime {
    return ^AXSpringChainAnimator* (NSTimeInterval beginTime) {
        return [self beginTime:beginTime];
    };
}

- (AXSpringChainAnimator *(^)(NSTimeInterval))duration {
    return ^AXSpringChainAnimator* (NSTimeInterval duration) {
        return [self duration:duration];
    };
}

- (AXSpringChainAnimator *(^)(CGFloat))speed {
    return ^AXSpringChainAnimator* (CGFloat speed) {
        return [self speed:speed];
    };
}

- (AXSpringChainAnimator *(^)(NSTimeInterval))timeOffset {
    return ^AXSpringChainAnimator* (NSTimeInterval timeOffset) {
        return [self timeOffset:timeOffset];
    };
}

- (AXSpringChainAnimator *(^)(CGFloat))repeatCount {
    return ^AXSpringChainAnimator* (CGFloat repeatCount) {
        return [self repeatCount:repeatCount];
    };
}

- (AXSpringChainAnimator *(^)(NSTimeInterval))repeatDuration {
    return ^AXSpringChainAnimator* (NSTimeInterval repeatDuration) {
        return [self repeatDuration:repeatDuration];
    };
}

- (AXSpringChainAnimator *(^)(NSString *))fillMode {
    return ^AXSpringChainAnimator* (NSString *fillMode) {
        return [self fillMode:fillMode];
    };
}

- (AXSpringChainAnimator *(^)(NSString *))property {
    return ^AXSpringChainAnimator* (NSString *property) {
        return [self property:property];
    };
}

- (AXSpringChainAnimator *(^)(id))fromValue {
    return ^AXSpringChainAnimator* (id fromValue) {
        return [self fromValue:fromValue];
    };
}

- (AXSpringChainAnimator *(^)(id))toValue {
    return ^AXSpringChainAnimator* (id toValue) {
        return [self toValue:toValue];
    };
}

- (AXSpringChainAnimator *(^)(id))byValue {
    return ^AXSpringChainAnimator* (id byValue) {
        return [self byValue:byValue];
    };
}

- (AXSpringChainAnimator *(^)(CGFloat))mass {
    return ^AXSpringChainAnimator* (CGFloat mass) {
        return [self mass:mass];
    };
}

- (AXSpringChainAnimator *(^)(CGFloat))stiffness {
    return ^AXSpringChainAnimator* (CGFloat stiffness) {
        return [self stiffness:stiffness];
    };
}

- (AXSpringChainAnimator *(^)(CGFloat))damping {
    return ^AXSpringChainAnimator* (CGFloat damping) {
        return [self damping:damping];
    };
}

- (AXSpringChainAnimator *(^)(CGFloat))initialVelocity {
    return ^AXSpringChainAnimator* (CGFloat initialVelocity) {
        return [self initialVelocity:initialVelocity];
    };
}

- (AXSpringChainAnimator *(^)(NSObject *))target {
    return ^AXSpringChainAnimator* (NSObject *target) {
        return [self target:target];
    };
}

- (AXSpringChainAnimator *(^)(SEL))complete {
    return ^AXSpringChainAnimator* (SEL completion) {
        return [self complete:completion];
    };
}

- (AXSpringChainAnimator *(^)(dispatch_block_t))completeWithBlock {
    return ^AXSpringChainAnimator* (dispatch_block_t completion) {
        return [self completeWithBlock:completion];
    };
}
@end

@implementation AXTransitionChainAnimator (Block)
- (AXTransitionChainAnimator *(^)(AXTransitionChainAnimator *))beginWith {
    return ^AXTransitionChainAnimator* (AXTransitionChainAnimator *animator) {
        return [self beginWith:animator];
    };
}

- (AXTransitionChainAnimator *(^)(AXTransitionChainAnimator *))nextTo {
    return ^AXTransitionChainAnimator* (AXTransitionChainAnimator *animator) {
        return [self nextTo:animator];
    };
}

- (AXTransitionChainAnimator *(^)(AXTransitionChainAnimator *))combineWith {
    return ^AXTransitionChainAnimator* (AXTransitionChainAnimator *animator) {
        return [self combineWith:animator];
    };
}

- (AXTransitionChainAnimator *(^)(NSTimeInterval))beginTime {
    return ^AXTransitionChainAnimator* (NSTimeInterval beginTime) {
        return [self beginTime:beginTime];
    };
}

- (AXTransitionChainAnimator *(^)(NSTimeInterval))duration {
    return ^AXTransitionChainAnimator* (NSTimeInterval duration) {
        return [self duration:duration];
    };
}

- (AXTransitionChainAnimator *(^)(CGFloat))speed {
    return ^AXTransitionChainAnimator* (CGFloat speed) {
        return [self speed:speed];
    };
}

- (AXTransitionChainAnimator *(^)(NSTimeInterval))timeOffset {
    return ^AXTransitionChainAnimator* (NSTimeInterval timeOffset) {
        return [self timeOffset:timeOffset];
    };
}

- (AXTransitionChainAnimator *(^)(CGFloat))repeatCount {
    return ^AXTransitionChainAnimator* (CGFloat repeatCount) {
        return [self repeatCount:repeatCount];
    };
}

- (AXTransitionChainAnimator *(^)(NSTimeInterval))repeatDuration {
    return ^AXTransitionChainAnimator* (NSTimeInterval repeatDuration) {
        return [self repeatDuration:repeatDuration];
    };
}

- (AXTransitionChainAnimator *(^)(NSString *))fillMode {
    return ^AXTransitionChainAnimator* (NSString *fillMode) {
        return [self fillMode:fillMode];
    };
}

- (AXTransitionChainAnimator *(^)(NSString *))type {
    return ^AXTransitionChainAnimator* (NSString *type) {
        return [self type:type];
    };
}

- (AXTransitionChainAnimator *(^)(NSString *))subtype {
    return ^AXTransitionChainAnimator* (NSString *subtype) {
        return [self subtype:subtype];
    };
}

- (AXTransitionChainAnimator *(^)(CGFloat))startProgress {
    return ^AXTransitionChainAnimator* (CGFloat startProgress) {
        return [self startProgress:startProgress];
    };
}

- (AXTransitionChainAnimator *(^)(CGFloat))endProgress {
    return ^AXTransitionChainAnimator* (CGFloat endProgress) {
        return [self endProgress:endProgress];
    };
}

- (AXTransitionChainAnimator *(^)(id))filter {
    return ^AXTransitionChainAnimator* (id filter) {
        return [self filter:filter];
    };
}

- (AXTransitionChainAnimator *(^)(NSObject *))target {
    return ^AXTransitionChainAnimator* (NSObject *target) {
        return [self target:target];
    };
}

- (AXTransitionChainAnimator *(^)(SEL))complete {
    return ^AXTransitionChainAnimator* (SEL completion) {
        return [self complete:completion];
    };
}

- (AXTransitionChainAnimator *(^)(dispatch_block_t))completeWithBlock {
    return ^AXTransitionChainAnimator* (dispatch_block_t completion) {
        return [self completeWithBlock:completion];
    };
}
@end
