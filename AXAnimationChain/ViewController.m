//
//  ViewController.m
//  AXAnimationChain
//
//  Created by devedbox on 2016/12/10.
//  Copyright © 2016年 devedbox. All rights reserved.
//

#import "ViewController.h"
#import "UIView+ChainAnimator.h"
#import "UIView+AnimationChain.h"

@interface ViewController ()
/// Transition view.
@property(weak, nonatomic) IBOutlet UIView *transitionView;
/// Sublayer.
@property(weak, nonatomic) CALayer *sublayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /*
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    layer.frame = CGRectMake(0, 0, 20, 20);
    [_transitionView.layer addSublayer:layer];
    _sublayer = layer;
     */
//    [[[[self.view.animationChain beginWith:[CAAnimation animation]] nextTo:[CAKeyframeAnimation animation]] nextTo:[CAAnimationGroup animation]] combineWith:[CABasicAnimation animation]];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)changePositionOfLayerOfTransitionView:(id)sender {
    /*
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    CGPoint position = _sublayer.position;
    position.y += 10;
    _sublayer.position = position;
    [CATransaction commit];
     */
//    [[_transitionView.animationChain.basic property:@"--"] toValue:];
//    [[[[[_transitionView.animationChain.basic property:@"position"] toValue:[NSValue valueWithCGPoint:CGPointMake(100, 300)]] easeOut] duration:0.5] start];
//    [[[[[[_transitionView.animationChain.basic property:@"position"] toValue:[NSValue valueWithCGPoint:CGPointMake(100, 300)]] easeOut] duration:0.5] combineWith:[[[_transitionView.animationChain.spring property:@"bounds"] toValue:[NSValue valueWithCGRect:CGRectMake(0, 0, 100, 100)]] duration:1.5]] start];
    [_transitionView.layer removeAllAnimations];
//    _transitionView.animationChain.basic.property(@"position").toValue([NSValue valueWithCGPoint:CGPointMake(100, 300)]).easeOut.duration(0.5).combineWith(_transitionView.animationChain.spring.property(@"bounds").toValue([NSValue valueWithCGRect:CGRectMake(0, 0, 100, 100)]).duration(1.0).combineWith(_transitionView.animationChain.spring.property(@"transform.rotation").toValue(@(M_PI_4)).easeInOut.duration(2.0).nextTo(_transitionView.animationChain.basic.property(@"position").toValue([NSValue valueWithCGPoint:self.view.center]).duration(2.0)))).animate();
//    _transitionView.animationChain.basic.property(@"position").toValue([NSValue valueWithCGPoint:CGPointMake(100, 300)]).easeOut.duration(0.5).combineWith(_transitionView.animationChain.spring.property(@"bounds").toValue([NSValue valueWithCGRect:CGRectMake(0, 0, 100, 100)]).duration(1.0).combineWith(_transitionView.animationChain.basic.property(@"transform.rotation").toValue(@(M_PI_4)).easeInOut.duration(1.5))).animate();

//    _transitionView.animationChain.basic.property(@"position").toValue([NSValue valueWithCGPoint:CGPointMake(100, 300)]).duration(0.5).nextTo(_transitionView.animationChain.basic).property(@"transform.rotation").toValue(@(M_PI_4)).easeInOut.duration(1.5).nextTo(_transitionView.animationChain.basic).property(@"bounds").toValue([NSValue valueWithCGRect:CGRectMake(0, 0, 100, 100)]).duration(2.0).nextTo(_transitionView.animationChain.basic).property(@"position").toValue([NSValue valueWithCGPoint:self.view.center]).duration(2.0).animate();
    
    _transitionView.chainAnimator.basic.target(self).complete(@selector(complete:)).property(@"position").toValue([NSValue valueWithCGPoint:CGPointMake(100, self.view.center.y)]).easeInBack.duration(0.5).combineSpring.target(self).complete(@selector(complete:)).property(@"bounds").toValue([NSValue valueWithCGRect:CGRectMake(0, 0, 100, 100)]).duration(0.5).repeatCount(5).autoreverses.combineSpring.target(self).complete(@selector(complete:)).property(@"transform.rotation").toValue(@(M_PI_4)).duration(0.5).repeatCount(3).beginTime(1.0).autoreverses.nextToBasic.property(@"position").toValue([NSValue valueWithCGPoint:self.view.center]).duration(0.5).combineSpring.property(@"bounds").toValue([NSValue valueWithCGRect:CGRectMake(0, 0, 100, 100)]).duration(0.8).nextToBasic.property(@"transform.rotation").toValue(@(M_PI_4)).duration(1.0).completeWithBlock(nil).animate();
//    self.view.spring.backgroundColorTo([UIColor colorWithRed:1.000 green:0.988 blue:0.922 alpha:1.00]).animate();
    
//    _transitionView.animationChain.basic.property(@"position").toValue([NSValue valueWithCGPoint:CGPointMake(100, 300)]).easeInOut.duration(0.5).repeatCount(2).repeatDuration(.0).autoreverses.animate();
    
//    _transitionView.animationChain.spring.property(@"bounds").duration(1.5).toValue([NSValue valueWithCGRect:CGRectMake(0, 0, 100, 100)]).autoreverses.animate();
    
//    _transitionView.animationChain.basic.property(@"position").easeInOut.byValue([NSValue valueWithCGPoint:CGPointMake(0, 300)]).duration(1.0).combineWith(_transitionView.animationChain.spring.property(@"transform.scale")).beginTime(0.5).duration(1.0).toValue(@(0.5)).animate();
}

- (void)complete:(AXChainAnimator *)sender {
    NSLog(@"%@", sender);
}

- (IBAction)simpleHandler:(id)sender {
    [_transitionView.layer removeAllAnimations];
    _transitionView.spring.sizeTo(CGSizeMake(100, 100)).animate();
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Animation chains." message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"centerBy.sizeBy.cornerRadiusBy" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_transitionView.layer removeAllAnimations];
        _transitionView.spring.centerBy(CGPointMake(0, 100)).easeOut.spring.sizeBy(CGSizeMake(100, 100)).spring.cornerRadiusBy(4).animate();
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"centerYBy.rotateTo\n" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _transitionView.centerYBy(100.0).duration(1.0).rotateTo(M_PI*4).duration(1.0).animate();
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"centerYBy.rotateTo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _transitionView.centerYBy(100.0).duration(1.0).linear.rotateTo(M_PI*4).duration(1.0).linear.animate();
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [CATransaction begin];
        [_transitionView.layer removeAllAnimations];
        [CATransaction setAnimationDuration:0.4];
        [CATransaction commit];
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}
@end
