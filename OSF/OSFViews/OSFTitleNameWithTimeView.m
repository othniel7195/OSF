//
//  OSFTitleNameWithTimeView.m
//  OSF
//
//  Created by 赵锋 on 15/7/22.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFTitleNameWithTimeView.h"
#import "OColors.h"
#import "Masonry.h"
@interface OSFTitleNameWithTimeView ()

@property(nonatomic, strong) UILabel *questionTitleLabel;
@property(nonatomic, strong) UILabel * nameWithTimeLabel;

@end

@implementation OSFTitleNameWithTimeView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor=[UIColor lightGrayColor];
        
        [self addSubview:self.questionTitleLabel];
        [self addSubview:self.nameWithTimeLabel];
    }
    return self;
}

-(void)initConstraints
{
    [self.questionTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.mas_equalTo(self).offset(10);
        make.right.mas_equalTo(self).offset(-10);
        make.height.mas_greaterThanOrEqualTo(20);
    }];
    [self.nameWithTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(10);
        make.top.mas_equalTo(self.questionTitleLabel).offset(10);
        make.right.mas_equalTo(self).offset(-10);
        make.bottom.mas_equalTo(self).offset(-10);
    }];
}

-(UILabel *)questionTitleLabel
{
    if (_questionTitleLabel==nil) {
        UILabel *qtl=[[UILabel alloc] init];
        qtl.backgroundColor=[UIColor clearColor];
        qtl.font=[UIFont boldSystemFontOfSize:16.0];
        qtl.textColor=[UIColor blackColor];
        qtl.numberOfLines=0;
        
        _questionTitleLabel=qtl;
    }
    return _questionTitleLabel;
}

-(UILabel *)nameWithTimeLabel
{
    if (_nameWithTimeLabel==nil) {
        UILabel *nwtl=[[UILabel alloc] init];
        nwtl.backgroundColor=[UIColor clearColor];
        nwtl.font=[UIFont systemFontOfSize:14.0];
        
        _nameWithTimeLabel=nwtl;
    }
    return _nameWithTimeLabel;
}

-(void)osfTitle:(NSString *)title name:(NSString *)name time:(NSString *)time
{
    self.questionTitleLabel.text=title;
    
    NSString *nameWithTime=[NSString stringWithFormat:@"%@ · %@",name,time];
    NSMutableAttributedString *nameWithTimeAttr=[[NSMutableAttributedString alloc] initWithString:nameWithTime];
    [nameWithTimeAttr addAttribute:NSForegroundColorAttributeName value:[OColors OSFNavBarColor] range:NSMakeRange(0, name.length)];
    [nameWithTimeAttr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(name.length, nameWithTime.length)];
    
    self.nameWithTimeLabel.attributedText=nameWithTimeAttr;
}

@end
