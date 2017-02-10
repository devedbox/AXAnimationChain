//
//  CALayer+AnchorPoint.m
//  AXAnimationChain
//
//  Created by devedbox on 2017/2/10.
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

#import "CALayer+AnchorPoint.h"

@implementation CALayer (AnchorPoint)
- (instancetype)moveAnchorToPoint:(CGPoint)point {
    // If the new point is equal to the old anchor point, return immediately。
    if (CGPointEqualToPoint(point, self.anchorPoint)) return self;
    
    CGPoint newPoint = CGPointMake(self.bounds.size.width * point.x, self.bounds.size.height * point.y);
    CGPoint oldPoint = CGPointMake(self.bounds.size.width * self.anchorPoint.x, self.bounds.size.height * self.anchorPoint.y);
    
    newPoint = CGPointApplyAffineTransform(newPoint, self.affineTransform);
    oldPoint = CGPointApplyAffineTransform(oldPoint, self.affineTransform);
    
    CGPoint position = self.position;
    
    position.x += newPoint.x - oldPoint.x;
    position.y += newPoint.y - oldPoint.y;
    
    self.position = position;
    self.anchorPoint = point;
    
    return self;
}

- (instancetype)anchorToDefault {
    return [self anchorToCenter];
}

- (instancetype)anchorToCenter {
    return [self moveAnchorToPoint:CGPointMake(.5, .5)];
}

- (instancetype)anchorToTop {
    return [self moveAnchorToPoint:CGPointMake(.5, .0)];
}

- (instancetype)anchorToLeft {
    return [self moveAnchorToPoint:CGPointMake(.0, .5)];
}

- (instancetype)anchorToBottom {
    return [self moveAnchorToPoint:CGPointMake(.5, 1.0)];
}

- (instancetype)anchorToRight {
    return [self moveAnchorToPoint:CGPointMake(1.0, .5)];
}

- (instancetype)anchorToLeftTop {
    return [self moveAnchorToPoint:CGPointMake(.0, .0)];
}

- (instancetype)anchorToLeftBottom {
    return [self moveAnchorToPoint:CGPointMake(.0, 1.0)];
}

- (instancetype)anchorToRightTop {
    return [self moveAnchorToPoint:CGPointMake(1.0, .0)];
}

- (instancetype)anchorToRightBottom {
    return [self moveAnchorToPoint:CGPointMake(1.0, 1.0)];
}
@end
