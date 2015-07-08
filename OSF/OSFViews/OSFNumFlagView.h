//
//  OSFNumFlagView.h
//  OSF
//
//  Created by 赵锋 on 15/7/7.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFBaseView.h"

typedef NS_ENUM(NSInteger, OSFQuestionStatus)
{
    OSFQuestionNoAnswer,  //没有人回答
    OSFQuestionNoResolve, //有人回答没有解决
    OSFQuestionHasResolve // 已经解决
    
};

@interface OSFNumFlagView : OSFBaseView

///圆角半径
@property(nonatomic, assign,readonly) CGFloat radius;
///回答人数
@property(nonatomic, copy,readonly) NSString * answerNum;
///状态
@property(nonatomic, assign,readonly) NSInteger questionStatus;

/// cornerRadius ==radius 圆角半径
-(instancetype)initWithFrame:(CGRect)frame cornerRadius:(CGFloat)cornerRadius;
/**
 * answerNum 回答数
 * questionStatus 问题状态
 */
-(void)numFlagAnswerNum:(NSString *)answerNum questionStatus:(NSInteger) questionStatus;

@end
