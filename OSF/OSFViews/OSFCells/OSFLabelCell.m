//
//  HHLabelCell.m
//  HeartHealth
//
//  Created by 赵锋 on 15/7/3.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFLabelCell.h"
#import "Okeys.h"
#import "OColors.h"
@interface OSFLabelCell ()

@property (nonatomic, strong)UIImageView *labelImageView;
@property (nonatomic, strong)UILabel *labelL;
@property (nonatomic, strong, readwrite)NSNumber * cellHeight;
@end

@implementation OSFLabelCell
@synthesize cellHeight=_cellHeight;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor=[OColors OSFLabelCellBackgroundColor];
        [self.contentView addSubview:self.labelImageView];
        [self.contentView addSubview:self.labelL];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCellStatus:) name:cellStatus object:nil];
    }
    return  self;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

#pragma mark -- 布局
-(void)initConstraints
{
    
    [self.labelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@10);
        make.left.mas_equalTo(@80);
        make.size.mas_equalTo(CGSizeMake(30,30));
    }];
    
    [self.labelL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.labelImageView.mas_centerY);
        make.left.mas_equalTo(self.labelImageView.mas_right).offset(15);
        make.height.mas_equalTo(@30.0);
        make.width.mas_greaterThanOrEqualTo(@60.0);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.labelImageView.mas_bottom).offset(10);
    }];
    
    CGSize size=[self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    self.cellHeight=[NSNumber numberWithFloat:(size.height+1.0)];
}

#pragma  mark -- 视图

-(UIImageView *)labelImageView
{
    if (_labelImageView==nil) {
        
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectZero];
        
        _labelImageView=imageView;
    }
    
    return _labelImageView;
}

-(UILabel *)labelL{
    if (_labelL==nil) {
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectZero];
        label.font=[UIFont boldSystemFontOfSize:16.0];
        label.textAlignment=NSTextAlignmentLeft;
        label.textColor=[UIColor lightGrayColor];
        label.backgroundColor=[UIColor clearColor];
        
        _labelL=label;
    }
    
    return _labelL;
}

#pragma mark -- 属性赋值

-(void)setLabelInfo:(NSString *)labelInfo
{
    if (_labelInfo!=labelInfo) {
        _labelInfo=[labelInfo copy];
        
        self.labelL.text=_labelInfo;
    }
}

-(void)setNormalLabelImage:(UIImage *)normalLabelImage
{
    if (_normalLabelImage!=normalLabelImage) {
        _normalLabelImage=normalLabelImage;
        
        self.labelImageView.image=normalLabelImage;
    }
}

#pragma mark --- 通知
-(void)changeCellStatus:(NSNotification  *)noti
{
    
    NSNumber *i=noti.object;
    
    if ([i integerValue]!=self.indexTag) {
        
        //普通状态
        self.labelImageView.image=self.normalLabelImage;
        self.labelL.textColor=[UIColor lightGrayColor];
        self.backgroundColor=[OColors OSFLabelCellBackgroundColor];
        
    }else
    {
        //高亮状态
        self.labelImageView.image=self.selectLabelImage;
        self.labelL.textColor=[UIColor whiteColor];
        UIView *view=[[UIView alloc] initWithFrame:CGRectZero];
        view.backgroundColor=[OColors OSFLabelCellSelectBackgroundColor];
        self.selectedBackgroundView=view;
        self.backgroundColor=[OColors OSFLabelCellSelectBackgroundColor];;
    }
}

#pragma mark --delloc
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:cellStatus object:nil];
}

@end
