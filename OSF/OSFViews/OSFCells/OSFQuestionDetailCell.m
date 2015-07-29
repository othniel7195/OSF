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
        
        
    }
    return self;
}

-(void)updateConstraints
{
    NSLog(@"detail cell");
    
//    [self.titleWithTime mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(5);
//        make.width.mas_equalTo(self.contentView.bounds.size.width);
//        make.left.mas_equalTo(0);
//        make.height.mas_greaterThanOrEqualTo(40);
//    }];
    [self.webComment mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(self.contentView.bounds.size.width);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(5);
    }];
    
    [super updateConstraints];
    
}


#pragma mark --- 视图
-(OSFTitleNameWithTimeView *)titleWithTime
{
    if (!_titleWithTime) {
        
        OSFTitleNameWithTimeView *title_time=[[OSFTitleNameWithTimeView alloc] init];
        
        _titleWithTime=title_time;
        [self.contentView addSubview:_titleWithTime];
    }
    return _titleWithTime;
}
-(OSFWebViewWithComment*)webComment
{
    if (!_webComment) {
        OSFWebViewWithComment *web_commnet=[[OSFWebViewWithComment alloc] initWithFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, 1) hasTags:YES];
        web_commnet.backgroundColor=[UIColor redColor];
        
        _webComment=web_commnet;
        
        [self.contentView addSubview:_webComment];
        
        [_webComment needsUpdateConstraints];
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
