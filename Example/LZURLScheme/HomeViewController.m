//
//  LMBaseViewController.m
//  LZURLScheme_Example
//
//  Created by lizheng on 2018/11/24.
//  Copyright © 2018年 emailoflizheng@126.com. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(100, 100, 100, 30);
    label.text = @"测试首页";
    [self.view addSubview:label];
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(100, 300, 200, 30);
    button.backgroundColor = [UIColor blueColor];
    [button setTitle:@"跳转A控制器" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(jumpA) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button0 = [[UIButton alloc] init];
    button0.frame = CGRectMake(100, 400, 200, 30);
    button0.backgroundColor = [UIColor blueColor];
    [button0 setTitle:@"跳转B控制器" forState:UIControlStateNormal];
    [button0 addTarget:self action:@selector(jumpB) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button0];
    
    UIButton *button1 = [[UIButton alloc] init];
    button1.frame = CGRectMake(100, 500, 200, 30);
    button1.backgroundColor = [UIColor blueColor];
    [button1 setTitle:@"跳转WebView" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(jumpWeb) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
}

- (void)jumpA{
    [self.navigator openString:@"page://AViewController" withQuery:@{@"name":@"HomeViewController"} animate:YES];
    
}

- (void)jumpB{
    [self.navigator presentString:@"page://BViewController" withQuery:@{@"name":@"HomeViewController"}];
    
}

- (void)jumpWeb{
    [self.navigator openString:@"https://www.baidu.com" withQuery:@{@"name":@"HomeViewController"} animate:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
