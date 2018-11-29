//
//  LZBaseViewController.m
//  LZURLScheme_Example
//
//  Created by lizheng on 2018/11/28.
//  Copyright © 2018年 emailoflizheng@126.com. All rights reserved.
//

#import "LZBaseViewController.h"

@interface LZBaseViewController ()

@end

@implementation LZBaseViewController

/////如果子类中重写了dealloc  需要注意observer的释放
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setBackTitle];
}

/**
 *  设置返回按钮
 */
-(void)setBackTitle{
    [self setLeftTitle:[NSString stringWithFormat:@" 返回"] imageName:@"fanhuilv" highlighted:@"fanhuilv"];
}

//轻拍view
-(void)tapOfView{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoader)];
    [self.view addGestureRecognizer:tap];
}

-(void)hideKeyBoader{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

-(void)leftEvent:(UIButton *)button{
    if (self.navigationController.viewControllers.count>1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if(self.navigationController.viewControllers.count == 1 || self.navigationController == nil){
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}


@end
