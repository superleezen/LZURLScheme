//
//  SDKWebViewController.m
//  LZURLScheme_Example
//
//  Created by lizheng on 2018/11/24.
//  Copyright © 2018年 emailoflizheng@126.com. All rights reserved.
//

#import "SDKWebViewController.h"
#import "SDKTools.h"
#import "SDKNavigationController.h"

@interface SDKWebViewController ()

@property (strong, nonatomic)   UIToolbar *toolbar;

@end

@implementation SDKWebViewController

#pragma mark - private

- (void)goBack{
    [self.webView goBack];
}

- (void)goForward{
    [self.webView goForward];
}


- (void)refresh{
    [self.webView reload];
}

- (void)stop{
    if (self.webView.loading) {
        [self.webView stopLoading];
    } else {
        [self.navigator popViewControllerAnimated:YES];
    }
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self reloadToolBar];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = title;
    [self reloadToolBar];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self reloadToolBar];
}

#pragma mark - public

- (void)loadRequest{
    if (![@"http" isEqualToString:[self.url protocol]] && ![@"https" isEqualToString:[self.url protocol]]) {
        self.url = [NSURL URLWithString:[self.params objectForKey:@"url"]];
    }
    NSMutableURLRequest *requestObj = [NSMutableURLRequest requestWithURL:self.url];
    [self.webView loadRequest:requestObj];
}

- (void)reloadToolBar{
    if (self.webView.canGoBack) {
        [[[self.toolbar items] objectAtIndex:0] setEnabled:YES];
    } else {
        [[[self.toolbar items] objectAtIndex:0] setEnabled:NO];
    }
    if (self.webView.canGoForward) {
        [[[self.toolbar items] objectAtIndex:2] setEnabled:YES];
    } else {
        [[[self.toolbar items] objectAtIndex:2] setEnabled:NO];
    }
    if (self.webView.loading) {
        [[[self.toolbar items] objectAtIndex:6] setEnabled:YES];
        [[[self.toolbar items] objectAtIndex:4] setEnabled:NO];
    } else {
        [[[self.toolbar items] objectAtIndex:6] setEnabled:YES];
        [[[self.toolbar items] objectAtIndex:4] setEnabled:YES];
    }
}

#pragma mark -
#pragma mark Constructor And Destructor
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    [self loadRequest];
}

- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self initWebView];
    [self initToolBar];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.toolbar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.toolbar attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.toolbar attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.toolbar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:49]];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.toolbar attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
}

- (void)initWebView{
    if (nil == self.webView) {
        self.webView = [[UIWebView alloc] init];
        self.webView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
        self.webView.multipleTouchEnabled = NO;
        self.webView.scalesPageToFit = YES;
        self.webView.delegate = self;
        self.webView.autoresizesSubviews = YES;
        self.webView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:self.webView];
    }
}

- (void)initToolBar{
    if (nil == self.toolbar) {
        self.toolbar = [[UIToolbar alloc] init];
        self.toolbar.tintColor = [UIColor darkGrayColor];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:[[[NSBundle bundleForClass:[SDKWebViewController class]] resourcePath] stringByAppendingPathComponent:@"goBackItem@2x.png"]]
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(goBack)];
        
        UIBarButtonItem *fowardItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:[[[NSBundle bundleForClass:[SDKWebViewController class]] resourcePath] stringByAppendingPathComponent:@"goForwardItem@2x.png"]]
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(goForward)];
        UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                     target:self
                                                                                     action:@selector(refresh)];
        UIBarButtonItem *stopItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                                                  target:self
                                                                                  action:@selector(stop)];
        backItem.enabled = NO;
        fowardItem.enabled = NO;
        refreshItem.enabled = NO;
        stopItem.enabled = NO;
        [self.toolbar setItems:[NSArray arrayWithObjects:
                                backItem,
                                [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil],
                                fowardItem,
                                [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil],
                                refreshItem,
                                [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil],
                                stopItem,
                                nil
                                ]];
        self.toolbar.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:self.toolbar];
        
        //        __weak __block typeof(self) wSelf = self;
        //        [self.toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.and.right.and.bottom.equalTo(wSelf.view);
        //            make.height.mas_equalTo(@49);
        //        }];
    }
}

@end
