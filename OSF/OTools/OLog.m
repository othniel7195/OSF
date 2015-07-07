//
//  Othniel.m
//  HeartHealth
//
//  Created by 赵锋 on 15/7/2.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OLog.h"

@implementation OLog

+(void)showMessage:(NSString *)msg,...
{
    if (!msg) return;
    
    va_list arglist;
    
    va_start(arglist, msg);
    
    NSString *outString=[[NSString alloc] initWithFormat:msg arguments:arglist];
    
    va_end(arglist);
    
#ifdef DEBUG
    NSLog(@"%@",outString);
#endif
    
}


@end
