//
//  SDKViewController.h
//  LZURLScheme_Example
//
//  Created by lizheng on 2018/11/24.
//  Copyright © 2018年 emailoflizheng@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDKNavigationController.h"
@class SDKNavigationController;

@interface SDKViewController : UIViewController

//通过此设置确定是否可以滑动返回上一页
@property (nonatomic, assign)BOOL isCanGestureRecognizerBack;
@property (strong, nonatomic) NSURL                                     *url;
@property (unsafe_unretained, nonatomic) SDKNavigationController        *navigator;
@property (strong, nonatomic) NSDictionary                              *params;
@property (strong, nonatomic) NSDictionary                              *query;
@property (nonatomic, copy) void(^pcCompletionBlock)(void);
@property (nonatomic, copy) void(^fvCompletionBlock)(void);

- (id)initWithURL:(NSURL *)url;
- (id)initWithURL:(NSURL *)url query:(NSDictionary *)query;
- (BOOL)shouldOpenViewControllerWithURL:(NSURL *)url;
- (void)openedFromViewControllerWithURL:(NSURL *)url;
- (void)willOpenViewController:(SDKViewController*)vc;
- (void)presentFromViewControllerWithURL:(NSURL *)url; // 在某个界面弹出的时候回调，同时也会回调openedFromViewController
- (void)pushFromViewControllerWithURL:(NSURL*)url;
- (void)backAction;

@end

