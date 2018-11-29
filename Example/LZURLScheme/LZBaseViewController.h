//
//  LZBaseViewController.h
//  LZURLScheme_Example
//
//  Created by lizheng on 2018/11/28.
//  Copyright © 2018年 emailoflizheng@126.com. All rights reserved.
//

#import "SDKViewController.h"
#import "UIViewController+CustomItem.h"
NS_ASSUME_NONNULL_BEGIN

@interface LZBaseViewController : SDKViewController

//是否自动弹出键盘，默认NO
@property(nonatomic,assign)BOOL isAutoKeyBoder;
//通过此设置确定是否可以滑动返回上一页
@property(nonatomic,assign)BOOL isCanGestureRecognizerBack;

///轻拍收回键盘
-(void)tapOfView;
@end

NS_ASSUME_NONNULL_END
