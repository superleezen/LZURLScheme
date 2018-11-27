//
//  SDKNavigationController.h
//  LZURLScheme_Example
//
//  Created by lizheng on 2018/11/24.
//  Copyright © 2018年 emailoflizheng@126.com. All rights reserved.
//

#import "LZNavigationController.h"


@class SDKViewController;
@interface SDKNavigationController : LZNavigationController

@property (strong, nonatomic) SDKViewController *rootViewController;
- (void)openString:(NSString*)str;
- (void)openString:(NSString *)str withQuery:(NSDictionary *)query animate:(BOOL)animate;
- (void)openURL:(NSURL *)url withQuery:(NSDictionary *)query animate:(BOOL)animate;
- (void)openURL:(NSURL *)url withQuery:(NSDictionary *)query;
- (void)openURL:(NSURL *)url;
- (void)presentURL:(NSURL *)url;
- (void)presentURL:(NSURL *)url withQuery:(NSDictionary*)query;
- (void)presentString:(NSString *)url withQuery:(NSDictionary*)query;
- (void)presentString:(NSString *)str;
// 跳转到某一个url viewController，如果界面栈里有的话。
- (BOOL)popToNearestViewControllerWithURL:(NSURL*)url;
- (BOOL)popToNearestViewControllerWithURL:(NSURL*)url animate:(BOOL)animate;
- (BOOL)popToFarestViewControllerWithURL:(NSURL*)url;
- (BOOL)popToFarestViewControllerWithURL:(NSURL*)url animate:(BOOL)animate;
- (SDKViewController *)viewControllerForURL:(NSURL *)url withQuery:(NSDictionary *)query;


- (id)initWithRootViewControllerURL:(NSURL *)url;
- (id)initWithRootViewControllerURL:(NSURL *)url withQuery:(NSDictionary *)query;

@end

