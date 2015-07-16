//
//  OSFQuestionModel.m
//  OSF
//
//  Created by 赵锋 on 15/7/13.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFQuestionModel.h"
#import "OSFTagModel.h"
@implementation OSFQuestionModel

-(instancetype)initWithDic:(NSDictionary *)dic
{
    if (!self) return nil;
    
    [self setValuesForKeysWithDictionary:dic];

    _lastAnswer=[[OSFLastAnswer alloc] initWithDic:[dic objectForKey:@"lastAnswer"]];
    _user=[[OSFUserModel alloc] initWithDic:[dic objectForKey:@"user"]];
    
    NSArray *tags=[dic objectForKey:@"tags"];
    
    [self tagsArrayChangeToTagDic:tags];
    
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        
        self.index=[value longLongValue];
    }
}

-(void)tagsArrayChangeToTagDic:(NSArray *)tags
{
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    
    [tags enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL *stop) {
        
        OSFTagModel *tagModel = [[OSFTagModel alloc] initWithDic:obj];
        [mArray addObject:tagModel];
        
    }];
    
    self.tags=[mArray copy];
}
-(NSString*)description
{
    return [NSString stringWithFormat:@"问题标题:%@ --- 时间:%@",_title,_createdDate];
}
@end
