//
//  UIViewController+CustomItem.m
//  LZURLScheme_Example
//
//  Created by lizheng on 2018/11/28.
//  Copyright © 2018年 emailoflizheng@126.com. All rights reserved.
//

#import "UIViewController+CustomItem.h"

@implementation UIViewController (CustomItem)

-(CustomBarItem*)setRightButtonNormalImageName:(NSString*)imageName  highlighted:(NSString*)highlightedImage{
    CustomBarItem *customBarItem = [self.navigationItem setItemWithImage:imageName size:CGSizeMake(50, 44) itemType:right];
    [customBarItem.contentBarItem addTarget:self action:@selector(rightEvent:) forControlEvents:UIControlEventTouchUpInside];
    [customBarItem.contentBarItem setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    [customBarItem setOffset:0];
    return customBarItem;
}

-(CustomBarItem*)setRightButtonTitle:(NSString*)title{
    CustomBarItem *customBarItem = [self.navigationItem setItemWithTitle:title textColor:[UIColor blackColor] fontSize:[UIFont systemFontOfSize:15] itemType:right];
    CGRect frame = customBarItem.contentBarItem.frame;
    frame.size.width = 75;
    customBarItem.contentBarItem.frame = frame;
    [customBarItem addTarget:self selector:@selector(rightEvent:) event:UIControlEventTouchUpInside];
    [customBarItem setOffset:0];
    return customBarItem;
}

-(CustomBarItem*)setLeftButtonNormalImageName:(NSString*)imageName  highlighted:(NSString*)highlightedImage{
    CustomBarItem *customBarItem = [self.navigationItem setItemWithImage:imageName size:CGSizeMake(50, 44) itemType:left];
    [customBarItem.contentBarItem addTarget:self action:@selector(leftEvent:) forControlEvents:UIControlEventTouchUpInside];
    [customBarItem.contentBarItem setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    [customBarItem setOffset:0];
    return customBarItem;
}

-(CustomBarItem*)setLeftTitle:(NSString*)title{
    CustomBarItem *customBarItem = [self.navigationItem setItemWithTitle:title textColor:[UIColor blackColor] fontSize:[UIFont systemFontOfSize:15] itemType:left];
    [customBarItem addTarget:self selector:@selector(leftEvent:) event:UIControlEventTouchUpInside];
    return customBarItem;
}

-(CustomBarItem*)setLeftTitle:(NSString *)title imageName:(NSString*)imageName highlighted:(NSString*)highlightedImage{
    CustomBarItem *customBarItem = [self.navigationItem setItemWithTitle:title textColor:[UIColor blackColor] fontSize:[UIFont systemFontOfSize:15] itemType:left];
    [customBarItem.contentBarItem setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [customBarItem.contentBarItem setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    [customBarItem addTarget:self selector:@selector(leftEvent:) event:UIControlEventTouchUpInside];
    return customBarItem;
}

- (CustomBarItem*)setLeftTitle:(NSString *)title imageName:(NSString*)imageName highlighted:(NSString*)highlightedImage completeBlock:(void(^)(UIButton *btn))completeBlock{
    CustomBarItem *customBarItem = [self.navigationItem setItemWithTitle:title textColor:[UIColor blackColor] fontSize:[UIFont systemFontOfSize:15] itemType:left];
    [customBarItem.contentBarItem setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [customBarItem.contentBarItem setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    [customBarItem addTarget:self selector:@selector(leftEvent:) event:UIControlEventTouchUpInside];
    if (completeBlock) {
        completeBlock(customBarItem.contentBarItem);
    }
    return customBarItem;
}

-(void)leftEvent:(UIButton*)button{
    //子类重写
}

-(void)rightEvent:(UIButton*)button{
    //子类重写
}

//-(void)setTitle:(NSString *)title
//{
//    [self createTitleViewWithTitle:title];
//}
-(CustomBarItem *)createTitleViewWithTitle:(NSString *)title {
    CustomBarItem *customBarItem = [self.navigationItem setItemWithTitle:title textColor:[UIColor blackColor] fontSize:[UIFont systemFontOfSize:17] itemType:center];
    
    return customBarItem;
}

-(CustomBarItem*)setCenterView:(UIView*)centerView{
    return [self.navigationItem setItemWithCustomView:centerView itemType:center];
    
}
@end
