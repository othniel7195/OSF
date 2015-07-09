//
//  OSFQuestionCell.h
//  OSF
//
//  Created by 赵锋 on 15/7/7.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFBaseCell.h"

@interface OSFQuestionCell : OSFBaseCell

///用户姓名
@property(nonatomic, copy) NSString * userName;
///发布时间
@property(nonatomic, copy) NSString * dateTime;
///发布内容
@property(nonatomic, copy) NSString *content;

/**
 * answerNum 回答数
 * questionStatus 问题状态
 */
-(void)numFlagAnswerNum:(NSString *)answerNum questionStatus:(NSInteger) questionStatus;
/**
 *
 * content 控件高度自动适应内容的 内容
 */
-(CGFloat)calulateHeight:(NSString *)content;
@end
