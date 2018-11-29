//
//  UINavigationItem+CustomItem.h
//  LZURLScheme_Example
//
//  Created by lizheng on 2018/11/28.
//  Copyright © 2018年 emailoflizheng@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomBarItem.h"

@interface UINavigationItem (CustomItem)

- (CustomBarItem *)setItemWithTitle:(NSString *)title textColor:(UIColor *)color fontSize:(UIFont*)font itemType:(ItemType)type;
- (CustomBarItem *)setItemWithImage:(NSString *)imageName size:(CGSize)size itemType:(ItemType)type;
- (CustomBarItem *)setItemWithCustomView:(UIView *)customView itemType:(ItemType)type;

@end


