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

@implementation CAAnimation (ImmediateValue)
- (id)immediateValueAtTime:(CFTimeInterval)time {
    return nil;
}
@end

@implementation CABasicAnimation (ImmediateValue)
- (id)immediateValueAtTime:(CFTimeInterval)time {
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
- (id)immediateValueAtTime:(CFTimeInterval)time {
    // Conver to AXSpringAnimation.
    AXSpringAnimation *spring = [AXSpringAnimation animationWithCoreSpring:self];
    return [spring immediateValueAtTime:time];
    return [super immediateValueAtTime:time];
}
@end
#endif
@implementation CAKeyframeAnimation (ImmediateValue)
- (id)immediateValueAtTime:(CFTimeInterval)time {
    if (time >= self.duration) return self.values.lastObject;
    
    NSUInteger allFramesCount = self.values.count;
    CGFloat pt = time/self.duration;
    
    NSUInteger index = ceil(pt * allFramesCount);
    if (index > self.values.count-1) return self.values.lastObject;
    
    id value = self.values[index];
    return value;
}
@end
