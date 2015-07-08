//
//  OSFQuestionCell.m
//  OSF
//
//  Created by 赵锋 on 15/7/7.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFQuestionCell.h"
#import "OSFNumFlagView.h"
#import "OColors.h"
@interface OSFQuestionCell ()

@property (nonatomic, strong)UILabel *userNameWithDateLabel;
@property (nonatomic, strong)UILabel *contentLabel;
@property (nonatomic, strong)OSFNumFlagView *flagView;
@property (nonatomic, strong ,readwrite) NSNumber *cellHeight;

@end

@implementation OSFQuestionCell
@synthesize cellHeight=_cellHeight;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.flagView];
        [self.contentView addSubview:self.userNameWithDateLabel];
        [self.contentView addSubview:self.contentLabel];
        
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.backgroundColor=[OColors  OSFRightCellHighlightColor];
        self.contentLabel.textColor=[UIColor lightGrayColor];
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


#pragma  mark --布局
-(void)initConstraints
{
    
    MASAttachKeys(self.flagView, self.userNameWithDateLabel, self.contentLabel, self.contentView);
    
    [self.flagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.mas_equalTo(10);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(50);
        
    }];
    
    
    [self.userNameWithDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.flagView.mas_right).offset(5.0);
        make.top.mas_equalTo(12);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(self.contentView.mas_width).offset(-80);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.userNameWithDateLabel.mas_left);
        make.top.mas_equalTo(self.userNameWithDateLabel.mas_bottom).offset(2);
        make.height.mas_greaterThanOrEqualTo(21);
        make.width.mas_equalTo(self.userNameWithDateLabel.mas_width);
        make.bottom.mas_equalTo(-20).priorityLow();
    }];
    
    
    CGSize size=[self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    self.cellHeight=[NSNumber numberWithFloat:(size.height+1)];
    
    [OLog showMessage:@"question cell height :%f",size.height];
    
}

#pragma mark -- 视图
-(UILabel *)userNameWithDateLabel
{
    if (_userNameWithDateLabel==nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.textColor=[UIColor lightGrayColor];
        label.backgroundColor=[UIColor clearColor];
        label.font=[UIFont systemFontOfSize:13.0];
        
        _userNameWithDateLabel=label;
    }
    return _userNameWithDateLabel;
}

-(UILabel *)contentLabel
{
    if (_contentLabel==nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.textColor=[UIColor blackColor];
        label.backgroundColor=[UIColor clearColor];
        label.font=[UIFont boldSystemFontOfSize:14.0];
        label.numberOfLines=0;
        _contentLabel=label;
    }
    return _contentLabel;
}



-(OSFNumFlagView *)flagView
{
    if (_flagView==nil) {
        
        OSFNumFlagView *fView=[[OSFNumFlagView alloc] initWithFrame:CGRectZero cornerRadius:4.0];
        _flagView=fView;
    }
    
    return _flagView;
}

#pragma mark -- 属性赋值
-(void)numFlagAnswerNum:(NSString *)answerNum questionStatus:(NSInteger)questionStatus
{
    [self initConstraints];
    [self.flagView numFlagAnswerNum:answerNum questionStatus:questionStatus];
}
-(void)setUserName:(NSString *)userName
{
    if (_userName!=userName) {
        _userName=userName;
        
        self.userNameWithDateLabel.text=[NSString stringWithFormat:@"%@ · %@",_userName,self.dateTime];
    }
}
-(void)setDateTime:(NSString *)dateTime
{
    if (_dateTime!=dateTime) {
        _dateTime=dateTime;
        
        self.userNameWithDateLabel.text=[NSString stringWithFormat:@"%@ · %@",self.userName,_dateTime];
    }
}
-(void)setContent:(NSString *)content
{
    if (_content!=content) {
        _content=content;
        
        self.contentLabel.text=_content;
    }
}
@end
