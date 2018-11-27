//
//  SDKCommandManager.h
//  LZURLScheme_Example
//
//  Created by lizheng on 2018/11/24.
//  Copyright © 2018年 emailoflizheng@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SDKCommandManager : NSObject

- (void)execURL:(NSURL *)url;
+ (void)setService:(id)serviceObj forKey:(NSString *)strKey;
+ (NSMutableDictionary *)serviceConfig;

@end

