//
//  OSFHtmlParse.m
//  OSF
//
//  Created by 赵锋 on 15/7/28.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFHtmlParse.h"

@implementation OSFHtmlParse

//单例类
+ (OSFHtmlParse *)sharedHtmlParse {
    static OSFHtmlParse *util = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        util = [[self alloc] init];
    });
    return util;
}


// 替换图片链接地址
- (NSString *)rexMake:(NSString *)str {
    NSString *parten = @"\\/img\\/\\w+";
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSError *error = NULL;
    NSRegularExpression *reg = [NSRegularExpression
                                regularExpressionWithPattern:parten
                                options:NSRegularExpressionAnchorsMatchLines
                                error:&error];
    NSArray *match = [reg matchesInString:str
                                  options:NSMatchingWithoutAnchoringBounds
                                    range:NSMakeRange(0, [str length])];
    if (match.count != 0) {
        for (NSTextCheckingResult *matc in match) {
            NSRange range = [matc range];
            [array addObject:[str substringWithRange:range]];
        }
        for (NSString *a in array) {
            str =
            [str stringByReplacingOccurrencesOfString:
             a withString:[NSString stringWithFormat:
                           @"http://segmentfault.com%@", a]];
        }
    }
    return str;
}

// 解析 markdown 语法并组合模版
- (NSString *)formatHTMLFromMarkdown:(NSString *)str {
    NSError *error;
    NSString *textFileContents =
    [NSString stringWithContentsOfFile:[[NSBundle mainBundle]
                                        pathForResource:@"template"
                                        ofType:@"html"]
                              encoding:NSUTF8StringEncoding
                                 error:&error];
    
    NSString *htmlString = [NSString stringWithFormat:textFileContents, str];
    
    NSString *realHtmlString=[self rexMake:htmlString];;
    
    NSLog(@"%@",realHtmlString);
    
    return realHtmlString;
}

// 从 16 进制的数值中抽取颜色
- (UIColor *)getUIColor:(NSString *)hexColorString {
    unsigned int red, green, blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColorString substringWithRange:range]]
     scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColorString substringWithRange:range]]
     scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColorString substringWithRange:range]]
     scanHexInt:&blue];
    
    //要进行颜色的RGB设置，要进行对255.0的相除（与其他语言不同）
    return [UIColor colorWithRed:(float)(red / 255.0f)
                           green:(float)(green / 255.0f)
                            blue:(float)(blue / 255.0f)
                           alpha:1.0f];
}

// 替换图片链接地址
- (id)rexMake:(NSString *)str rex:(NSString *)rex {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSError *error = NULL;
    NSRegularExpression *reg = [NSRegularExpression
                                regularExpressionWithPattern:rex
                                options:NSRegularExpressionAnchorsMatchLines
                                error:&error];
    NSArray *match = [reg matchesInString:str
                                  options:NSMatchingWithoutAnchoringBounds
                                    range:NSMakeRange(0, [str length])];
    if (match.count != 0) {
        for (NSTextCheckingResult *matc in match) {
            NSRange range = [matc range];
            [array addObject:[str substringWithRange:range]];
        }
        return array;
    }
    return str;
}


@end
