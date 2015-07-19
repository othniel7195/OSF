//
//  ArticleHandle.h
//  OSF
//
//  Created by 赵锋 on 15/7/19.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArticleNet.h"
#import "OSFPageModel.h"
#import "OSFArticleModel.h"

@interface ArticleHandle : NSObject

///页码模型
@property(nonatomic, strong, readonly)OSFPageModel *pageModel;
///文章数据数组
@property(nonatomic, strong, readonly)NSMutableArray *articleArrs;

///文章 请求
@property(nonatomic, strong)ArticleNet *articleNet;

@property(nonatomic, copy) void (^successBlock)(void);

@property(nonatomic, copy) void (^failureBlock)(void);

-(void)startNetWorking;
-(void)stopNetWorking;
///清空数据源
-(void)clearQuestions;

///获取某条数据
-(OSFArticleModel *)articlesWithIndex:(NSInteger)index;

@end
