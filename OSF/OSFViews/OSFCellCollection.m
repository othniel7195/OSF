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

@end
