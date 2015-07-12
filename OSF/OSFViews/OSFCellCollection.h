//
//  HHCellCollection.h
//  HeartHealth
//
//  Created by 赵锋 on 15/7/3.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "OSFUserHeadCell.h"
#import "OSFLabelCell.h"
#import "OSFQuestionCell.h"
#import "OSFArticlesCell.h"
#import "OSFTagsCell.h"
#import "OSFTextFieldCell.h"
#import "Okeys.h"
@interface OSFCellCollection : NSObject

///注册用户头像Cell
+(void)registerUserHeadCell:(UITableView *)tableView;

///生成用户头像Cell 并复用
+(UITableViewCell *)cellForUserHead:(UITableView *)tableView  indexPath:(NSIndexPath *)indexPath headImage:(UIImage *)headImage userName:(NSString *)userName;

///注册标签cell
+(void)registerLabelCell:(UITableView *)tableView;
///生成标签cell 并复用
+(UITableViewCell *)cellForLabel:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
                     normalImage:(UIImage *)normalImage selectImage:(UIImage *)selectImage
                       labelInfo:(NSString *)labelInfo;
///注册问题cell
+(void)registerQuestionCell:(UITableView *)tableView;

/**
 * 生成问题cell 并复用
 * answerNum  回答人数
 * questionStatus 问题状态 0 没人回答 1有人回答 2已经解决
 * userName 用户名
 * date 发布时间
 * content 发布内容
 */
+(UITableViewCell *)cellForQuestion:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
                          answerNum:(NSString *)answerNum questionStatus:(NSInteger)questionStatus
                           userName:(NSString *)userName date:(NSString *)date content:(NSString *)content;

///注册文章cell
+(void)registerArticleCell:(UITableView *)tableView;

/**
 *  articleTitle 文章标题
 *  articleContent 文章内容
 *  headImgURL 头像url
 *  userName 用户名
 *  publishDate 发布时间
 *  praiseNum 赞数
 */
+(UITableViewCell *)cellForArticle:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
                      articleTitle:(NSString *)articleTitle articleContent:(NSString *)articleContent
                        headImgURL:(NSString *)headImgURL userName:(NSString *)userName publishDate:(NSString *)publishDate praiseNum:(NSString *)praiseNum;

///注册tags cell
+(void)registerTagsCell:(UITableView *)tableView;
/**
 * tags 标签数组
 */
+(UITableViewCell *)cellForTags:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath delegate:(id) delegate tags:(NSArray *)tags;

///注册 textfield cell
+(void)registerTextFieldCell:(UITableView *)tableView;
/**
 *
 * textFieldType  1 普通  2密码
 * returnType    1 done 2next
 *
 */
+(UITableViewCell *)cellForTextField:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath delegate:(id) delegate placeholder:(NSString *)placeholder  textFieldType:(NSInteger) textFieldType returnType:(NSInteger)returnType;



@end
