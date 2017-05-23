//
//  CAAnimation+ImmediateValue.m
//  AXAnimationChain
//
//  Created by devedbox on 2017/4/1.
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

#import "CAAnimation+ImmediateValue.h"
#import "CAAnimation+Convertable.h"
#import "CAMediaTimingFunction+Extends.h"

#ifndef _imp_AXDisableImmediateValue
#define _imp_AXDisableImmediateValue(AnimationClass) \
@implementation AnimationClass (ImmediateValue)\
- (id)immediateValueAtTime:(CFTimeInterval)time error:(NSError *__autoreleasing  _Nullable * _Nullable)error {\
if (error != NULL) *error = [NSError errorWithDomain:@"axanimation_chain.caanimation.immediatevalue" code:kAXImmediateValueCannotBeCalculatedErrorCode userInfo:@{NSLocalizedFailureReasonErrorKey:[NSString stringWithFormat:@"Values of instance of animation class `%@` cannot be calculated.", NSStringFromClass(self.class)]}];\
return nil;\
}\
@end
#endif

NSUInteger const kAXImmediateValueCannotBeCalculatedErrorCode = 0x2711; //10001

extern NSUInteger kAXCAKeyframeAnimationFrameCount;
extern id CalculateToValueWithByValue(id value, id byValue, BOOL plus);
extern NSArray * CAKeyframeValuesWithFrames(id fromValue, id toValue, NSTimeInterval duration, CAMediaTimingFunction *timing, CAKeyframeValuesFunction function);

static id _ImmediateValueAtIndex(id fromValue, id toValue, NSTimeInterval duration, CFTimeInterval time, CAMediaTimingFunction *timing, CAKeyframeValuesFunction function) {
    NSUInteger allFramesCount = ceil(kAXCAKeyframeAnimationFrameCount * duration)+2;
    CGFloat pt = time/duration;
    
    NSArray *values = CAKeyframeValuesWithFrames(fromValue, toValue, duration, timing, NULL);
    
    NSUInteger index = ceil(pt * allFramesCount);
    if (index > values.count-1) return nil;
    
    id value = values[index];
    return value;
}

@implementation CABasicAnimation (ImmediateValue)
- (id)immediateValueAtTime:(CFTimeInterval)time error:(NSError *__autoreleasing  _Nullable * _Nullable)error {
    id fromValue = self.fromValue;
    id toValue = self.toValue;
    id byValue = self.byValue;
    
    if (fromValue && toValue) {
        return _ImmediateValueAtIndex(fromValue, toValue, self.duration, time, self.timingFunction, NULL);
    } else if (fromValue && byValue) {
        toValue = CalculateToValueWithByValue(fromValue, byValue, YES);
        return _ImmediateValueAtIndex(fromValue, toValue, self.duration, time, self.timingFunction, NULL);
    } else if (toValue && byValue) {
        fromValue = CalculateToValueWithByValue(toValue, byValue, NO);
        return _ImmediateValueAtIndex(fromValue, toValue, self.duration, time, self.timingFunction, NULL);
    } else {
        if (fromValue) return fromValue;
        if (byValue) return byValue;
        if (toValue) return toValue;
    }
    return nil;
}
@end
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
@implementation CASpringAnimation (ImmediateValue)
- (id)immediateValueAtTime:(CFTimeInterval)time error:(NSError *__autoreleasing  _Nullable * _Nullable)error {
    // Conver to AXSpringAnimation.
    AXSpringAnimation *spring = [AXSpringAnimation animationWithCoreSpring:self];
    return [spring immediateValueAtTime:time error:error];
    return [super immediateValueAtTime:time error:error];
}
@end
#endif
@implementation CAKeyframeAnimation (ImmediateValue)
- (id)immediateValueAtTime:(CFTimeInterval)time error:(NSError *__autoreleasing  _Nullable * _Nullable)error {
    NSAssert(self.keyTimes.count==0&&self.path==NULL, @"`keyTimes` and `path` properties of keyframe animation should not be setted.");
    
    if (self.keyTimes.count != 0 || self.path != NULL) return nil;
    if (time >= self.duration) return self.values.lastObject;
    
    NSUInteger allFramesCount = self.values.count;
    CGFloat pt = time/self.duration;
    
    NSUInteger index = ceil(pt * allFramesCount);
    if (index > self.values.count-1) return self.values.lastObject;
    
    id value = self.values[index];
    return value;
}
@end

#pragma mark - Disabled.
/// Exception for `CAAnimation`.
_imp_AXDisableImmediateValue(CAAnimation)
/// Exception for `CATransition`.
_imp_AXDisableImmediateValue(CATransition)
/// Exception for `CAAnimationGroup`.
_imp_AXDisableImmediateValue(CAAnimationGroup)
