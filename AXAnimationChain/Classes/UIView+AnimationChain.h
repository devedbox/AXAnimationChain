//
//  UIView+AnimationChain.h
//  AXAnimationChain
//
//  Created by devedbox on 2016/12/22.
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

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface UIView (AnimationChain)
#pragma mark - To values.
- (UIView * (^)(CGRect toFrame))frameTo;
- (UIView * (^)(CGRect toBounds))boundsTo;
- (UIView * (^)(CGSize toSize))sizeTo;
- (UIView * (^)(CGPoint toOrigin))originTo;
- (UIView * (^)(CGFloat toOriginX))originXTo;
- (UIView * (^)(CGFloat toOriginY))originYTo;
- (UIView * (^)(CGPoint toCenter))centerTo;
- (UIView * (^)(CGFloat toCenterX))centerXTo;
- (UIView * (^)(CGFloat toCenterY))centerYTo;
- (UIView * (^)(CGFloat toWidth))widthTo;
- (UIView * (^)(CGFloat toHeight))heightTo;
- (UIView * (^)(CGFloat toOpacity))opacityTo;
- (UIView * (^)(UIColor *toBackgroundColor))backgroundColorTo;
- (UIView * (^)(UIColor *toBorderColor))borderColorTo;
- (UIView * (^)(CGFloat toBorderWidth))borderWidthTo;
- (UIView * (^)(CGFloat toCornerRadius))cornerRadiusTo;
- (UIView * (^)(CGFloat toScale))scaleTo;
- (UIView * (^)(CGFloat toScaleX))scaleXTo;
- (UIView * (^)(CGFloat toScaleY))scaleYTo;
- (UIView * (^)(CGFloat toScaleZ))scaleZTo;
- (UIView * (^)(CGFloat toRotate))rotateTo;
- (UIView * (^)(CGFloat toRotateX))rotateXTo;
- (UIView * (^)(CGFloat toRotateY))rotateYTo;
- (UIView * (^)(CGFloat toRotateZ))rotateZTo;
- (UIView * (^)(CGPoint toTranslate))translateTo;
- (UIView * (^)(CGFloat toTranslateX))translateXTo;
- (UIView * (^)(CGFloat toTranslateY))translateYTo;
- (UIView * (^)(CGFloat toTranslateZ))translateZTo;
#pragma mark - UIImageView.
/// Animate to change the image content of UIImage object for UIImageView.
- (UIView * (^)(UIImage *toImage))imageTo;
#pragma mark - By values.
- (UIView * (^)(CGRect byFrame))frameBy;
- (UIView * (^)(CGRect byBounds))boundsBy;
- (UIView * (^)(CGSize bySize))sizeBy;
- (UIView * (^)(CGPoint byOrigin))originBy;
- (UIView * (^)(CGFloat byOriginX))originXBy;
- (UIView * (^)(CGFloat byOriginY))originYBy;
- (UIView * (^)(CGPoint byCenter))centerBy;
- (UIView * (^)(CGFloat byCenterX))centerXBy;
- (UIView * (^)(CGFloat byCenterY))centerYBy;
- (UIView * (^)(CGFloat byWidth))widthBy;
- (UIView * (^)(CGFloat byHeight))heightBy;
- (UIView * (^)(CGFloat byOpacity))opacityBy;
- (UIView * (^)(UIColor *byBackgroundColor))backgroundColorBy;
- (UIView * (^)(UIColor *byBorderColor))borderColorBy;
- (UIView * (^)(CGFloat byBorderWidth))borderWidthBy;
- (UIView * (^)(CGFloat byCornerRadius))cornerRadiusBy;
- (UIView * (^)(CGFloat byScale))scaleBy;
- (UIView * (^)(CGFloat byScaleX))scaleXBy;
- (UIView * (^)(CGFloat byScaleY))scaleYBy;
- (UIView * (^)(CGFloat byScaleZ))scaleZBy;
- (UIView * (^)(CGFloat byRotate))rotateBy;
- (UIView * (^)(CGFloat byRotateX))rotateXBy;
- (UIView * (^)(CGFloat byRotateY))rotateYBy;
- (UIView * (^)(CGFloat byRotateZ))rotateZBy;
- (UIView * (^)(CGPoint byTranslate))translateBy;
- (UIView * (^)(CGFloat byTranslateX))translateXBy;
- (UIView * (^)(CGFloat byTranslateY))translateYBy;
- (UIView * (^)(CGFloat byTranslateZ))translateZBy;

- (dispatch_block_t)animate;

#pragma mark - Timing control.
/// Duration with a time duration. This will effect the last animation chain object.
- (UIView * (^)(NSTimeInterval duration))duration;
/// After time interval of the next animator to begin at. Must not less than 0.
- (UIView * (^)(NSTimeInterval duration))after;
/// Wait until former animators have finished.
/* - (instancetype)wait; */
#pragma mark - Effects.
- (instancetype)linear;
- (instancetype)easeIn;
- (instancetype)easeOut;
- (instancetype)easeInOut;

- (instancetype)easeInSine;
- (instancetype)easeOutSine;
- (instancetype)easeInOutSine;
- (instancetype)easeInQuad;
- (instancetype)easeOutQuad;
- (instancetype)easeInOutQuad;
- (instancetype)easeInCubic;
- (instancetype)easeOutCubic;
- (instancetype)easeInOutCubic;
- (instancetype)easeInQuart;
- (instancetype)easeOutQuart;
- (instancetype)easeInOutQuart;
- (instancetype)easeInQuint;
- (instancetype)easeOutQuint;
- (instancetype)easeInOutQuint;
- (instancetype)easeInExpo;
- (instancetype)easeOutExpo;
- (instancetype)easeInOutExpo;
- (instancetype)easeInCirc;
- (instancetype)easeOutCirc;
- (instancetype)easeInOutCirc;
- (instancetype)easeInBack;
- (instancetype)easeOutBack;
- (instancetype)easeInOutBack;

- (instancetype)easeInElastic;
- (instancetype)easeOutElastic;
- (instancetype)easeInOutElastic;
- (instancetype)easeInBounce;
- (instancetype)easeOutBounce;
- (instancetype)easeInOutBounce;

#pragma mark - Animation.
/// Change the last animation of animator to the CABasicAnimation object.
- (instancetype)basic;
- (instancetype)spring;

#pragma mark - Target-Action.
- (UIView * (^)(NSObject *target))target;
- (UIView * (^)(SEL completion))complete;

- (UIView * (^)(dispatch_block_t completion))completeBlock;
@end
NS_ASSUME_NONNULL_END
