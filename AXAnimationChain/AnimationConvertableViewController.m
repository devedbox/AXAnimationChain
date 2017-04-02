//
//  AnimationConvertableViewController.m
//  AXAnimationChain
//
//  Created by devedbox on 2017/1/6.
//  Copyright © 2017年 devedbox. All rights reserved.
//

#import "AnimationConvertableViewController.h"
#import "CAMediaTimingFunction+Extends.h"
#import "CAAnimation+Convertable.h"
#import "AXSpringAnimation.h"
#import "AXDecayAnimation.h"

@interface AnimationConvertableViewController ()
/// Keyframe.
@property(weak, nonatomic) IBOutlet UISwitch *keyframe;
/// Transition view.
@property(weak, nonatomic) IBOutlet UIView *transitionView;
/// Transition view.
@property(weak, nonatomic) IBOutlet UIView *keyframeTransitionView;
/// Timing button.
@property(weak, nonatomic) IBOutlet UIButton *timing;
@end
@interface CAMediaTimingFunction (ExtendsInstance)
- (instancetype)defaultTimingFunction;
- (instancetype)linear;
- (instancetype)easeIn;
- (instancetype)easeOut;
- (instancetype)easeInOut;
/*
- (instancetype)decay; */
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
@end
@implementation AnimationConvertableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [_transitionView.layer addObserver:self forKeyPath:@"position" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"position"]) {
        NSLog(@"%@", NSStringFromCGPoint([change[NSKeyValueChangeNewKey] CGPointValue]));
    }
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)animate:(UIButton *)sender {
    [_transitionView.layer removeAllAnimations];
    [_keyframeTransitionView.layer removeAllAnimations];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.keyframeTransitionView.center.x, CGRectGetHeight(_keyframeTransitionView.frame)*.5+64)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.keyframeTransitionView.center.x, CGRectGetHeight(self.view.frame)-64-CGRectGetHeight(_keyframeTransitionView.frame)*.5)];
    animation.duration = 2.0;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    animation.timingFunction = [[CAMediaTimingFunction new] performSelector:NSSelectorFromString([_timing titleForState:UIControlStateNormal])];
#pragma clang diagnostic pop
    [_keyframeTransitionView.layer addAnimation:[CAKeyframeAnimation animationWithBasic:animation] forKey:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.transitionView.center.x, CGRectGetHeight(_transitionView.frame)*.5+64)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.transitionView.center.x, CGRectGetHeight(self.view.frame)-64-CGRectGetHeight(_transitionView.frame)*.5)];
    [_transitionView.layer addAnimation:animation forKey:@"position"];
    /*
    CASpringAnimation *spring = [CASpringAnimation animationWithKeyPath:@"position"];
    spring.removedOnCompletion = NO;
    spring.fillMode = kCAFillModeForwards;
    spring.timingFunction = [CAMediaTimingFunction defaultTimingFunction];
    spring.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.transitionView.center.x, CGRectGetHeight(_transitionView.frame)*.5+64)];
    spring.toValue = [NSValue valueWithCGPoint:CGPointMake(self.transitionView.center.x, CGRectGetHeight(self.view.frame)-64-CGRectGetHeight(_transitionView.frame)*.5)];
    [_transitionView.layer addAnimation:spring forKey:@"position"];
     */
}

- (IBAction)extends:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Extensions." message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"spring" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        /*
        [_transitionView.layer removeAllAnimations];
        CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"position"];
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.timingFunction = [CAMediaTimingFunction defaultTimingFunction];
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.transitionView.center.x, CGRectGetHeight(_transitionView.frame)*.5+64)];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.transitionView.center.x, CGRectGetHeight(self.view.frame)-64-CGRectGetHeight(_transitionView.frame)*.5)];
        [_transitionView.layer addAnimation:animation forKey:@"position"];
        */
        [_transitionView.layer removeAllAnimations];
        [_keyframeTransitionView.layer removeAllAnimations];
        AXCASpringAnimation *animation = [AXCASpringAnimation animationWithKeyPath:@"position"];
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        // animation.initialVelocity = 50;
        // animation.mass = 500;
        // animation.damping = 100;
        // animation.stiffness = 50;
        NSLog(@"settling duratuion: %@", @(animation.settlingDuration));
        animation.duration = animation.settlingDuration;
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.transitionView.center.x, CGRectGetHeight(_transitionView.frame)*.5+64)];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.transitionView.center.x, CGRectGetHeight(self.view.frame)-64-CGRectGetHeight(_transitionView.frame)*.5)];
        [_transitionView.layer addAnimation:animation forKey:@"position"];
        
        AXSpringAnimation *spring = [AXSpringAnimation animationWithKeyPath:@"position"];
        spring.removedOnCompletion = NO;
        spring.fillMode = kCAFillModeForwards;
        spring.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.keyframeTransitionView.center.x, CGRectGetHeight(_keyframeTransitionView.frame)*.5+64)];
        spring.toValue = [NSValue valueWithCGPoint:CGPointMake(self.keyframeTransitionView.center.x, CGRectGetHeight(self.view.frame)-64-CGRectGetHeight(_keyframeTransitionView.frame)*.5)];
        // spring.initialVelocity = 50;
        // spring.mass = 500;
        // spring.damping = 100;
        // spring.stiffness = 50;
        spring.duration = spring.settlingDuration;
        NSLog(@"settling duratuion: %@", @(spring.settlingDuration));
        [_keyframeTransitionView.layer addAnimation:spring forKey:@"position"];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"easeInElastic" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_transitionView.layer removeAllAnimations];
        [_keyframeTransitionView.layer removeAllAnimations];
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.keyframeTransitionView.center.x, CGRectGetHeight(_keyframeTransitionView.frame)*.5+64)];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.keyframeTransitionView.center.x, CGRectGetHeight(self.view.frame)-64-CGRectGetHeight(_keyframeTransitionView.frame)*.5)];
        animation.duration = 2.0;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        animation.timingFunction = [[CAMediaTimingFunction new] performSelector:NSSelectorFromString([_timing titleForState:UIControlStateNormal])];
#pragma clang diagnostic pop
        [_keyframeTransitionView.layer addAnimation:[CAKeyframeAnimation animationWithBasic:animation usingValuesFunction:[CAMediaTimingFunction easeInElasticValuesFuntion]] forKey:@"position"];
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.transitionView.center.x, CGRectGetHeight(_transitionView.frame)*.5+64)];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.transitionView.center.x, CGRectGetHeight(self.view.frame)-64-CGRectGetHeight(_transitionView.frame)*.5)];
        // [_transitionView.layer addAnimation:animation forKey:@"position"];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"easeOutElastic" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_transitionView.layer removeAllAnimations];
        [_keyframeTransitionView.layer removeAllAnimations];
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.keyframeTransitionView.center.x, CGRectGetHeight(_keyframeTransitionView.frame)*.5+64)];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.keyframeTransitionView.center.x, CGRectGetHeight(self.view.frame)-64-CGRectGetHeight(_keyframeTransitionView.frame)*.5)];
        animation.duration = 2.0;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        animation.timingFunction = [[CAMediaTimingFunction new] performSelector:NSSelectorFromString([_timing titleForState:UIControlStateNormal])];
#pragma clang diagnostic pop
        [_keyframeTransitionView.layer addAnimation:[CAKeyframeAnimation animationWithBasic:animation usingValuesFunction:[CAMediaTimingFunction easeOutElasticValuesFuntion]] forKey:@"position"];
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.transitionView.center.x, CGRectGetHeight(_transitionView.frame)*.5+64)];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.transitionView.center.x, CGRectGetHeight(self.view.frame)-64-CGRectGetHeight(_transitionView.frame)*.5)];
        // [_transitionView.layer addAnimation:animation forKey:@"position"];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"easeInOutElastic" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_transitionView.layer removeAllAnimations];
        [_keyframeTransitionView.layer removeAllAnimations];
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.keyframeTransitionView.center.x, CGRectGetHeight(_keyframeTransitionView.frame)*.5+64)];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.keyframeTransitionView.center.x, CGRectGetHeight(self.view.frame)-64-CGRectGetHeight(_keyframeTransitionView.frame)*.5)];
        animation.duration = 2.0;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        animation.timingFunction = [[CAMediaTimingFunction new] performSelector:NSSelectorFromString([_timing titleForState:UIControlStateNormal])];
#pragma clang diagnostic pop
        [_keyframeTransitionView.layer addAnimation:[CAKeyframeAnimation animationWithBasic:animation usingValuesFunction:[CAMediaTimingFunction easeInOutElasticValuesFuntion]] forKey:@"position"];
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.transitionView.center.x, CGRectGetHeight(_transitionView.frame)*.5+64)];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.transitionView.center.x, CGRectGetHeight(self.view.frame)-64-CGRectGetHeight(_transitionView.frame)*.5)];
        // [_transitionView.layer addAnimation:animation forKey:@"position"];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"easeInBounce" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_transitionView.layer removeAllAnimations];
        [_keyframeTransitionView.layer removeAllAnimations];
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.keyframeTransitionView.center.x, CGRectGetHeight(_keyframeTransitionView.frame)*.5+64)];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.keyframeTransitionView.center.x, CGRectGetHeight(self.view.frame)-64-CGRectGetHeight(_keyframeTransitionView.frame)*.5)];
        animation.duration = 2.0;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        animation.timingFunction = [[CAMediaTimingFunction new] performSelector:NSSelectorFromString([_timing titleForState:UIControlStateNormal])];
#pragma clang diagnostic pop
        [_keyframeTransitionView.layer addAnimation:[CAKeyframeAnimation animationWithBasic:animation usingValuesFunction:[CAMediaTimingFunction easeInBounceValuesFuntion]] forKey:@"position"];
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.transitionView.center.x, CGRectGetHeight(_transitionView.frame)*.5+64)];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.transitionView.center.x, CGRectGetHeight(self.view.frame)-64-CGRectGetHeight(_transitionView.frame)*.5)];
        [_transitionView.layer addAnimation:animation forKey:@"position"];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"easeOutBounce" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_transitionView.layer removeAllAnimations];
        [_keyframeTransitionView.layer removeAllAnimations];
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.keyframeTransitionView.center.x, CGRectGetHeight(_keyframeTransitionView.frame)*.5+64)];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.keyframeTransitionView.center.x, CGRectGetHeight(self.view.frame)-64-CGRectGetHeight(_keyframeTransitionView.frame)*.5)];
        animation.duration = 2.0;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        animation.timingFunction = [[CAMediaTimingFunction new] performSelector:NSSelectorFromString([_timing titleForState:UIControlStateNormal])];
#pragma clang diagnostic pop
        [_keyframeTransitionView.layer addAnimation:[CAKeyframeAnimation animationWithBasic:animation usingValuesFunction:[CAMediaTimingFunction easeOutBounceValuesFuntion]] forKey:@"position"];
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.transitionView.center.x, CGRectGetHeight(_transitionView.frame)*.5+64)];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.transitionView.center.x, CGRectGetHeight(self.view.frame)-64-CGRectGetHeight(_transitionView.frame)*.5)];
        // [_transitionView.layer addAnimation:animation forKey:@"position"];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"easeInOutBounce" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_transitionView.layer removeAllAnimations];
        [_keyframeTransitionView.layer removeAllAnimations];
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.keyframeTransitionView.center.x, CGRectGetHeight(_keyframeTransitionView.frame)*.5+64)];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.keyframeTransitionView.center.x, CGRectGetHeight(self.view.frame)-64-CGRectGetHeight(_keyframeTransitionView.frame)*.5)];
        animation.duration = 2.0;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        animation.timingFunction = [[CAMediaTimingFunction new] performSelector:NSSelectorFromString([_timing titleForState:UIControlStateNormal])];
#pragma clang diagnostic pop
        [_keyframeTransitionView.layer addAnimation:[CAKeyframeAnimation animationWithBasic:animation usingValuesFunction:[CAMediaTimingFunction easeInOutBounceValuesFuntion]] forKey:@"position"];
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.transitionView.center.x, CGRectGetHeight(_transitionView.frame)*.5+64)];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.transitionView.center.x, CGRectGetHeight(self.view.frame)-64-CGRectGetHeight(_transitionView.frame)*.5)];
        // [_transitionView.layer addAnimation:animation forKey:@"position"];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"gravity" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_transitionView.layer removeAllAnimations];
        [_keyframeTransitionView.layer removeAllAnimations];
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.keyframeTransitionView.center.x, CGRectGetHeight(_keyframeTransitionView.frame)*.5+64)];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.keyframeTransitionView.center.x, CGRectGetHeight(self.view.frame)-64-CGRectGetHeight(_keyframeTransitionView.frame)*.5)];
        animation.duration = 2.0;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        animation.timingFunction = [[CAMediaTimingFunction new] performSelector:NSSelectorFromString([_timing titleForState:UIControlStateNormal])];
#pragma clang diagnostic pop
        [_keyframeTransitionView.layer addAnimation:[CAKeyframeAnimation animationWithBasic:animation usingValuesFunction:[CAMediaTimingFunction gravityValuesFunction]] forKey:@"position"];
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.transitionView.center.x, CGRectGetHeight(_transitionView.frame)*.5+64)];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.transitionView.center.x, CGRectGetHeight(self.view.frame)-64-CGRectGetHeight(_transitionView.frame)*.5)];
        // [_transitionView.layer addAnimation:animation forKey:@"position"];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"decay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_transitionView.layer removeAllAnimations];
        [_keyframeTransitionView.layer removeAllAnimations];
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.keyframeTransitionView.center.x, CGRectGetHeight(_keyframeTransitionView.frame)*.5+64)];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.keyframeTransitionView.center.x, CGRectGetHeight(self.view.frame)-64-CGRectGetHeight(_keyframeTransitionView.frame)*.5)];
        animation.duration = 2.0;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        animation.timingFunction = [[CAMediaTimingFunction new] performSelector:NSSelectorFromString([_timing titleForState:UIControlStateNormal])];
#pragma clang diagnostic pop
        AXDecayAnimation *decay = [AXDecayAnimation animationWithKeyPath:@"position.y"];
        decay.fromValue = @(CGRectGetHeight(_keyframeTransitionView.frame)*.5+64);
        decay.velocity = 500;
        decay.deceleration = 0.998;
        decay.removedOnCompletion = NO;
        decay.fillMode = kCAFillModeForwards;

        [_keyframeTransitionView.layer addAnimation:decay forKey:@"position"];
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.transitionView.center.x, CGRectGetHeight(_transitionView.frame)*.5+64)];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.transitionView.center.x, CGRectGetHeight(self.view.frame)-64-CGRectGetHeight(_transitionView.frame)*.5)];
        // [_transitionView.layer addAnimation:animation forKey:@"position"];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:NULL]];
    [self presentViewController:alert animated:YES completion:NULL];
}

- (IBAction)timing:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Timing functions." message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"defaultTimingFunction" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [sender setTitle:action.title forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"linear" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [sender setTitle:action.title forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"easeIn" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [sender setTitle:action.title forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"easeOut" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [sender setTitle:action.title forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"easeInOut" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [sender setTitle:action.title forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"easeInSine" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [sender setTitle:action.title forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"easeOutSine" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [sender setTitle:action.title forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"easeInOutSine" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [sender setTitle:action.title forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"easeInQuad" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [sender setTitle:action.title forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"easeOutQuad" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [sender setTitle:action.title forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"easeInOutQuad" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [sender setTitle:action.title forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"easeInCubic" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [sender setTitle:action.title forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"easeOutCubic" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [sender setTitle:action.title forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"easeInOutCubic" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [sender setTitle:action.title forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"easeInQuart" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [sender setTitle:action.title forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"easeOutQuart" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [sender setTitle:action.title forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"easeInOutQuart" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [sender setTitle:action.title forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"easeInQuint" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [sender setTitle:action.title forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"easeOutQuint" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [sender setTitle:action.title forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"easeInOutQuint" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [sender setTitle:action.title forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"easeInExpo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [sender setTitle:action.title forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"easeOutExpo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [sender setTitle:action.title forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"easeInOutExpo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [sender setTitle:action.title forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"easeInCirc" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [sender setTitle:action.title forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"easeInCirc" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [sender setTitle:action.title forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"easeOutCirc" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [sender setTitle:action.title forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"easeInOutCirc" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [sender setTitle:action.title forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"easeInBack" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [sender setTitle:action.title forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"easeOutBack" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [sender setTitle:action.title forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"easeInOutBack" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [sender setTitle:action.title forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:NULL]];
    [self presentViewController:alert animated:YES completion:NULL];
}
@end

@implementation CAMediaTimingFunction (ExtendsInstance)
- (instancetype)defaultTimingFunction {
    return [self.class defaultTimingFunction];
}

- (instancetype)linear {
    return [self.class linear];
}

- (instancetype)easeIn {
    return [self.class easeIn];
}

- (instancetype)easeOut {
    return [self.class easeOut];
}

- (instancetype)easeInOut {
    return [self.class easeInOut];
}
/*
- (instancetype)decay {
    return [self.class decay];
} */

- (instancetype)easeInSine {
    return [self.class easeInSine];
}

- (instancetype)easeOutSine {
    return [self.class easeOutSine];
}

- (instancetype)easeInOutSine {
    return [self.class easeInOutSine];
}

- (instancetype)easeInQuad {
    return [self.class easeInQuad];
}

- (instancetype)easeOutQuad {
    return [self.class easeOutQuad];
}

- (instancetype)easeInOutQuad {
    return [self.class easeInOutQuad];
}

- (instancetype)easeInCubic {
    return [self.class easeInCubic];
}

- (instancetype)easeOutCubic {
    return [self.class easeOutCubic];
}

- (instancetype)easeInOutCubic {
    return [self.class easeInOutCubic];
}

- (instancetype)easeInQuart {
    return [self.class easeInQuart];
}

- (instancetype)easeOutQuart {
    return [self.class easeOutQuart];
}

- (instancetype)easeInOutQuart {
    return [self.class easeInOutQuart];
}

- (instancetype)easeInQuint {
    return [self.class easeInQuint];
}

- (instancetype)easeOutQuint {
    return [self.class easeOutQuint];
}

- (instancetype)easeInOutQuint {
    return [self.class easeInOutQuint];
}

- (instancetype)easeInExpo {
    return [self.class easeInExpo];
}

- (instancetype)easeOutExpo {
    return [self.class easeOutExpo];
}

- (instancetype)easeInOutExpo {
    return [self.class easeInOutExpo];
}

- (instancetype)easeInCirc {
    return [self.class easeInCirc];
}

- (instancetype)easeOutCirc {
    return [self.class easeOutCirc];
}

- (instancetype)easeInOutCirc {
    return [self.class easeInOutCirc];
}

- (instancetype)easeInBack {
    return [self.class easeInBack];
}

- (instancetype)easeOutBack {
    return [self.class easeOutBack];
}

- (instancetype)easeInOutBack {
    return [self.class easeInOutBack];
}
@end
