# 动画曲线

**动画曲线**用来描述动画随时间进行的速度的快慢，优雅的动画曲线描述的动画通常都比较优美而不会显得突兀(除非有意而为之)，在iOS中，通常使用`CAMediaTimingFunction`**时间函数**来描述**动画曲线**，当然，`CoreAnimation`系统已经为我们提供了5个默认的**时间函数**，他们分别是：

`Default`: 先缓慢加速，再缓慢减速

![Default](http://ww3.sinaimg.cn/large/d2297bd2gw1fbp2gwpkwyj21kw0n8765.jpg)

`EaseIn`: 开始时缓慢减速

![EaseIn](http://ww3.sinaimg.cn/large/d2297bd2gw1fbp2cwr2x5j21kw0n8q4i.jpg)

`EaseOut`: 结束时缓慢减速

![EaseOut](http://ww2.sinaimg.cn/large/d2297bd2gw1fbp2dy7q3vj21kw0nktaf.jpg)

`EaseInOut`: 开始和结束都减速

![EaseInOut](http://ww1.sinaimg.cn/large/d2297bd2gw1fbp2ewpefyj21kw0nutal.jpg)

`Linear`:

![Linear](http://ww2.sinaimg.cn/large/d2297bd2gw1fbp2ftykjgj21kw0ngwg6.jpg)

当然，也可以通过方法:

```objective-c
+ (instancetype)functionWithControlPoints:(float)c1x :(float)c1y :(float)c2x :(float)c2y;
```

来创建自定义的**动画曲线**，通过传入两个控制点而得到一条**三次贝塞尔曲线**，即能满足自定义的需求. [编辑贝塞尔曲线](http://netcetera.org/camtf-playground.html). 

**动画曲线**在使用的时候将需要设置的**时间函数**设置给`CAAnimation`的`timingFunction`即可，但是**Spring**动画却不能使用`CAMediaTimingFunction`来描述，我们可以注意到，在以上**动画曲线**里，所描述的`速度`与`时间`的关系两者都区间都是`[0,1]`，意味着动画若需要在结束时减速，则开始时也不可能同时减速. 总而言之，三次贝塞尔无法描述**Spring**动画的曲线.

# 什么是Spring动画

Spring：弹性、弹簧. Spring动画指的就是弹性动画，在iOS2.0以来，`CoreAnimation`就为我们提供了丰富的动画库，可以使用`CABasicAnimation`来创建基础动画，初始化CABasicAnimation之后，设置动画时间(`CAMediaTiming`协议相关的一系列属性)，并设置初始值、结束值之后添加到`CALayer`上即可开始动画，想要更复杂的动画，就可以使用帧动画`CAKeyframeAnimation`，更详细的使用教程参考：[iOS开发之让你的应用“动”起来](http://www.cocoachina.com/ios/20141022/10005.html). 那么说到底，什么是Spring动画呢？计算机图形发展到现在，不管绘图也好，动画也好，都有相应的**数学模型**可以追溯. 在iOS里边，`CAAnimation`类实现了`CAMediaTiming`协议以实现对动画的时间管理，在`CAMediaTiming`里边有个属性`timingFunction`，这个属性是用来控制**动画曲线**的，**动画曲线**是用来描述动画随时间进行的**速度**的模型，在数学里，就是**斜率**. 在`CoreAnimation`进行动画的时候，会根据**动画曲线**的描述来进行动画，所以我们可以实现很多很漂亮很流畅的动画. Spring动画对应的函数模型是[阻尼震动](https://zh.wikipedia.org/zh-cn/振动#.E9.98.BB.E5.B0.BC.E6.8C.AF.E5.8A.A8). 函数曲线如下：

![curve](http://ww4.sinaimg.cn/large/d2297bd2gw1fbp08m1s2nj21kw0zogn3.jpg)

# 阻尼震动

**阻尼震动**的详细解释可以参考：[阻尼震动](https://zh.wikipedia.org/zh-cn/振动#.E9.98.BB.E5.B0.BC.E6.8C.AF.E5.8A.A8). 根据维基百科描述，我们可以得到以下运动方程：



