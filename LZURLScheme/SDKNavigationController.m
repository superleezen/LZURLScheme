//
//  SDKNavigationController.m
//  LZURLScheme_Example
//
//  Created by lizheng on 2018/11/24.
//  Copyright © 2018年 emailoflizheng@126.com. All rights reserved.
//

#import "SDKNavigationController.h"
#import<QuartzCore/QuartzCore.h>
#import "SDKViewController.h"
#import "SDKWebViewController.h"

@interface SDKNavigationController ()

@end

@implementation SDKNavigationController

#pragma mark - init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithRootViewControllerURL:(NSURL *)url{
    self = [super init];
    if (self) {
        SDKViewController *rootVC = [self viewControllerForURL:url withQuery:nil];
        self = [self initWithRootViewController:rootVC];
        return self;
    }
    return nil;
}

- (id)initWithRootViewControllerURL:(NSURL *)url withQuery:(NSDictionary *)query{
    self = [super init];
    if (self) {
        SDKViewController *rootVC = [self viewControllerForURL:url withQuery:query];
        self = [self initWithRootViewController:rootVC];
        return self;
    }
    return nil;
}

- (id)initWithRootViewController:(SDKViewController *)aRootViewController{
    self = [super initWithRootViewController:aRootViewController];
    if (self) {
        aRootViewController.navigator = self;
        self.rootViewController = aRootViewController;
        return self;
    }
    return nil;
}

- (void)viewDidLoad{
    [super viewDidLoad];
}

#pragma mark - actions
- (SDKViewController *)viewControllerForURL:(NSURL *)url withQuery:(NSDictionary *)query{
//    NSString *urlString = [NSString stringWithFormat:@"%@://%@", [url scheme], [url host]];
    SDKViewController * viewController = nil;
    if ([self URLAvailable:url]) {
        NSString *className = url.host;
        Class class = NSClassFromString(className);
        if (nil == query) {
            viewController = (SDKViewController *)[[class alloc] initWithURL:url];
        }
        else {
            viewController = (SDKViewController *)[[class alloc] initWithURL:url query:query];
        }
        viewController.navigator = self;
    } else if ([self webURLAvailable:url]) {
        NSString *className = url.host;
        Class class = NSClassFromString(className);
        viewController = (SDKWebViewController *)[[class alloc] initWithURL:url query:query];
        viewController.navigator = self;
    }
    return viewController;
}

- (BOOL)webURLAvailable:(NSURL *)url{
    NSString *scheme = url.scheme;
    return [scheme isEqualToString:@"http"] || [scheme isEqualToString:@"https"];
}

- (BOOL)URLAvailable:(NSURL *)url{
    NSString *scheme = url.scheme;
    NSString *className = url.host;
    return [scheme isEqualToString:@"page"] && NSClassFromString(className);
}

- (void)openString:(NSString*)str{
    [self openURL:[NSURL URLWithString:str] withQuery:nil];
    [self setNavigationBarHidden:NO animated:YES];
}

- (void)openURL:(NSURL *)url{
    [self openURL:url withQuery:nil];
    [self setNavigationBarHidden:NO animated:YES];
}

- (void)openString:(NSString *)str withQuery:(NSDictionary *)query animate:(BOOL)animate{
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    [self openURL:url withQuery:query animate:animate];
}

- (void)presentURL:(NSURL *)url{
    [self presentURL:url withQuery:nil];
}

- (void)presentURL:(NSURL *)url withQuery:(NSDictionary*)query{
    SDKViewController *lastViewController = (SDKViewController *)[self.viewControllers lastObject];
    SDKViewController *viewController = [self viewControllerForURL:url withQuery:query];
    if ([lastViewController shouldOpenViewControllerWithURL:url] && viewController) {
        SDKNavigationController* presentNavi = [[SDKNavigationController alloc] initWithRootViewController:viewController];
        [lastViewController willOpenViewController:viewController];
        [self presentViewController:presentNavi animated:YES completion:NULL];
        [viewController presentFromViewControllerWithURL:lastViewController.url];
        [viewController openedFromViewControllerWithURL:lastViewController.url];
    }
}

- (void)presentString:(NSString *)string withQuery:(NSDictionary*)query{
    [self presentURL:[NSURL URLWithString:string] withQuery:query ];
}

- (void)presentString:(NSString *)str{
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    [self presentURL:url];
}

- (void)cancel{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)back{
    [self popViewControllerAnimated:YES];
}

- (void)openURL:(NSURL *)url withQuery:(NSDictionary *)query{
    [self openURL:url withQuery:query animate:YES];
}

- (void)openURL:(NSURL *)url withQuery:(NSDictionary *)query animate:(BOOL)animate{
    SDKViewController *lastViewController = (SDKViewController *)[self.viewControllers lastObject];
    SDKViewController *viewController = [self viewControllerForURL:url withQuery:query];
    if (viewController == nil) {
        // 不是内部导航，也不是http的页面，则打开app
        [[UIApplication sharedApplication] openURL:url];
        return;
    }
    
    if ([lastViewController shouldOpenViewControllerWithURL:url] && viewController) {
        [lastViewController willOpenViewController:viewController];
        [self pushViewController:viewController animated:animate];
        [viewController pushFromViewControllerWithURL:lastViewController.url];
        [viewController openedFromViewControllerWithURL:lastViewController.url];
    }
}

// 跳转到某一个url viewController，如果界面栈里有的话。
- (BOOL)popToNearestViewControllerWithURL:(NSURL*)url{
    return [self popToNearestViewControllerWithURL:url animate:YES];
}

- (BOOL)popToNearestViewControllerWithURL:(NSURL*)url animate:(BOOL)animate{
    NSString *urlString = [NSString stringWithFormat:@"%@://%@", [url scheme], [url host]];
    SDKViewController * viewController = nil;
    if ([self URLAvailable:url]) {
        NSString *className = url.host;
        Class class = NSClassFromString(className);
        NSInteger count = self.viewControllers.count;
        for (NSInteger i = count - 1 ; i >= 0; i--) {
            SDKViewController *vc = [self.viewControllers objectAtIndex:i];
            if([vc isKindOfClass:class]) {
                viewController = vc;
                break;
            }
        }
    }
    if (viewController) {
        [self popToViewController:viewController animated:animate];
        return YES;
    }
    return NO;
}

- (BOOL)popToFarestViewControllerWithURL:(NSURL*)url{
    return [self popToFarestViewControllerWithURL:url animate:YES];
}

- (BOOL)popToFarestViewControllerWithURL:(NSURL*)url animate:(BOOL)animate{
    NSString *urlString = [NSString stringWithFormat:@"%@://%@", [url scheme], [url host]];
    SDKViewController * viewController = nil;
    if ([self URLAvailable:url]) {
        NSString *className = url.host;
        Class class = NSClassFromString(className);
        for (SDKViewController* vc in self.viewControllers) {
            if([vc isKindOfClass:class]) {
                viewController = vc;
                break;
            }
        }
    }
    if (viewController) {
        [self popToViewController:viewController animated:animate];
        return YES;
    }
    return NO;
}


@end
