//
//  OSFHtmlParse.h
//  OSF
//
//  Created by 赵锋 on 15/7/28.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface OSFHtmlParse : NSObject
+ (OSFHtmlParse *)sharedHtmlParse;
- (NSString *)rexMake:(NSString *)str;
- (NSString *)formatHTMLFromMarkdown:(NSString *)str;
- (UIColor *)getUIColor:(NSString *)hexColorString;
- (id)rexMake:(NSString *)str rex:(NSString *)rex;
@end
