//
//  ImageAnimationViewController.m
//  AXAnimationChain
//
//  Created by devedbox on 2017/1/14.
//  Copyright © 2017年 devedbox. All rights reserved.
//

#import "ImageAnimationViewController.h"
#import "UIView+AnimationChain.h"
#import "UIView+ChainAnimator.h"

@interface ImageAnimationViewController ()
/// Image view.
@property(weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ImageAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)animate:(id)sender {
    [_imageView.layer removeAllAnimations];
    _imageView.after(0.5).imageTo([UIImage imageNamed:@"image2"]).duration(0.8).animate();
}

@end
