//
//  OSFSimilarTagModel.m
//  OSF
//
//  Created by 赵锋 on 15/7/16.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFSimilarTagModel.h"

@implementation OSFSimilarTagModel

-(instancetype)initWithDic:(NSDictionary *)dic
{
    self=[super init];
    if (!self) return self;
    
    [self setValuesForKeysWithDictionary:dic];
    
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.index=value;
    }
}

@end
