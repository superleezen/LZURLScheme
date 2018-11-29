//
//  BViewController.m
//  LZURLScheme_Example
//
//  Created by lizheng on 2018/11/28.
//  Copyright © 2018年 emailoflizheng@126.com. All rights reserved.
//

#import "BViewController.h"

@interface BViewController ()

@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"BViewController";
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self setLeftTitle:@"关闭"];
    [self setLeftTitle:@"关闭" imageName:@"" highlighted:@"" completeBlock:^(UIButton *btn) {
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }];
    
//    UIButton *left = [[UIButton alloc] init];
//    left.titleLabel.font = [UIFont systemFontOfSize:15];
//    [left setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [left setTitle:@"关闭" forState:UIControlStateNormal];
//    [left addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:left];
//    [self.navigationItem setLeftBarButtonItem:leftItem];
    
}

//- (void)close{
//    [self dismissViewControllerAnimated:YES completion:NULL];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
