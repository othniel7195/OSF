//
//  OSFRefreshView.m
//  OSF
//
//  Created by 赵锋 on 15/7/13.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFRefreshView.h"
#import "OColors.h"
@interface OSFRefreshView ()

@property(nonatomic, strong)UIActivityIndicatorView *activityIndicatorView;
@property(nonatomic, strong)UILabel *activityIndicatorlabel;

@end

@implementation OSFRefreshView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (!self) return nil;
    
    
    
    return self;
}

-(void)updateConstraints
{
    
    [self.activityIndicatorView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.centerX.mas_equalTo(self).offset(-30);
        make.centerY.mas_equalTo(self);
    }];
    
    [self.activityIndicatorlabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.width.mas_lessThanOrEqualTo(200);
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self.activityIndicatorView.mas_right).offset(5);
    }];
    
    [super updateConstraints];
}

#pragma mark -- 视图
-(UIActivityIndicatorView *)activityIndicatorView
{
    if (!_activityIndicatorView) {
        UIActivityIndicatorView *activityIV=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityIV.color=[OColors OSFNavBarColor];
        
        _activityIndicatorView=activityIV;
        
        [self addSubview:_activityIndicatorView];
    }
    
    return _activityIndicatorView;
}

-(UILabel *)activityIndicatorlabel
{
    if (!_activityIndicatorlabel) {
        UILabel *aiv=[[UILabel alloc] initWithFrame:CGRectZero];
        aiv.backgroundColor=[UIColor clearColor];
        aiv.font=[UIFont systemFontOfSize:12.0];
        aiv.textColor=[OColors OSFNavBarColor];
        aiv.text=@"加载数据中...";
        aiv.userInteractionEnabled=YES;
        UITapGestureRecognizer *touchActivityIndicatorlabel=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reloadData)];
        [aiv addGestureRecognizer:touchActivityIndicatorlabel];
        
        _activityIndicatorlabel=aiv;
        
        [self addSubview:_activityIndicatorlabel];
    }
    return _activityIndicatorlabel;
}

#pragma mark -- 属性赋值
-(void)setORefreshInfo:(NSString *)oRefreshInfo
{
    if (oRefreshInfo!=_oRefreshInfo) {
        
        self.activityIndicatorlabel.text=_oRefreshInfo;
    }
}
-(void)setCanTouch:(BOOL)canTouch
{
    self.activityIndicatorlabel.userInteractionEnabled=canTouch;
}

#pragma mark -- 动画
-(void)o_startRefresh
{
    [self.activityIndicatorView startAnimating];
}
-(void)o_endRefresh
{
    [self.activityIndicatorView stopAnimating];
}

#pragma mark -- action
-(void)reloadData
{
    if ([self.delegate respondsToSelector:@selector(OSFRefreshViewReloadData)]) {
        [self.activityIndicatorView startAnimating];
        self.oRefreshInfo=@"加载数据中...";
        [self.delegate OSFRefreshViewReloadData];
    }
}
@end
