//
//  UINavigationItem+CustomItem.m
//  LZURLScheme_Example
//
//  Created by lizheng on 2018/11/28.
//  Copyright © 2018年 emailoflizheng@126.com. All rights reserved.
//

#import "UINavigationItem+CustomItem.h"

@implementation UINavigationItem (CustomItem)

- (CustomBarItem *)setItemWithTitle:(NSString *)title textColor:(UIColor *)color fontSize:(UIFont*)font itemType:(ItemType)type{
    CustomBarItem *item = [CustomBarItem itemWithTitle:title textColor:color fontSize:font itemType:type];
    [item setItemWithNavigationItem:self itemType:type];
    return item;
}

- (CustomBarItem *)setItemWithImage:(NSString *)imageName size:(CGSize)size itemType:(ItemType)type{
    CustomBarItem *item = [CustomBarItem itemWithImage:imageName size:size type:type];
    [item setItemWithNavigationItem:self itemType:type];
    return item;
}

- (CustomBarItem *)setItemWithCustomView:(UIView *)customView itemType:(ItemType)type{
    CustomBarItem *item = [CustomBarItem itemWithCustomeView:customView type:type];
    [item setItemWithNavigationItem:self itemType:type];
    return item;
}
@end
