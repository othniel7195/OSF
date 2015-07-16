//
//  QuestionHotHandle.m
//  OSF
//
//  Created by 赵锋 on 15/7/16.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "QuestionHotHandle.h"

@interface QuestionHotHandle ()

@property(nonatomic, strong, readwrite)OSFPageModel *pageModel;
@property(nonatomic, strong, readwrite)NSMutableArray *questionArrs;

@end

@implementation QuestionHotHandle

-(instancetype)init
{
    self=[super init];
    if (!self) return nil;
    
    _qHotNet=[[QuestionHotNet alloc] init];
    _qHotNet.page=@"1";
    _questionArrs=[NSMutableArray array];
    
    return self;
}

-(void)startNetWorking
{
    [self.qHotNet startWithCompletionBlockWithSuccess:^(ONetBaseRequest *request) {
        
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
                
                OSFQuestionModel *questionModel = [[OSFQuestionModel alloc] initWithDic:obj];
                [self.questionArrs  addObject:questionModel];
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
    [self.qHotNet stop];
    
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
    [self.questionArrs removeAllObjects];
}
#pragma mark -- 数据操作
-(OSFQuestionModel *)questionWithIndex:(NSInteger)index
{
    if (index>self.questionArrs.count) {
        return nil;
    }
    return self.questionArrs[index];
}


@end
