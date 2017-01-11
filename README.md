# AXAnimationChain[![Version](https://img.shields.io/cocoapods/v/AXAnimationChain.svg?style=flat)](http://cocoapods.org/pods/AXAnimationChain)[![License](https://img.shields.io/cocoapods/l/AXWebViewController.svg?style=flat)](http://cocoapods.org/pods/AXWebViewController)[![Platform](https://img.shields.io/cocoapods/p/AXWebViewController.svg?style=flat)](http://cocoapods.org/pods/AXWebViewController)

## Summary

`AXAnimationChain`是一个**`链式动画库`**，可以用来轻松的创建基于`CAAnimation`的链式动画。**链**的组合方式有两种，一种是**组合**，另一种则是**链接**，通过以上两种方式创建的动画，既可以同时进行，也可以按时间先后进行，可以使用较少的代码创建出丰富复杂的动画效果：

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
> 一行代码搞定复杂的动画管理，提高代码维护效率

## Requirements

`AXAnimationChain` 对系统版本支持到`iOS8.0`，需要使用到的框架：

* Foundation.framework

- UIKit.framework
- QuartzCore.framework

使用的时候最好使用最新版Xcode.

## Adding `AXAimationChain` To Your Project

### CocoaPods

[CocoaPods]([http://cocoapods.org](http://cocoapods.org)) is the recommended way to add AXWebViewController to your project.

1. Add a pod entry for AXPopoverView to your Podfile `pod 'AXAimationChain', '~> 0.1.10'`
2. Install the pod(s) by running `pod install`.
3. Include AXPopoverView wherever you need it with `#import "AXAimationChain.h"`.

### Source files

Alternatively you can directly add all the source files to your project.

1. Download the [latest code version]([https://github.com/devedbox/AXAimationChain/archive/master.zip](https://github.com/devedbox/AXAimationChain/archive/master.zip)) or add the repository as a git submodule to your git-tracked project. 
2. Open your project in Xcode, then drag and drop the source group onto your project (use the "Product Navigator view"). Make sure to select Copy items when asked if you extracted the code archive outside of your project. 
3. Include AXPopoverView wherever you need it with `#import "AXAimationChain.h"`.

## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE). 