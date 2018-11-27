//
//  SDKCommandManager.m
//  LZURLScheme_Example
//
//  Created by lizheng on 2018/11/24.
//  Copyright © 2018年 emailoflizheng@126.com. All rights reserved.
//

#import "SDKCommandManager.h"
#import "SDKTools.h"

@implementation SDKCommandManager

- (void)execURL:(NSURL *)url{
    // 找到对应service，执行相应函数
    // 判断是否是可执行scheme
    if (![self URLisExecScheme:url]) {
        return;
    }
    // 判断是否已经注册了对应的service
    if (![self URLAvailable:url]) {
        return;
    }
    // path 指代函数名称
    NSString* strPath = [url path];
    NSInteger length = strPath.length;
    NSString* strFunName = [strPath substringWithRange:NSMakeRange(1, length-1)];
    SEL funSel = NSSelectorFromString( strFunName );
    id service = [[SDKCommandManager serviceConfig] objectForKey:[url host]];
    if (funSel && [service respondsToSelector:funSel]) {
        NSArray *keyArr = [strFunName  componentsSeparatedByString:@":"];
        NSMethodSignature *sig = [service methodSignatureForSelector:funSel];
        if (sig) {
            NSInvocation* invo = [NSInvocation invocationWithMethodSignature:sig];
            [invo setTarget:service];
            [invo setSelector:funSel];
            for (int i = 0; i< keyArr.count-1; i++) {
                id ptr = ([[url params] objectForKey:[keyArr objectAtIndex:i] ]);
                [invo setArgument:&ptr atIndex:i+2];
            }
            [invo invoke];
        }
    }
}

- (BOOL)URLAvailable:(NSURL *)url{
    return [[[SDKCommandManager serviceConfig] allKeys] containsObject:[url host]];
}

-(BOOL)URLisExecScheme:(NSURL *)url{
    return [[url scheme] isEqualToString:@"wddo"];
}


+ (void)setService:(id)serviceObj forKey:(NSString *)strKey{
    [[SDKCommandManager serviceConfig] setValue:serviceObj forKey:strKey];
}

+ (NSMutableDictionary *)serviceConfig{
    static NSMutableDictionary *config;
    if (nil == config) {
        config = [[NSMutableDictionary alloc] init];
    }
    return config;
}

@end
