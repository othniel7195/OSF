//
//  OSFArticlesCell.m
//  OSF
//
//  Created by 赵锋 on 15/7/9.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFArticlesCell.h"
#import "OSFPraiseView.h"
#import "OColors.h"
@interface OSFArticlesCell ()

///文章标题的label
@property(nonatomic, strong)UILabel *articlesTitleLabel;
///文章部分内容的label
@property(nonatomic, strong)UILabel *articlesContentLabel;
///赞的视图
@property(nonatomic, strong)OSFPraiseView *praiseView;
///头像
@property(nonatomic, strong)UIImageView *headImageView;
///用户名和时间的label
@property(nonatomic, strong)UILabel *userNameWithDateLabel;


@end

@implementation OSFArticlesCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.praiseView];
        [self.contentView addSubview:self.articlesTitleLabel];
        [self.contentView addSubview:self.articlesContentLabel];
        [self.contentView addSubview:self.headImageView];
        
        [self initConstraints];
    }
    
    return self;
}

#pragma mark -- 布局
-(void)initConstraints
{
   
}

#pragma mark -- 视图
-(OSFPraiseView *)praiseView
{
    if (_praiseView==nil) {
        
        OSFPraiseView *praiseV=[[OSFPraiseView alloc] initWithFrame:CGRectZero];
        
        _praiseView=praiseV;
    }
    return _praiseView;
}

-(UILabel *)articlesTitleLabel
{
    if (_articlesTitleLabel==nil) {
        
        UILabel *articlesTitle=[[UILabel alloc] init];
        articlesTitle.backgroundColor=[UIColor clearColor];
        articlesTitle.font=[UIFont boldSystemFontOfSize:14.0];
        articlesTitle.textColor=[UIColor blackColor];
        articlesTitle.numberOfLines=0;
        
        _articlesTitleLabel=articlesTitle;
    }
    return _articlesTitleLabel;
}

-(UILabel *)articlesContentLabel
{
    if (_articlesContentLabel==nil) {
        
        UILabel *articlesContent=[[UILabel alloc] init];
        articlesContent.backgroundColor=[UIColor clearColor];
        articlesContent.font=[UIFont systemFontOfSize:14.0];
        articlesContent.numberOfLines=0;
        articlesContent.textColor=[UIColor lightGrayColor];
        articlesContent.lineBreakMode=NSLineBreakByWordWrapping;
        
        _articlesContentLabel=articlesContent;
    }
    return _articlesContentLabel;
}

-(UILabel *)userNameWithDateLabel
{
    if (_userNameWithDateLabel==nil) {
        
        UILabel *userNameWithDate=[[UILabel alloc] init];
        userNameWithDate.backgroundColor=[UIColor clearColor];
        userNameWithDate.font=[UIFont systemFontOfSize:10.0];
        userNameWithDate.textColor=[UIColor lightGrayColor];
        
        _userNameWithDateLabel=userNameWithDate;
    }
    
    return _userNameWithDateLabel;
}

-(UIImageView *)headImageView
{
    if (_headImageView==nil) {
    
        UIImageView *head=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_avatar"]];
        head.layer.masksToBounds=YES;
        head.layer.cornerRadius=32.0;
        head.contentMode=UIViewContentModeCenter;
        head.layer.borderColor=[OColors OSFNavBarColor].CGColor;
        head.layer.borderWidth=2.0;
        
        _headImageView=head;
    }
    
    return _headImageView;
}
@end
