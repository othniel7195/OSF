//
//  QuestionHotHandle.h
//  OSF
//
//  Created by 赵锋 on 15/7/16.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuestionHotNet.h"
#import "OSFPageModel.h"
#import "OSFQuestionModel.h"
@interface QuestionHotHandle : NSObject

///页码模型
@property(nonatomic, strong, readonly)OSFPageModel *pageModel;
///问题数据数组
@property(nonatomic, strong, readonly)NSMutableArray *questionArrs;

///最新问题 请求
@property(nonatomic, strong)QuestionHotNet *qHotNet;

@property(nonatomic, copy) void (^successBlock)(void);

@property(nonatomic, copy) void (^failureBlock)(void);

-(void)startNetWorking;
-(void)stopNetWorking;
///清空数据源
-(void)clearQuestions;

///获取某条数据
-(OSFQuestionModel *)questionWithIndex:(NSInteger)index;

@end
