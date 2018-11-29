//
//  UIViewController+CustomItem.h
//  LZURLScheme_Example
//
//  Created by lizheng on 2018/11/28.
//  Copyright © 2018年 emailoflizheng@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationItem+CustomItem.h"

@interface UIViewController (CustomItem)

/**
 *  设置右侧按钮样式
 *
 *  @param imageName        右侧按钮图片
 *  @param highlightedImage 右侧按钮高亮
 *
 *  @return return value description
 */
-(CustomBarItem*)setRightButtonNormalImageName:(NSString*)imageName highlighted:(NSString*)highlightedImage;
-(CustomBarItem*)setLeftButtonNormalImageName:(NSString*)imageName  highlighted:(NSString*)highlightedImage;
-(CustomBarItem*)setRightButtonTitle:(NSString*)title;

/**
 *  设置左侧按钮文字
 *
 *  @param title <#title description#>
 *
 *  @return <#return value description#>
 */
-(CustomBarItem*)setLeftTitle:(NSString*)title;
-(CustomBarItem*)setCenterView:(UIView*)centerView;
-(CustomBarItem *)createTitleViewWithTitle:(NSString *)title ;
-(CustomBarItem*)setLeftTitle:(NSString *)title imageName:(NSString*)imageName highlighted:(NSString*)highlightedImage;
- (CustomBarItem*)setLeftTitle:(NSString *)title imageName:(NSString*)imageName highlighted:(NSString*)highlightedImage completeBlock:(void(^)(UIButton *btn))completeBlock;

/**
 *  左按钮点击在VC中实现此方法
 *
 *  @param button 点击的按钮
 */
-(void)leftEvent:(UIButton*)button;
-(void)rightEvent:(UIButton*)button;
@end

