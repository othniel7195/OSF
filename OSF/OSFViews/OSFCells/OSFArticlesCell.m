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
#import "UIImageView+AFNetworking.h"
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
        self.backgroundColor=[UIColor clearColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.praiseView];
        [self.contentView addSubview:self.articlesTitleLabel];
        [self.contentView addSubview:self.articlesContentLabel];
        [self.contentView addSubview:self.headImageView];
        [self.contentView addSubview:self.userNameWithDateLabel];
        
        [self initConstraints];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.backgroundColor=[OColors  OSFRightCellHighlightColor];
        self.articlesTitleLabel.textColor=[UIColor lightGrayColor];
    }else{
        self.backgroundColor=nil;
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    if (highlighted) {
        self.backgroundColor=[OColors  OSFRightCellHighlightColor];
    }
}

#pragma mark -- 布局
-(void)initConstraints
{
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.size.mas_equalTo(CGSizeMake(32, 32));
       make.left.and.top.mas_equalTo(10);
    }];
    [self.articlesTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageView.mas_right).offset(4);
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.height.mas_greaterThanOrEqualTo(21);
    }];
    [self.articlesContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.articlesTitleLabel.mas_left);
        make.top.mas_equalTo(self.articlesTitleLabel.mas_bottom).offset(2);
        make.right.mas_equalTo(self.articlesTitleLabel.mas_right);
        make.height.mas_greaterThanOrEqualTo(21);
    }];
    
    [self.praiseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.articlesContentLabel.mas_left);
        make.top.mas_equalTo(self.articlesContentLabel.mas_bottom).offset(4);
        make.size.mas_equalTo(CGSizeMake(52, 22));
        make.bottom.mas_equalTo(-10);
    }];
    
    [self.userNameWithDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.praiseView.mas_right).offset(4);
        make.top.mas_equalTo(self.praiseView.mas_top);
        make.height.mas_equalTo(self.praiseView.mas_height);
        make.right.mas_equalTo(self.articlesContentLabel.mas_right);
        make.bottom.mas_equalTo(-10);
    }];
    
    
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
        
        UILabel *articlesTitle=[[UILabel alloc] initWithFrame:CGRectZero];
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
        
        UILabel *articlesContent=[[UILabel alloc] initWithFrame:CGRectZero];
        articlesContent.backgroundColor=[UIColor clearColor];
        articlesContent.font=[UIFont systemFontOfSize:14.0];
        articlesContent.numberOfLines=2;
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
        userNameWithDate.font=[UIFont systemFontOfSize:13.0];
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
        head.layer.cornerRadius=16.0;
        head.layer.borderColor=[OColors OSFNavBarColor].CGColor;
        head.layer.borderWidth=2.0;
        
        _headImageView=head;
    }
    
    return _headImageView;
}

#pragma mark -- 属性赋值
-(void)setPraiseNum:(NSString *)praiseNum
{
    if (_praiseNum!=praiseNum) {
        _praiseNum=praiseNum;
        
        self.praiseView.praiseNum=_praiseNum;
    }
}

-(void)setUserName:(NSString *)userName
{
    if (_userName!=userName) {
        _userName=userName;
        
        self.userNameWithDateLabel.text=[NSString stringWithFormat:@"%@ · %@",_userName,self.publishDate];
    }
}
-(void)setPublishDate:(NSString *)publishDate
{
    if (_publishDate!=publishDate) {
        _publishDate=publishDate;
        
        self.userNameWithDateLabel.text=[NSString stringWithFormat:@"%@ · %@",self.userName,_publishDate];
    }
}
-(void)setImgURL:(NSString *)imgURL
{
    if (_imgURL!=imgURL) {
        _imgURL=imgURL;
        
        [self.headImageView setImageWithURL:[NSURL URLWithString:_imgURL] placeholderImage:[UIImage imageNamed:@"user_avatar"]];
        
    }
}
-(void)setArticleTitle:(NSString *)articleTitle
{
    if (_articleTitle!=articleTitle) {
        _articleTitle=articleTitle;
        
        self.articlesTitleLabel.text=articleTitle;
    }
}
-(void)setArticleContent:(NSString *)articleContent
{
    if (_articleContent!=articleContent) {
        _articleContent=articleContent;
        
        self.articlesContentLabel.text=articleContent;
    }
}

#pragma mark --cell 高度

-(CGFloat)calulateHeightWithTitle:(NSString *)title content:(NSString *)content
{
    CGSize mainSize = [[UIScreen mainScreen] bounds].size;
    
    self.articlesTitleLabel.preferredMaxLayoutWidth=mainSize.width-56.0;
    self.articlesTitleLabel.text=title;
    
    self.articlesContentLabel.preferredMaxLayoutWidth=mainSize.width-56.0;
    self.articlesContentLabel.text=content;
    
    CGSize size = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    return size.height+1.0f;
}
@end
