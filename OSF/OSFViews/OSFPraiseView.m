//
//  OSFPraiseView.m
//  OSF
//
//  Created by 赵锋 on 15/7/9.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFPraiseView.h"
#import "OColors.h"
@interface OSFPraiseView ()

///赞的的背景图片
@property(nonatomic, strong)UIImageView *praiseImageView;
///赞的标签label
@property(nonatomic, strong)UILabel *praiseLabel;

@end

@implementation OSFPraiseView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        [self addSubview:self.praiseImageView];
        [self addSubview:self.praiseLabel];
        
        [self initConstraints];
    }
    return self;
}

#pragma mark --布局
-(void)initConstraints
{
    [self.praiseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [self.praiseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).insets(UIEdgeInsetsMake(0, 25, 0, 0));
    }];
}

#pragma mark -- 视图
-(UIImageView *)praiseImageView
{
    if (_praiseImageView==nil) {
        UIImageView *praiseImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_up_count_big"]];
        
        _praiseImageView=praiseImageView;
    }
    return _praiseImageView;
}

-(UILabel *)praiseLabel
{
    if (_praiseLabel==nil) {
        UILabel *praiseLabel=[[UILabel alloc] init];
        praiseLabel.backgroundColor=[UIColor clearColor];
        praiseLabel.textColor=[OColors OSFPraiseColor];
        praiseLabel.textAlignment=NSTextAlignmentCenter;
        
        _praiseLabel=praiseLabel;
    }
    return _praiseLabel;
}

#pragma mark --属性赋值
-(void)setPraiseNum:(NSString *)praiseNum
{
    if (_praiseNum!=praiseNum) {
        _praiseNum=praiseNum;
        
        self.praiseLabel.text=_praiseNum;
    }
}

@end
