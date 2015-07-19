//
//  ArticleHandle.m
//  OSF
//
//  Created by 赵锋 on 15/7/19.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "ArticleHandle.h"

@interface ArticleHandle ()

@property(nonatomic, strong, readwrite)OSFPageModel *pageModel;
@property(nonatomic, strong, readwrite)NSMutableArray *articleArrs;

@end

@implementation ArticleHandle

-(instancetype)init
{
    self=[super init];
    if (!self) return nil;
    
    _articleNet=[[ArticleNet alloc] init];
    _articleNet.page=@"1";
    _articleArrs=[NSMutableArray array];
    
    return self;
}

-(void)startNetWorking
{
    [self.articleNet startWithCompletionBlockWithSuccess:^(ONetBaseRequest *request) {
        
        NSDictionary *dataDic=[request.responseJSONObject objectForKey:@"data"];
        NSString *status = [request.responseJSONObject objectForKey:@"status"];
        
        if ([status integerValue]==0) {
            
            NSDictionary *page =[dataDic objectForKey:@"page"];
            NSArray *rows =[dataDic objectForKey:@"rows"];
            
            self.pageModel=[[OSFPageModel alloc] initWithDic:page];
            
            if (self.pageModel.current == 1) {
                //如果是第一页
                //清空数据源
                
                [self clearQuestions];
            }
            
            [rows enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL *stop) {
                
                OSFArticleModel *articleModel = [[OSFArticleModel alloc] initWithDic:obj];
                [self.articleArrs  addObject:articleModel];
            }];
            
            self.successBlock();
            [self clearBlock];
            
        }else
        {
            NSString *msg = [request.responseJSONObject objectForKey:@"message"];
            
            self.failureBlock();
            [self clearBlock];
        }
        
        
    } failure:^(ONetBaseRequest *request) {
        
        self.failureBlock();
        [self clearBlock];
        
    }];
}
-(void)stopNetWorking
{
    [self.articleNet stop];
    
}
#pragma  mark -- 一些清理操作
//把block置为nil
-(void)clearBlock
{
    self.successBlock=nil;
    self.failureBlock=nil;
}
-(void)clearQuestions
{
    [self.articleArrs removeAllObjects];
}
#pragma mark -- 数据操作
-(OSFArticleModel *)articlesWithIndex:(NSInteger)index
{
    if (index>self.articleArrs.count) {
        return nil;
    }
    return self.articleArrs[index];
}


@end
