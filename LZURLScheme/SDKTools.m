//
//  SDKTools.m
//  LZURLScheme_Example
//
//  Created by lizheng on 2018/11/24.
//  Copyright © 2018年 emailoflizheng@126.com. All rights reserved.
//

#import "SDKTools.h"

@implementation NSString (UMString)

- (BOOL)containsString:(NSString *)string
               options:(NSStringCompareOptions)options {
    NSRange rng = [self rangeOfString:string options:options];
    return rng.location != NSNotFound;
}

- (BOOL)containsString:(NSString *)string {
    return [self containsString:string options:0];
}

- (NSString *)urldecode {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

- (NSString *)urlencode {
    NSString *encUrl = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSInteger len = [encUrl length];
    const char *c;
    c = [encUrl UTF8String];
    NSString *ret = @"";
    for(int i = 0; i < len; i++) {
        switch (*c) {
            case '/':
                ret = [ret stringByAppendingString:@"%2F"];
                break;
            case '\'':
                ret = [ret stringByAppendingString:@"%27"];
                break;
            case ';':
                ret = [ret stringByAppendingString:@"%3B"];
                break;
            case '?':
                ret = [ret stringByAppendingString:@"%3F"];
                break;
            case ':':
                ret = [ret stringByAppendingString:@"%3A"];
                break;
            case '@':
                ret = [ret stringByAppendingString:@"%40"];
                break;
            case '&':
                ret = [ret stringByAppendingString:@"%26"];
                break;
            case '=':
                ret = [ret stringByAppendingString:@"%3D"];
                break;
            case '+':
                ret = [ret stringByAppendingString:@"%2B"];
                break;
            case '$':
                ret = [ret stringByAppendingString:@"%24"];
                break;
            case ',':
                ret = [ret stringByAppendingString:@"%2C"];
                break;
            case '[':
                ret = [ret stringByAppendingString:@"%5B"];
                break;
            case ']':
                ret = [ret stringByAppendingString:@"%5D"];
                break;
            case '#':
                ret = [ret stringByAppendingString:@"%23"];
                break;
            case '!':
                ret = [ret stringByAppendingString:@"%21"];
                break;
            case '(':
                ret = [ret stringByAppendingString:@"%28"];
                break;
            case ')':
                ret = [ret stringByAppendingString:@"%29"];
                break;
            case '*':
                ret = [ret stringByAppendingString:@"%2A"];
                break;
            default:
                ret = [ret stringByAppendingFormat:@"%c", *c];
        }
        c++;
    }
    return ret;
}

@end

@implementation NSURL (UMSTRING)

- (NSDictionary *)params {
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
    if (NSNotFound != [self.absoluteString rangeOfString:@"?"].location) {
        NSString *paramString = [self.absoluteString substringFromIndex:([self.absoluteString rangeOfString:@"?"].location + 1)];
        NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&"];
        NSScanner* scanner = [[NSScanner alloc] initWithString:paramString];
        while (![scanner isAtEnd]) {
            NSString* pairString = nil;
            [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
            [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
            NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
            if (kvPair.count == 2) {
                NSString* key = [[kvPair objectAtIndex:0] urldecode];
                NSString* value = [[kvPair objectAtIndex:1] urldecode];
                [pairs setValue:value forKey:key];
            }
        }
    }
    return [NSDictionary dictionaryWithDictionary:pairs];
}

- (NSString *)protocol {
    if (NSNotFound != [self.absoluteString rangeOfString:@"://"].location) {
        return [self.absoluteString substringToIndex:([self.absoluteString rangeOfString:@"://"].location)];
    }
    return @"";
}

- (NSURL *)addParams:(NSDictionary *)params {
    NSMutableString *_add = nil;
    if (NSNotFound != [self.absoluteString rangeOfString:@"?"].location) {
        _add = [NSMutableString stringWithString:@"&"];
    }else {
        _add = [NSMutableString stringWithString:@"?"];
    }
    for (NSString* key in [params allKeys]) {
        if ([params objectForKey:key] && 0 < [[params objectForKey:key] length]) {
            [_add appendFormat:@"%@=%@&",key,[[params objectForKey:key] urlencode]];
        }
    }
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.absoluteString,[_add substringToIndex:[_add length] - 1]]];
}

@end

@implementation UIView (UMView)

- (void)removeAllSubviews {
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
}

- (UIImage *)imageFromView{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(self.bounds.size);
    NSLog(@"%@", NSStringFromCGSize(self.bounds.size));
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    //[view.layer drawInContext:currnetContext];
    [self.layer renderInContext:currnetContext];
    // 从当前context中创建一个改变大小后的图片
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    return image;
}

@end

