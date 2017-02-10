//
//  CALayer+AnchorPoint.h
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

#import <QuartzCore/QuartzCore.h>

@interface CALayer (AnchorPoint)
/// Move anchor to a new anchor point. This will change the position of the layer.
///
/// @param point a new anchor point. Between [0, 1].
///
/// @return a new layer after moved anchor.
- (instancetype)moveAnchorToPoint:(CGPoint)point;
/// Move anchor point to default anchor value.
///
- (instancetype)anchorToDefault;
/// Move anchor point to center point.
///
- (instancetype)anchorToCenter;
/// Move anchor point to top.
///
- (instancetype)anchorToTop;
/// Move anchor point to left.
///
- (instancetype)anchorToLeft;
/// Move anchor point to bottom.
///
- (instancetype)anchorToBottom;
/// Move anchor point to right.
///
- (instancetype)anchorToRight;
/// Move anchor point to left-top.
///
- (instancetype)anchorToLeftTop;
/// Move anchor point to left-bottom.
///
- (instancetype)anchorToLeftBottom;
/// Move anchor point to right-top.
///
- (instancetype)anchorToRightTop;
/// Move anchor point to right-bottom.
///
- (instancetype)anchorToRightBottom;
@end
