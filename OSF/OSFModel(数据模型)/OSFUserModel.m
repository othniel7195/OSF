
//
//  OSFQuestionUserModel.m
//  OSF
//
//  Created by 赵锋 on 15/7/13.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFUserModel.h"
#import "OLog.h"
@implementation OSFUserModel

-(instancetype)initWithDic:(NSDictionary *)dic
{
    if (!self) return nil;
    
    [self setValuesForKeysWithDictionary:dic];
    
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.index=[value longLongValue];
    }
}
@end
