//
//  HHCellCollection.m
//  HeartHealth
//
//  Created by 赵锋 on 15/7/3.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFCellCollection.h"
@implementation OSFCellCollection

#pragma mark -- 注册cell
+(void)registerUserHeadCell:(UITableView *)tableView
{
    [tableView registerClass:[OSFUserHeadCell class] forCellReuseIdentifier:UserHeadCell];
}
+(void)registerLabelCell:(UITableView *)tableView
{
    [tableView registerClass:[OSFLabelCell class] forCellReuseIdentifier:LabelCell];
}
+(void)registerQuestionCell:(UITableView *)tableView
{
    [tableView registerClass:[OSFQuestionCell class] forCellReuseIdentifier:QuestionCell];
}
+(void)registerArticleCell:(UITableView *)tableView
{
    [tableView registerClass:[OSFArticlesCell class] forCellReuseIdentifier:ArticleCell];
}
+(void)registerTagsCell:(UITableView *)tableView
{
    [tableView registerClass:[OSFTagsCell class] forCellReuseIdentifier:TagCell];
}
+(void)registerTextFieldCell:(UITableView *)tableView
{
    [tableView registerClass:[OSFTextFieldCell class] forCellReuseIdentifier:TextFieldCell];
}
+(void)registerQuestionDetailCell:(UITableView *)tableView
{
    [tableView registerClass:[OSFQuestionDetailCell class] forCellReuseIdentifier:QuestionDetailCell];
}
#pragma mark -- 生成并复用cell
+(UITableViewCell *)cellForUserHead:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath headImage:(UIImage *)headImage userName:(NSString *)userName
{
    OSFUserHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:UserHeadCell forIndexPath:indexPath];
    
    cell.userName = userName;
    cell.headImage = headImage;
    
    [cell initConstraints];
    
    return cell;
}
+(UITableViewCell *)cellForLabel:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
                     normalImage:(UIImage *)normalImage selectImage:(UIImage *)selectImage
                       labelInfo:(NSString *)labelInfo
{
    OSFLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:LabelCell forIndexPath:indexPath];
    cell.indexTag=indexPath.row;
    cell.normalLabelImage=normalImage;
    cell.selectLabelImage=selectImage;
    cell.labelInfo=labelInfo;
    
    [cell initConstraints];
    
    return cell;
}

+(UITableViewCell *)cellForQuestion:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath answerNum:(NSString *)answerNum questionStatus:(NSInteger)questionStatus userName:(NSString *)userName date:(NSString *)date content:(NSString *)content
{
    OSFQuestionCell *cell=[tableView dequeueReusableCellWithIdentifier:QuestionCell forIndexPath:indexPath];
    
    cell.userName=userName;
    cell.dateTime=date;
    cell.content=content;
    [cell numFlagAnswerNum:answerNum questionStatus:questionStatus];

    
    return cell;
    
}

+(UITableViewCell *)cellForArticle:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath articleTitle:(NSString *)articleTitle articleContent:(NSString *)articleContent headImgURL:(NSString *)headImgURL userName:(NSString *)userName publishDate:(NSString *)publishDate praiseNum:(NSString *)praiseNum
{
    OSFArticlesCell *cell=[tableView dequeueReusableCellWithIdentifier:ArticleCell forIndexPath:indexPath];
    
    cell.praiseNum=praiseNum;
    cell.imgURL=headImgURL;
    cell.userName=userName;
    cell.publishDate=publishDate;
    cell.articleTitle=articleTitle;
    cell.articleContent=articleContent;
    
    return cell;
}

+(UITableViewCell *)cellForTags:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath delegate:(id)delegate
                           tags:(NSArray *)tags
{
    OSFTagsCell *cell =[tableView dequeueReusableCellWithIdentifier:TagCell forIndexPath:indexPath];
    cell.delegate=delegate;
    cell.tags=tags;
    cell.path=indexPath;
    
    return cell;
}
+(UITableViewCell *)cellForTextField:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath delegate:(id)delegate placeholder:(NSString *)placeholder textFieldType:(NSInteger)textFieldType returnType:(NSInteger)returnType
{
    OSFTextFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:TextFieldCell forIndexPath:indexPath];
    cell.delegate=delegate;
    cell.placeholder=placeholder;
    cell.textFieldType=textFieldType;
    cell.returnType=returnType;
    
    return cell;
}
+(UITableViewCell *)cellForQuestionDetail:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath title:(NSString *) title userName:(NSString *)userName time:(NSString *)time htmlString:(NSString *)htmlString
                                     tags:(NSArray *)tags
{
    OSFQuestionDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:QuestionDetailCell forIndexPath:indexPath];
    [cell osfQuestionTitle:title name:userName time:time];
    [cell osfQuestionHtmlString:htmlString tags:tags];
    return cell;
}
@end
