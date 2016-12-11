//
//  ViewController.m
//  AXAnimationChain
//
//  Created by devedbox on 2016/12/10.
//  Copyright © 2016年 devedbox. All rights reserved.
//

#import "ViewController.h"
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
    NSLog(@"%@", self.view.animationChain.basic);
    
    
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
//    _transitionView.animationChain.basic.property(@"position").toValue([NSValue valueWithCGPoint:CGPointMake(100, 300)]).easeOut.duration(0.5).combineWith(_transitionView.animationChain.spring.property(@"bounds").toValue([NSValue valueWithCGRect:CGRectMake(0, 0, 100, 100)]).duration(1.0).combineWith(_transitionView.animationChain.basic.property(@"transform.rotation").toValue(@(M_PI_4)).easeInOut.duration(2.0).nextTo(_transitionView.animationChain.basic.property(@"position").toValue([NSValue valueWithCGPoint:self.view.center]).duration(2.0)))).animate();
//    _transitionView.animationChain.basic.property(@"position").toValue([NSValue valueWithCGPoint:CGPointMake(100, 300)]).easeOut.duration(0.5).combineWith(_transitionView.animationChain.spring.property(@"bounds").toValue([NSValue valueWithCGRect:CGRectMake(0, 0, 100, 100)]).duration(1.0).combineWith(_transitionView.animationChain.basic.property(@"transform.rotation").toValue(@(M_PI_4)).easeInOut.duration(1.5))).animate();

//    _transitionView.animationChain.basic.property(@"position").toValue([NSValue valueWithCGPoint:CGPointMake(100, 300)]).duration(0.5).nextTo(_transitionView.animationChain.basic).property(@"transform.rotation").toValue(@(M_PI_4)).easeInOut.duration(1.5).nextTo(_transitionView.animationChain.basic).property(@"bounds").toValue([NSValue valueWithCGRect:CGRectMake(0, 0, 100, 100)]).duration(2.0).nextTo(_transitionView.animationChain.basic).property(@"position").toValue([NSValue valueWithCGPoint:self.view.center]).duration(2.0).animate();
    
    _transitionView.animationChain.basic.property(@"position").toValue([NSValue valueWithCGPoint:CGPointMake(100, 300)]).easeOut.duration(0.5).combineWith(_transitionView.animationChain.spring.property(@"bounds")).toValue([NSValue valueWithCGRect:CGRectMake(0, 0, 100, 100)]).duration(1.0).combineWith(_transitionView.animationChain.spring.property(@"transform.rotation")).toValue(@(M_PI_4)).duration(2.0).nextTo(_transitionView.animationChain.basic).property(@"position").toValue([NSValue valueWithCGPoint:self.view.center]).duration(2.0).animate();
}
@end
