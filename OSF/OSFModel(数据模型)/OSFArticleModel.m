//
//  OSFArticleModel.m
//  OSF
//
//  Created by 赵锋 on 15/7/18.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFArticleModel.h"
#import "OSFTagModel.h"
@implementation OSFArticleModel

-(instancetype)initWithDic:(NSDictionary *)dic
{
    self=[super init];
    if (self) {
        
        [self setValuesForKeysWithDictionary:dic];
        
        _user=[[OSFUserModel alloc] initWithDic:[dic objectForKey:@"user"]];
        _blog=[[OSFBlog alloc] initWithDic:[dic objectForKey:@"blog"]];
        
        NSArray *tags=[dic objectForKey:@"tags"];
        
        [self tagsArrayChangeToTagDic:tags];

    }
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

@end
