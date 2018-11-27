//
//  SDKViewController.m
//  LZURLScheme_Example
//
//  Created by lizheng on 2018/11/24.
//  Copyright © 2018年 emailoflizheng@126.com. All rights reserved.
//

#import "SDKViewController.h"

#import "SDKCommandManager.h"
#import "SDKTools.h"

@interface SDKViewController ()

@end

@implementation SDKViewController

#pragma mark - init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithURL:(NSURL *)url{
//    self = [super initWithNibName:nil bundle:nil];
    self = [super init];
    if (self) {
        self.url = url;
        self.params = [url params];
    }
    return self;
}

- (id)initWithURL:(NSURL *)url query:(NSDictionary *)aQuery {
//    self = [super initWithNibName:nil bundle:nil];
    self = [super init];
    if (self) {
        self.url = url;
        self.params = [url params];
        self.query = aQuery;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
}

-(void)backAction{
    [self.navigator popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    
}
#pragma mark - before / after open

- (BOOL)shouldOpenViewControllerWithURL:(NSURL *)url{
    return YES;
}

-(void)willOpenViewController:(SDKViewController*)vc{
    
}

- (void)openedFromViewControllerWithURL:(NSURL *)url{
    
}

- (void)presentFromViewControllerWithURL:(NSURL *)url{
    
}

- (void)pushFromViewControllerWithURL:(NSURL*)url{
    
}

#pragma mark - webViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    // 如果是指令类型URL，则直接调用指令url管理器
    if ([[[request URL] scheme] isEqualToString:@"wddo"]) {
        // 生成指令url管理器。
        [[[SDKCommandManager alloc] init] execURL:[request URL]];
        return NO;
    }
    if ([[[request URL] scheme] isEqualToString:@"page"]) {
        // 如果是跳转URL，直接调用url vc mapping管理器。
        [self.navigator openURL:[request URL]];
        return NO;
    }
    return YES;
}

@end
