//
//  SDKTools.h
//  LZURLScheme_Example
//
//  Created by lizheng on 2018/11/24.
//  Copyright © 2018年 emailoflizheng@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (UMURL)

- (NSDictionary *)params;
- (NSString *)protocol;
- (NSURL *)addParams:(NSDictionary*)params;

@end

@interface NSString (UMString)
- (BOOL)containsString:(NSString *)string options:(NSStringCompareOptions)options;
- (BOOL)containsString:(NSString *)string;
- (NSString *)urlencode;
- (NSString *)urldecode;

@end

@interface UIView (UMView)

//- (CGFloat)left;
//- (void)setLeft:(CGFloat)x;
//- (CGFloat)top;
//- (void)setTop:(CGFloat)y;
//- (CGFloat)right;
//- (void)setRight:(CGFloat)right;
//- (CGFloat)bottom;
//- (void)setBottom:(CGFloat)bottom;
//- (CGFloat)centerX;
//- (void)setCenterX:(CGFloat)centerX;
//- (CGFloat)centerY;
//- (void)setCenterY:(CGFloat)centerY;
//- (CGFloat)width;
//- (void)setWidth:(CGFloat)width;
//- (CGFloat)height;
//- (void)setHeight:(CGFloat)height;
//- (CGPoint)origin;
//- (void)setOrigin:(CGPoint)origin;
//- (CGSize)size;
//- (void)setSize:(CGSize)size;
//- (void)removeAllSubviews;

- (UIImage *)imageFromView;

@end
