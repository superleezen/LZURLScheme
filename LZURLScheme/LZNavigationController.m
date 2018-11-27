//
//  LZUINavigationController.m
//  LZURLScheme_Example
//
//  Created by lizheng on 2018/11/24.
//  Copyright © 2018年 emailoflizheng@126.com. All rights reserved.
//

#import "LZNavigationController.h"
#import <QuartzCore/QuartzCore.h>
#import "SDKViewController.h"

@interface LZNavigationController ()<UIGestureRecognizerDelegate>
{
    CGPoint startTouch;
    UIImageView *lastScreenShotView;
    UIView *blackMask;
}

@property (nonatomic,retain) UIView *backgroundView;
@property (nonatomic,retain) NSMutableArray *screenShotsList;
@property (nonatomic,assign) BOOL isMoving;

@end

@implementation LZNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.screenShotsList = [[NSMutableArray alloc]initWithCapacity:2];
    self.canDragBack = YES;
    UIImageView *shadowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"navigationbar"]];
    shadowImageView.frame = CGRectMake(-10, 0, 10, self.view.frame.size.height);
    [self.view addSubview:shadowImageView];
    //    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(paningGestureReceive:)];
    //    recognizer.delegate = self;
    //    [recognizer delaysTouchesBegan];
    //    [self.view addGestureRecognizer:recognizer];
    UIImage* backImg = [[UIImage imageNamed:@"navigationbar"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    [self.navigationBar setBackgroundImage:backImg forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.translucent = NO;
    [self.navigationBar setBarStyle:(UIBarStyleDefault)];
    self.interactivePopGestureRecognizer.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
        NSArray *list=self.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView=(UIImageView *)obj;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2=(UIImageView *)obj2;
                        imageView2.hidden=YES;
                    }
                }
            }
        }
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //    [self.screenShotsList addObject:[self capture]];
    [super pushViewController:viewController animated:animated];
}

// override the pop method
- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    [self.screenShotsList removeLastObject];
    return [super popViewControllerAnimated:animated];
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (self.viewControllers.count == 1){//关闭主界面的右滑返回
        return NO;
    }else if(self.isCanGestureRecognizerBack){
        return YES;
    }else{
        return NO;
    }
}

-(BOOL)isCanGestureRecognizerBack{
    UIViewController *viewController =  [self.viewControllers lastObject];
    if ([viewController isKindOfClass:[SDKViewController class]]) {
        return ((SDKViewController*)viewController).isCanGestureRecognizerBack;
    }else{
        return NO;
    }
}

@end
