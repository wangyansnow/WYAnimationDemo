//
//  ViewController.m
//  WYCAAnimationDemo
//
//  Created by 王俨 on 16/10/28.
//  Copyright © 2016年 wangyan. All rights reserved.
//

#import "ViewController.h"


#define NSVALUEPOINT(x, y) [NSValue valueWithCGPoint:CGPointMake(x, y)]

@interface ViewController () <CAAnimationDelegate>

@property (weak, nonatomic) IBOutlet UIView *animationView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    NSLog(@"WY-develop");
    NSLog(@"minyan");
}

#pragma mark - ButtonClick
- (IBAction)positionAnimateClick {
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 400)];
    positionAnimation.delegate = self;
    positionAnimation.removedOnCompletion = NO;
    positionAnimation.fillMode = kCAFillModeForwards;

    [self.animationView.layer addAnimation:positionAnimation forKey:@"position"];
}

- (IBAction)rotateAnimateClick {
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    
    rotateAnimation.byValue = @(-M_PI);
    rotateAnimation.duration = 1.0;
    rotateAnimation.delegate = self;

    [self.animationView.layer addAnimation:rotateAnimation forKey:@"rotate"];
}

- (IBAction)scaleAnimateClick {
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.m34"];
    scaleAnimation.byValue = @1;

    [self.animationView.layer addAnimation:scaleAnimation forKey:@"scale"];
}

- (IBAction)keyFrameAnimateClick {
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];

    keyframeAnimation.values = @[NSVALUEPOINT(100, 200), NSVALUEPOINT(150, 200), NSVALUEPOINT(150, 300), NSVALUEPOINT(100, 300)];
    keyframeAnimation.duration = 2.0;

    [self.animationView.layer addAnimation:keyframeAnimation forKey:@"keyframe"];
    
}

- (IBAction)pathAnimateClick {
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(200, 200) radius:80.0 startAngle:0 endAngle:M_PI * 2 clockwise:YES].CGPath;
    pathAnimation.duration = 2.0;

    [self.animationView.layer addAnimation:pathAnimation forKey:@"path"];
}

- (IBAction)leftRightAnimateClick {
    CAKeyframeAnimation *leftRightAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];

    leftRightAnimation.values = @[@(-0.2), @0.2, @-0.2];
    leftRightAnimation.repeatCount = CGFLOAT_MAX;
    leftRightAnimation.duration = 0.5;

    [self.animationView.layer addAnimation:leftRightAnimation forKey:@"leftRight"];
}

- (IBAction)groupAnimate {
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];

    // 1.平移动画
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.toValue = NSVALUEPOINT(200, 400);

    // 2.缩放动画
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.byValue = @1;

    // 3.左右抖动动画
    CAKeyframeAnimation *leftRightAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    leftRightAnimation.values = @[@-0.2, @0.2, @-0.2];
    leftRightAnimation.repeatCount = CGFLOAT_MAX;
    leftRightAnimation.duration = 0.25;

    groupAnimation.animations = @[positionAnimation, scaleAnimation, leftRightAnimation];
    groupAnimation.duration = 2.0;

    [self.animationView.layer addAnimation:groupAnimation forKey:@"group"];
}

- (IBAction)transitionAnimateClick {
    CATransition *transition = [CATransition animation];

    /**
     1.苹果定义的常量
     kCATransitionFade 交叉淡化过渡
     kCATransitionMoveIn 新视图移到旧视图上面
     kCATransitionPush 新视图把旧视图推出去
     kCATransitionReveal 将旧视图移开,显示下面的新视图
     2.用字符串表示
     pageCurl 向上翻一页
     pageUnCurl 向下翻一页
     rippleEffect 滴水效果
     suckEffect 收缩效果，如一块布被抽走
     cube 立方体效果
     oglFlip 上下翻转效果
     */
//    transition.type = @"pageCurl";
        transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromLeft;
    transition.duration = 1.0;

    self.animationView.backgroundColor = [UIColor darkGrayColor];
    [self.animationView.layer addAnimation:transition forKey:@"transition"];
}

- (IBAction)restoreBtnClick {
    self.animationView.backgroundColor = [UIColor colorWithRed:102 / 255.0 green:204 / 255.0 blue:255 / 255.0 alpha:1];
    
}


#pragma mark - CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim {
    NSLog(@"start = %@", NSStringFromCGPoint(self.animationView.center));
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"end = %@", NSStringFromCGPoint(self.animationView.center));
}




@end
