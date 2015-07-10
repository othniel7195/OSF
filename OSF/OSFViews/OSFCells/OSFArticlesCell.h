//
//  OSFArticlesCell.h
//  OSF
//
//  Created by 赵锋 on 15/7/9.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFBaseCell.h"

@interface OSFArticlesCell : OSFBaseCell

///赞得个数
@property(nonatomic, copy)NSString *praiseNum;
///用户名
@property(nonatomic, copy)NSString *userName;
///发布时间
@property(nonatomic, copy)NSString *publishDate;
///头像url
@property(nonatomic, copy)NSString *imgURL;
///文章标题
@property(nonatomic, copy)NSString *articleTitle;
///文章内容
@property(nonatomic, copy)NSString *articleContent;

/**
 * title 标题控件自适应高度
 * content 控件高度自动适应内容的 内容
 */
-(CGFloat)calulateHeightWithTitle:(NSString *)title content:(NSString *)content;
@end
