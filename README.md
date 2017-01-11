# AXAnimationChain[![Version](https://img.shields.io/cocoapods/v/AXAnimationChain.svg?style=flat)](http://cocoapods.org/pods/AXAnimationChain)[![License](https://img.shields.io/cocoapods/l/AXWebViewController.svg?style=flat)](http://cocoapods.org/pods/AXWebViewController)[![Platform](https://img.shields.io/cocoapods/p/AXWebViewController.svg?style=flat)](http://cocoapods.org/pods/AXWebViewController)

## Summary

[AXAnimationChain]([https://github.com/devedbox/AXAnimationChain](https://github.com/devedbox/AXAnimationChain))是一个**`链式动画库`**，可以用来轻松的创建基于`CAAnimation`的链式动画。**链**的组合方式有两种，一种是**组合**，另一种则是**链接**，通过以上两种方式创建的动画，既可以同时进行，也可以按时间先后进行，可以使用较少的代码创建出丰富复杂的动画效果：

简单使用:

```objective-c
_transitionView.spring.centerBy(CGPointMake(0, 100)).easeOut.spring.sizeBy(CGSizeMake(100, 100)).spring.cornerRadiusBy(4).animate();
```

![http://ww4.sinaimg.cn/large/d2297bd2gw1fbmsv0wh0lg20aa0i8422.gif](http://ww4.sinaimg.cn/large/d2297bd2gw1fbmsv0wh0lg20aa0i8422.gif)

高级使用(比较冗余):

```objective-c
_transitionView.chainAnimator.basic.target(self).complete(@selector(complete:)).property(@"position").toValue([NSValue valueWithCGPoint:CGPointMake(100, self.view.center.y)]).easeInBack.duration(0.5).combineSpring.target(self).complete(@selector(complete:)).property(@"bounds").toValue([NSValue valueWithCGRect:CGRectMake(0, 0, 100, 100)]).duration(0.5).repeatCount(5).autoreverses.combineSpring.target(self).complete(@selector(complete:)).property(@"transform.rotation").toValue(@(M_PI_4)).duration(0.5).repeatCount(3).beginTime(1.0).autoreverses.nextToBasic.property(@"position").toValue([NSValue valueWithCGPoint:self.view.center]).duration(0.5).combineSpring.property(@"bounds").toValue([NSValue valueWithCGRect:CGRectMake(0, 0, 100, 100)]).duration(0.8).nextToBasic.property(@"transform.rotation").toValue(@(M_PI_4)).duration(1.0).completeWithBlock(nil).animate();
    self.view.spring.backgroundColorTo([UIColor colorWithRed:1.000 green:0.988 blue:0.922 alpha:1.00]).animate();
```

看起来比较冗余，但是细读会发现，其实就只有**一行代码**.

![sample](http://ww1.sinaimg.cn/large/d2297bd2gw1fbmo8dxlw1g20aa0i8te0.gif)

**链接**和**组合**在协议`AXAnimatorChainDelegate`中进行定义，分别是：`nextTo:`和`combineWith:`，在使用的过程中应当予以区分. 

`AXAnimationChain`基于`CoreAnimation`定义了几种`Animator`，`AXChainAnimator`是基类，预定义了一系列`Animate`操作，可以**链接**、**组合**并且控制动画完成的**回调**：

```objective-c
AXChainAnimator
  --AXBasicChainAnimator     ==CABasicAnimation
    --AXSpringChainAnimator  ==CASpringAnimation
  --AXKeyframeChainAnimator  ==CAKeyframeAnimation
  --AXTransitionChainAnimator==CATransitionAnimation
```



### Next-To

通过链接的方式处理两个`animator`，**被链接**的`animator`将会在前者动画(包含*`组合`*的动画)完成之后进行动画, 大概的示例如下：

```objective-c
[former nextTo:nexter];
```

`Next-To`方法的原型如下：

```objective-c
- (instancetype)nextTo:(id<AXAnimatorChainDelegate>)animator;
```

当向`former aniamtor`发送`nextTo:`消息之后，返回的是`nexter animator`作为下次**链接**或者**组合**操作的对象，因此`AXAnimationChain`定义了几种常用的操作：

```objective-c
/// 链接到Basic动画并且返回链接的Basic动画.
- (AXBasicChainAnimator *)nextToBasic;
/// 链接到Spring动画并且放回链接的Spring动画.
- (AXSpringChainAnimator *)nextToSpring;
/// 链接到Keyframe动画并且放回链接的Keyframe动画.
- (AXKeyframeChainAnimator *)nextToKeyframe;
/// 链接到Transition动画并且返回链接的Transition动画.
- (AXTransitionChainAnimator *)nextToTransition;
```

在发送消息之后分别返回对应类型的**可操作对象**.

### Combine-With

通过组合的方式处理两个`animator`，被组合的`animator`将会与前者动画同时进行，完成的时间以时间最长的为准, 示例如下：

```objective-c
[former combineWith:combiner];
```

`Combine-With`方法原型如下：

```objective-c
- (instancetype)combineWith:(nonnull AXChainAnimator *)animator;
```

当向`former animator`发送`combineWith:`消息之后，返回的是`combiner animator`作为下次**链接**或者**组合**操作的对象，在`AXAnimationChain`中，默认一下几种组合方式：

```objective-c
/// 组合到Basic动画并且返回组合的Basic动画.
- (AXBasicChainAnimator *)combineBasic;
/// 组合到Spring动画并且放回组合的Spring动画.
- (AXSpringChainAnimator *)combineSpring;
/// 组合到Keyframe动画并且放回组合的Keyframe动画.
- (AXKeyframeChainAnimator *)combineKeyframe;
/// 组合到Transition动画并且返回组合的Transition动画.
- (AXTransitionChainAnimator *)combineTransition;
```

同样的，在向某一操作对象`animator`发送以上消息之后，将会分别返回对应类型的**可操作对象**.

### Relationship

在`AXAnimationChain`中，关系的管理采用的是二叉树的理论. 某一个`animator`对应的类结构中，包含了指向**父节点**的`superAnimator`用于表示`父animator`, 表示此`animator`为`superAnimator`所链接的`animator`, 此时，`superAnimator`的`childAnimator`即指向此`animator`作为一个**闭环链**将两者的关系锁定起来; 同样的，某一个`animator`还拥有一个指向**兄弟节点**的`NSArray<AXChainAnimator *>`结构:`combinedAnimators`用于管理所组合的`animators`，并且，被组合的`animator`的父节点`superAnimator`则指向当前`animator`. 

```objective-c
- (void)start {
    NSAssert(_animatedView, @"Animation chain cannot be created because animated view is null.");
    AXChainAnimator *superAnimator = _superAnimator;
    AXChainAnimator *superSuperAnimator = _superAnimator;
    while (superAnimator) {
        superAnimator = superAnimator.superAnimator;
        if (superAnimator) {
            superSuperAnimator = superAnimator;
        }
    }
    if (superSuperAnimator) {
        [superSuperAnimator start];
    } else {
        [self _beginAnimating];
        if (!_childAnimator) [self _clear];
    }
}
```

`AXAnimatioChain`就是通过这样的关系把所有**链接**和**组合**的`animator`管理起来的，在完成关系的链接或组合之后，需要向最后一个`animator`发送`-start`消息动画才能正常进行. `animator`在接收到`-start`消息之后，会逐级遍历`superAnimator`直至`superAnimator.superAnimator==nil`, 此时获取到`superSuperAnimator`, 从`superSuperAnimator`自祖先往下逐级进行动画，**组合**的动画会**同时**进行，**链接**的动画则按**顺序**进行.

## Features

> 轻量级解决方案
>
> 基于CoreAnimation的封装，安全、高效！
>
> 一行代码搞定复杂的动画管理，提高代码维护效

#### TimingControl

时间曲线，时间曲线用于描述动画随时间进行的速度，`AXAnimationChain`除了包含系统默认的时间曲线之外，还提供了如下的曲线以呈现更漂亮的动画：

![http://ww1.sinaimg.cn/large/d2297bd2gw1fbmrilba19j21c610047c.jpg](http://ww1.sinaimg.cn/large/d2297bd2gw1fbmrilba19j21c610047c.jpg)

#### AXSpringAnimation

`CoreAnimation`自`iOS2.0`就为iOS平台提供了核心动画的支持，但是在iOS9.0之前，一直没有`Spring`动画，要使用`Spring`动画要么使用第三方动画库，要么使用系统提供的方法:

```objective-c
+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay usingSpringWithDamping:(CGFloat)dampingRatio initialSpringVelocity:(CGFloat)velocity options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion NS_AVAILABLE_IOS(7_0);
```

但是系统提供的这个方法也是`iOS7.0`以后才能使用了，并且在控制上并非那么容易.

 `AXSpringAnimation`是基于**阻尼震动**运动模型的`Spring`动画类，能够完美与`CASpringAnimation`相通用：

![http://ww2.sinaimg.cn/large/d2297bd2gw1fbmrt5bnvsg20aa0i8go7.gif](http://ww2.sinaimg.cn/large/d2297bd2gw1fbmrt5bnvsg20aa0i8go7.gif)

动画中，左边正方形使用的是`CASpringAnimation`类，右边的则使用的是`AXSpringAnimation`，两者的动画曲线是一致的.

`AXSpringAnimation`的API和`CASpringAnimation`是一致的：

```objective-c
@interface AXSpringAnimation : CAKeyframeAnimation
/* The mass of the object attached to the end of the spring. Must be greater
 than 0. Defaults to one. */

@property(assign, nonatomic) CGFloat mass;

/* The spring stiffness coefficient. Must be greater than 0.
 * Defaults to 100. */

@property(assign, nonatomic) CGFloat stiffness;

/* The damping coefficient. Must be greater than or equal to 0.
 * Defaults to 10. */

@property(assign, nonatomic) CGFloat damping;

/* The initial velocity of the object attached to the spring. Defaults
 * to zero, which represents an unmoving object. Negative values
 * represent the object moving away from the spring attachment point,
 * positive values represent the object moving towards the spring
 * attachment point. */

@property(assign, nonatomic) CGFloat initialVelocity;

/* Returns the estimated duration required for the spring system to be
 * considered at rest. The duration is evaluated for the current animation
 * parameters. */

@property(readonly, nonatomic) CFTimeInterval settlingDuration;

/* The objects defining the property values being interpolated between.
 * All are optional, and no more than two should be non-nil. The object
 * type should match the type of the property being animated (using the
 * standard rules described in CALayer.h). The supported modes of
 * animation are:
 *
 * - both `fromValue' and `toValue' non-nil. Interpolates between
 * `fromValue' and `toValue'.
 *
 * - `fromValue' and `byValue' non-nil. Interpolates between
 * `fromValue' and `fromValue' plus `byValue'.
 *
 * - `byValue' and `toValue' non-nil. Interpolates between `toValue'
 * minus `byValue' and `toValue'. */

@property(nullable, strong, nonatomic) id fromValue;
@property(nullable, strong, nonatomic) id toValue;
@property(nullable, strong, nonatomic) id byValue;
@end
```



#### Convertable

`AXAnimationChain`框架还提供了将`CABasicAnimation`无缝转换为`CAKeyframeAnimation`的功能：

![http://ww3.sinaimg.cn/large/d2297bd2gw1fbmryhpe3qg20aa0i84ai.gif](http://ww3.sinaimg.cn/large/d2297bd2gw1fbmryhpe3qg20aa0i84ai.gif)

动画中，左边是`CABasicAnimation`，右边是`CAKeyframeAnimation`，两者对应的动画曲线是一致的.

要使用动画转换，请参考：

```objective-c
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "CAMediaTimingFunction+Extends.h"

@interface CAAnimation (Convertable)
@end

@interface CAKeyframeAnimation (Convertable)
+ (instancetype)animationWithBasic:(CABasicAnimation *)basicAnimation;
+ (instancetype)animationWithBasic:(CABasicAnimation *)basicAnimation usingValuesFunction:(double (^)(double t, double b, double c, double d))valuesFunction;
@end
```



## Requirements

`AXAnimationChain` 对系统版本支持到`iOS8.0`，需要使用到的框架：

* Foundation.framework

- UIKit.framework
- QuartzCore.framework

使用的时候最好使用最新版Xcode.

## Adding `AXAimationChain` To Your Project

### CocoaPods

[CocoaPods]([http://cocoapods.org](http://cocoapods.org)) is the recommended way to add AXWebViewController to your project.

1. Add a pod entry for AXPopoverView to your Podfile `pod 'AXAimationChain', '~> 0.1.0'`
2. Install the pod(s) by running `pod install`.
3. Include AXPopoverView wherever you need it with `#import "AXAimationChain.h"`.
4. 若需要单独使用`AXSpringAnimation`或者`Convertable`以及`TimingControl`等特性的话，只需要将podfile里边`AXAnimationChain`替换为`AXAnimationChain/CoreAnimation`即可，即：`pod 'AXAimationChain/CoreAnimation', '~> 0.1.0'`.

### Source files

Alternatively you can directly add all the source files to your project.

1. Download the [latest code version]([https://github.com/devedbox/AXAimationChain/archive/master.zip](https://github.com/devedbox/AXAimationChain/archive/master.zip)) or add the repository as a git submodule to your git-tracked project. 
2. Open your project in Xcode, then drag and drop the source group onto your project (use the "Product Navigator view"). Make sure to select Copy items when asked if you extracted the code archive outside of your project. 
3. Include AXPopoverView wherever you need it with `#import "AXAimationChain.h"`.

## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE). 

## 使用

请参考示例工程代码以及API.

## 不足

此项目在开展的时候比较庞大，基础的核心类已经构建好了，基本目标已经达成，但是还有很多需要完善的地方，后边会逐步完善并发布Release版本.

## 声明

转载需注明出处：http://devedbox.com/AXAnimationChain/