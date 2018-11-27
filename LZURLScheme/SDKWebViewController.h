//
//  SDKWebViewController.h
//  LZURLScheme_Example
//
//  Created by lizheng on 2018/11/24.
//  Copyright © 2018年 emailoflizheng@126.com. All rights reserved.
//

#import "SDKViewController.h"


@interface SDKWebViewController : SDKViewController<UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;
- (void)loadRequest;
- (void)reloadToolBar;

@end

