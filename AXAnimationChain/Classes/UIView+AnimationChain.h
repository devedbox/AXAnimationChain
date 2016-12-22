//
//  UIView+AnimationChain.h
//  AXAnimationChain
//
//  Created by devedbox on 2016/12/22.
//  Copyright © 2016年 devedbox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AnimationChain)

- (UIView * (^)(CGRect toFrame))frameTo;
- (UIView * (^)(CGRect toBounds))boundsTo;
- (UIView * (^)(CGSize toSize))sizeTo;
- (UIView * (^)(CGPoint toOrigin))originTo;
- (UIView * (^)(CGFloat toOriginX))originXTo;
- (UIView * (^)(CGFloat toOriginY))originYTo;
- (UIView * (^)(CGPoint toCenter))centerTo;
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
- (UIView * (^)(CGPoint toAnchor))anchorTo;
@end
