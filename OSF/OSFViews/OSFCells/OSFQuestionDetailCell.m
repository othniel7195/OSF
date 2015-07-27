//
//  OSFQuestionDetailCell.m
//  OSF
//
//  Created by 赵锋 on 15/7/22.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFQuestionDetailCell.h"
#import "OSFTitleNameWithTimeView.h"
#import "OSFWebViewWithComment.h"
@interface OSFQuestionDetailCell ()

@property(nonatomic, strong)OSFTitleNameWithTimeView *titleWithTime;
@property(nonatomic, strong)OSFWebViewWithComment *webComment;
@end

@implementation OSFQuestionDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:self.titleWithTime];
        [self addSubview:self.webComment];
        
        [self initConstraints];
    }
    return self;
}


-(void)initConstraints
{
    [self.titleWithTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.width.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView);
    }];
    
    [self.webComment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleWithTime).offset(5);
        make.width.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView);
    }];
    
}

#pragma mark --- 视图
-(OSFTitleNameWithTimeView *)titleWithTime
{
    if (!_titleWithTime) {
        
        OSFTitleNameWithTimeView *title_time=[[OSFTitleNameWithTimeView alloc] init];
        
        _titleWithTime=title_time;
    }
    return _titleWithTime;
}
-(OSFWebViewWithComment*)webComment
{
    if (!_webComment) {
        OSFWebViewWithComment *web_commnet=[[OSFWebViewWithComment alloc] initWithFrame:CGRectZero hasTags:YES];
        
        _webComment=web_commnet;
    }
    return _webComment;
}

#pragma mark -- public method
-(void)osfQuestionTitle:(NSString *)title  name:(NSString *)name time:(NSString *)time
{
    [self.titleWithTime osfTitle:title name:name time:time];
}
-(void)osfQuestionHtmlString:(NSString *)htmlString tags:(NSArray *)tags
{
    self.webComment.htmlString=htmlString;
    self.webComment.tags=[tags copy];
}
@end
