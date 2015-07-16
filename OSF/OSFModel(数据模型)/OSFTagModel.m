
//
//  OSFTagModel.m
//  OSF
//
//  Created by 赵锋 on 15/7/13.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFTagModel.h"
#import "OSFSimilarTagModel.h"
@implementation OSFTagModel
-(instancetype)initWithDic:(NSDictionary *)dic
{
    self=[super init];
    if (!self) return self;
    
    [self setValuesForKeysWithDictionary:dic];
    
    [self similarTagArrayChangeToSimilarTagDic:[dic objectForKey:@"similarTags"]];
    
    
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.index=[value longLongValue];
    }
}

-(void)similarTagArrayChangeToSimilarTagDic:(NSArray *)similarTags
{
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    
    [similarTags enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL *stop) {
        
        OSFSimilarTagModel *similarTag =[[OSFSimilarTagModel alloc] initWithDic:obj];
        [mArray addObject:similarTag];
        
    }];
    
    self.similarTags=[mArray copy];
}
@end
